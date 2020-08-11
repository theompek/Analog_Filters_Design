%Dhmiourgia prwths va8mhdas LPN Boctor filter
s = tf('s');
wz = 62802.6221;
w0 = 46978.6592;
Q = 1.9687;
H1 = 0.7585;
T1 = H1*(s^2+wz^2)/(s^2+(w0/Q)*s+w0^2);

%Dhmiourgia deuterhs va8mhdas LPN Boctor filter
wz = 151630.3537;
w0 = 64137.2431;
Q = 0.5972;
H2 = 0.3848;
T2 = H2*(s^2+wz^2)/(s^2+(w0/Q)*s+w0^2);

%Sunolikh Sunarthsh Metaforas
T_LP = series(T1,T2);
%Dior8wsh kerdous
K = 0.342; 
T_LP = K*T_LP;

%Generate a square wave with period 1/2KHz = 0.5ms,duration Td, and sampling every Tf.
Tu = 5e-4;  %Square wave period,2KHz as it is requared
Fs = 36e3;  %Sampling frequency 
Tf = 1/Fs;  %Sampling period
Td = 0.1;  %Signal duration 
[u,t] = gensig('square',Tu,Td,Tf);

L = length(t)-1; %Length of signal
%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 
%and the even-valued signal length L.
U = fft(u);
P2 = abs(U/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%Plot input spectrum on the Decibel scale
figure(1);
f = Fs*(0:(L/2))/L;
plot(f,20*log10(P1)) 
title('Single-Sided Amplitude Spectrum of square wave (AEM:8200)')
xlabel('f (Hz)')
ylabel('Decibel')


%%
%Output of low pass Inverse Chebyshev filter
y=lsim(T_LP,u,t);
%We follow the same procedure as before
Y = fft(y);
D2 = abs(Y/L);
D1 = D2(1:L/2+1);
D1(2:end-1) = 2*D1(2:end-1);

%Plot input spectrum on the Decibel scale
figure(2);
plot(f,20*log10(D1)) 
title('Single-Sided Amplitude Spectrum of filter output (AEM:8200)')
xlabel('f (Hz)')
ylabel('Decibel')

