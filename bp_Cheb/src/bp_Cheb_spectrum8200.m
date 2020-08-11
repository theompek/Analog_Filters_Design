%To parakatw script dhmiourgei ta fasmata eisodou kai 
%e3odou ton shmatwn tou filtrou band pass ?hebyshev
clear 
close all;
%Prodiagrafes filtrou
f0 =  0.9e3;  % 0.9KHz
f1 = 0.65e3;  % 0.65KHz
f2 = 1.246e3; % 1.246KHz
f3 = 0.458e3; % 0.458KHz
f4 = 1.768e3; % 1.768KHz
amin = 28 ;   % 28 dB
amax = 0.5 ;  % 0.5 dB

%Kerdos monadas xwris enisxush Q(Q enhancement)
GainT = @(Q,wi,w) sqrt((2*Q*wi*w)^2/((wi^2 - w^2)^2 + ((wi*w/Q)^2)));

%Kerdos monadas me enisxush Q(Q enhancement)
GainT_QEnh = @(k,R1,C1,Q,wi,w) (k*w/((k-1)*R1*C1))/(sqrt((wi^2 - w^2)^2 + (wi*w/Q)^2));

%Dhmiourgia prwths va8mhdas 
w0 = 4912.154; 
Q =  3.6;
Tbp1 = tf([-2*Q*w0 0],[1 w0/Q w0^2]);
%Ru8m?sh kerdous
Gain_Tbp1 = GainT(Q,w0,2*pi*f0);
Tbp1 = Tbp1/Gain_Tbp1;

%Dhmiourgia deuterhs va8mhdas
w0 = 6503.278; 
Q = 3.6;
Tbp2 = tf([-2*Q*w0 0],[1 w0/Q w0^2]);
%Ru8mhsh kerdous
Gain_Tbp2 = GainT(Q,w0,2*pi*f0);
Tbp2 = Tbp2/Gain_Tbp2;

%Dhmiourgia triths va8mhdas 
w0 = 4059.478; 
Q =  9.084;
b=1;
k = 1.5291;
R1 = 1e8/w0; %R1=km
C1 = 1e-8 ; %0.01uF
Hd3 = k*b/(2*(k-1)-b);
Tbp3 = tf([Hd3*w0/Q 0],[1 w0/Q w0^2]);
%Ru8m8sh kerdous
Gain_Tbp3 = GainT_QEnh(k,R1,C1,Q,w0,2*pi*f0);
Tbp3 = Tbp3/Gain_Tbp3;

%Dhmiourgia tetarths va8mhdas 
w0 = 7869.263; 
Q =  9.084;
b=1;
k = 1.5291;
R1 = 1e8/w0; %R1=km
C1 = 1e-8 ; %0.01uF
Hd4 = k*b/(2*(k-1)-b);
Tbp4 =  tf([Hd4*w0/Q 0],[1 w0/Q w0^2]);
%Ru8m?sh kerdous
Gain_Tbp4 = GainT_QEnh(k,R1,C1,Q,w0,2*pi*f0);
Tbp4 = Tbp4/Gain_Tbp4;

%Sunolikh Sunarthsh Metaforas
T_BP = series(series(series(Tbp1,Tbp2),Tbp3),Tbp4);

%%
%The period signal according to instructions
f = @(t) cos(2*pi*(f0-(f0-f1)/2)*t) + 0.8*cos(2*pi*(f0+(f0+f1)/3)*t)...
    +0.8*cos(2*pi*0.4*f3*t)+0.6*cos(2*pi*2.5*f4*t)+0.5*cos(2*pi*3*f4*t);

%Generate the signal
Fs = 12e3;  %Sampling frequency
Tf = 1/Fs;  %Sampling period
Td = 1;  %Signal duration
t = 0:Tf:Td ;
u = f(t);

L = length(t)-1; %Length of signal
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 
%and the even-valued signal length L.
U = fft(u);
P2 = abs(U/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%Plot input spectrum on the Decibel scale
figure(1);
g = Fs*(0:(L/2))/L;
plot(g,20*log10(P1)) 
title('Single-Sided Amplitude Spectrum of input(AEM:8200)')
xlabel('f (Hz)')
ylabel('Decibel')


%%
%Output of low pass Inverse Chebyshev filter
y=lsim(T_BP,u,t);
%We follow the same procedure as before
Y = fft(y);
D2 = abs(Y/L);
D1 = D2(1:L/2+1);
D1(2:end-1) = 2*D1(2:end-1);

%Plot input spectrum on the Decibel scale
figure(2);
plot(g,20*log10(D1)) 
title('Single-Sided Amplitude Spectrum of filter output (AEM:8200)')
xlabel('f (Hz)')
ylabel('Decibel')

