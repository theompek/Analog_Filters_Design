%To parakatw script dhmiourgei ta fasmata eisodou kai 
%e3odou ton shmatwn tou filtrou band elimination Chebyshev
clear 
close all;
%Prodiagrafes filtrou
f0 =  2.5e3;  % 2.5KHz
f1 = 1.65e3;  % 1.65KHz
f2 = 3.788e3; % 3.788KHz
f3 = 2.109e3; % 2.109KHz
f4 = 2.964e3; % 2.964KHz
amin = 26 ;   % 26  dB
amax = 0.5 ;  % 0.5 dB

%Dhmiourgia prwths va8mhdas 
w0 = 9176.270726;
wz = 15700;
Q =  1.127716;
Tbe1 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H1 = 0.460590;
Tbe1 = H1*Tbe1;

%Dhmiourgia deuterhs va8mhdas
w0 = 26861.674787;
wz = 15700;
Q =  1.127716;
Tbe2 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H2 = 2;
Tbe2 = H2*Tbe2;

%Dhmiourgia triths va8mhdas 
w0 = 10536.958394;
wz = 15700;
Q =  7.662751;
Tbe3 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H3 = 0.663702;
Tbe3 = H3*Tbe3;

%Dhmiourgia tetarths va8mhdas 
w0 = 23392.898670;
wz = 15700;
Q =  7.662751;
Tbe4 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H4 = 2.208398;
Tbe4 = H4*Tbe4;

%Sunolikh Sunarthsh Metaforas
T_BE = series(series(series(Tbe1,Tbe2),Tbe3),Tbe4);

%Ru8mhsh kerdous wste 0dB stis xamhles suxnothtes
Htotal = 1.3501;
T_BE = T_BE/Htotal;

%%
%The period signal according to the instructions
f = @(t) 0.5*cos(2*pi*(f0-(f0-f3)/2)*t) + 0.8*cos(2*pi*(f0+(f0+f3)/3)*t)...
    +0.8*cos(2*pi*0.4*f1*t)+0.6*cos(2*pi*2.5*f2*t)+1.2*cos(2*pi*3*f2*t);

%Generate the signal
Fs = 24e3;  %Sampling frequency
Tf = 1/Fs;  %Sampling period
Td = 5;  %Signal duration
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
y=lsim(T_BE,u,t);
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

