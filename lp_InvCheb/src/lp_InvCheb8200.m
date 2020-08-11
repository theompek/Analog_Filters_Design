%Prodiagrafes filtrou
f1 = 4.4*10^3;  % 4.4KH
f2 = 9.24*10^3; % 9.24KH 
amax = 0.35;    % 0.35dB
amin = 20;      % 20dB

%Dhmiourgia prwths va8mhdas LPN Boctor filter
s = tf('s');
wz = 62802.6221;
w0 = 46978.6592;
Q = 1.9687;
H1 = 0.7585;
T1 = H1*(s^2+wz^2)/(s^2+(w0/Q)*s+w0^2);
plot_transfer_function(T1,[0 f1 f2 10^6]);

%Dhmiourgia deuterhs va8mhdas LPN Boctor filter
wz = 151630.3537;
w0 = 64137.2431;
Q = 0.5972;
H2 = 0.3848;
T2 = H2*(s^2+wz^2)/(s^2+(w0/Q)*s+w0^2);
plot_transfer_function(T2,[0 f1 f2 10^6]);

%Sunolikh Sunarthsh Metaforas
T_LP = series(T1,T2);
%Dior8wsh kerdous
K = 0.342; 
T_LP = K*T_LP;
plot_transfer_function(T_LP,[0 f1 f2 10^6]);

%Inverse system gia thn aposvesh
InvT_LP = inv(T_LP);
plot_transfer_function(InvT_LP,[0 f1 44903/(2*pi) f2 10^6]);

fprintf('Prodiagrafes:\n f1 = 4.4KHz\n f2 = 9.24KHz\n amax = 0.35dB\n amin = 20dB\n');
