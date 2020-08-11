%To programa auto dhmiourgei tis sunarthseis metaforas ka8e ba8mhdas
%kai dhmiourgei ta antistoixa diagramata apokrishs me xrhsh ths plot_transfer_function
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
plot_transfer_function(Thp1,[fs fp]);

%Dhmiourgia deuterhs va8mhdas(Sallen-Key)
H2 = 1.3819; 
Q = 0.618;
Thp2 = tf([1 0 0],[1 w0/Q w0^2]);
%Kerdos twn upshlwn syxnothtwn
Thp2 = H2*Thp2;
plot_transfer_function(Thp2,[fs fp]);


%Dhmiourgia deuterhs va8mhdas(Sallen-Key)
H3 = 2.3819; 
Q = 1.618;
Thp3 = tf([1 0 0],[1 w0/Q w0^2]);
%Kerdos twn upshlwn syxnothtwn
Thp3 = H3*Thp3;
plot_transfer_function(Thp3,[fs fp]);

%Sunolikh Sunarthsh Metaforas
T_HP = series(series(Thp1,Thp2),Thp3);


%Sunarthsh Metaforas meta thn ru8mhsh kerdous sta 10dB
T_HP = 0.960721*T_HP;
plot_transfer_function(T_HP,[fs fp 10e3]);

%Inverse system gia thn aposvesh
InvT_HP = inv(T_HP);
plot_transfer_function(InvT_HP,[fs fp 10e3]);

%%
%Ru8mhsh kerdous sta 0dB
T_HP = T_HP/(3.2916*0.960721);
plot_transfer_function(T_HP,[fs fp w0/(2*pi) 10e3]);

%Inverse system gia thn aposvesh
InvT_HP = inv(T_HP);
plot_transfer_function(InvT_HP,[fs fp w0/(2*pi) 10e3]);


fprintf('Prodiagrafes:\n fs= %d Hz\n fp= %d Hz\n amax = %1.1f dB\n amin = %d dB\n',fs,fp,amax,amin);