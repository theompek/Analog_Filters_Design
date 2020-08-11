%To programa auto kataskeuazei tis sunarthseis metaforas ka8e ba8mhdas
%kai dhmiourgei ta antistoixa diagramata apokrishs me xrhsh ths plot_transfer_function
clear 
close all;
%Prodiagrafes filtrou
f0 =  2.5e3;  % 2.5KHz
f1 = 1.65e3;  % 1.65KHz
f2 = 3.788e3; % 3.788KHz
f3 = 2.109e3; % 2.109KHz
f4 = 2.964e3; % 2.964KHz
amin = 26 ;   % 26 dB
amax = 0.5 ;  % 0.5 dB

%Dhmiourgia prwths va8mhdas 
w0 = 9176.270726;
wz = 15700;
Q =  1.127716;
Tbe1 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H1 = 0.460590;
Tbe1 = H1*Tbe1;
plot_transfer_function(Tbe1,[f3 f1 f0 f2 f4]);

%Dhmiourgia deuterhs va8mhdas
w0 = 26861.674787;
wz = 15700;
Q =  1.127716;
Tbe2 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H2 = 2;
Tbe2 = H2*Tbe2;
plot_transfer_function(Tbe2,[f3 f1 f0 f2 f4]);

%Dhmiourgia triths va8mhdas 
w0 = 10536.958394;
wz = 15700;
Q =  7.662751;
Tbe3 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H3 = 0.663702;
Tbe3 = H3*Tbe3;
plot_transfer_function(Tbe3,[f3 f1 f0 f2 f4]);


%Dhmiourgia tetarths va8mhdas 
w0 = 23392.898670;
wz = 15700;
Q =  7.662751;
Tbe4 = tf([1 0 wz^2],[1 w0/Q w0^2]);
%Kerdos Hh upshlwn suxnothtwn
H4 = 2.208398;
Tbe4 = H4*Tbe4;
plot_transfer_function(Tbe4,[f3 f1 f0 f2 f4]);


%Sunolikh Sunarthsh Metaforas
T_BE = series(series(series(Tbe1,Tbe2),Tbe3),Tbe4);
%Ru8mhsh kerdous wste 0dB stis xamhles suxnothtes
Htotal = 1.3501;
T_BE = T_BE/Htotal;
plot_transfer_function(T_BE,[f3 f1 f0 f2 f4]);

%Inverse system gia thn aposvesh
InvT_BE = inv(T_BE);
plot_transfer_function(InvT_BE,[f3 f1 f0 f2 f4]);


fprintf('Prodiagrafes:\n f3= %d Hz\n f1= %d Hz\n f0= %d Hz\n f2= %d Hz\n f4= %d Hz\n amax = %1.1f dB\n amin = %d dB\n',f3,f1,f0,f2,f4,amax,amin);