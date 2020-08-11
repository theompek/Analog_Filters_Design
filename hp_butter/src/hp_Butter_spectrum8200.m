%To parakatw script dhmiourgei ta fasmata eisodou kai 
%e3odou ton shmatwn tou filtrou band pass ?hebyshev
clear 
close all;
%Prodiagrafes filtrou
fp =  5e3;  % 5KHz
fs = 1.9231e3;  % 1.9231KHz
amin = 24 ;   % 24 dB
amax = 0.5 ;  % 0.5 dB

%Suxnothta hmiseias isxuos sto kanoniko filtro
w0 = 25456.111103;

%Dhmiourgia prwths va8mhdas(anwdiabato CR)
H1 = 1;
Thp1 = tf([1 0],[1 w0]);

%Dhmiourgia deuterhs va8mhdas(Sallen-Key)
H2 = 1.3819; 
Q = 0.618;
Thp2 = tf([1 0 0],[1 w0/Q w0^2]);
%Kerdos twn upshlwn syxnothtwn
Thp2 = H2*Thp2;

%Dhmiourgia deuterhs va8mhdas(Sallen-Key)
H3 = 2.3819; 
Q = 1.618;
Thp3 = tf([1 0 0],[1 w0/Q w0^2]);
%Kerdos twn upshlwn syxnothtwn
Thp3 = H3*Thp3;

%Sunolikh Sunarthsh Metaforas
T_HP = series(series(Thp1,Thp2),Thp3);


%Sunarthsh Metaforas meta thn ru8mhsh kerdous sta 10dB
T_HP = 0.960721*T_HP;

%%
%The period signal according to instructions
f = @(t) cos(2*pi*0.2*fs*t) + 0.6*cos(2*pi*0.7*fs*t)...
    +1.5*cos(2*pi*1.6*fp*t)+0.7*cos(2*pi*2.4*fp*t)+0.4*cos(2*pi*3.5*fp*t);

%Generate the signal
Fs = 40e3;  %Sampling frequency
Tf = 1/Fs;  %Sampling period
Td = 0.1;  %Signal duration
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
y=lsim(T_HP,u,t);
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

