%To programa auto dhmiourgei tis sunarthseis metaforas ka8e ba8mhdas
%kai dhmiourgei ta antistoixa diagramata apokrishs me xrhsh ths plot_transfer_function
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
plot_transfer_function(Tbp1,[f3 f1 f0 f2 f4]);

%Dhmiourgia deuterhs va8mhdas
w0 = 6503.278; 
Q = 3.6;
Tbp2 = tf([-2*Q*w0 0],[1 w0/Q w0^2]);
%Ru8m?sh kerdous
Gain_Tbp2 = GainT(Q,w0,2*pi*f0);
Tbp2 = Tbp2/Gain_Tbp2;
plot_transfer_function(Tbp2,[f3 f1 f0 f2 f4]);

%Dhmiourgia triths va8mhdas 
w0 = 4059.478; 
Q =  9.084;
b=1;
k = 1.5291;
R1 = 1e8/w0; %R1=km
C1 = 1e-8 ; %0.01uF
Hd3 = k*b/(2*(k-1)-b);
Tbp3 = tf([Hd3*w0/Q 0],[1 w0/Q w0^2]);
%Ru8m?sh kerdous
Gain_Tbp3 = GainT_QEnh(k,R1,C1,Q,w0,2*pi*f0);
Tbp3 = Tbp3/Gain_Tbp3;
plot_transfer_function(Tbp3,[f3 f1 f0 f2 f4]);

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
plot_transfer_function(Tbp4,[f3 f1 f0 f2 f4]);


%Sunolikh Sunarthsh Metaforas
T_BP = series(series(series(Tbp1,Tbp2),Tbp3),Tbp4);
plot_transfer_function(T_BP,[f3 f1 f0 f2 f4]);

%Inverse system gia thn aposvesh
InvT_BP = inv(T_BP);
plot_transfer_function(InvT_BP,[f3 f1 f0 f2 f4]);


fprintf('Prodiagrafes:\n f3= %d Hz\n f1= %d Hz\n f0= %d Hz\n f2= %d Hz\n f4= %d Hz\n amax = %1.1f dB\n amin = %d dB\n',f3,f1,f0,f2,f4,amax,amin);