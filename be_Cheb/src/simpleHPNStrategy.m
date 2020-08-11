%To script entelei tis pra3eis ths strathgikh sxediashs twn 
%aplwn filtrwn HPN (gia thn monada 4) 

clear;
clc;
%Prodiagrafes
w0 =23392.898;
wz = 15700;
Q = 7.662;
Cdes = 1e-8; %epi8umhtos piknwths

%%
%Stratigikh
mn = w0^2/wz^2; %boh8htikh metavlhth
k1 = mn - 1;
ss = (2+k1)*Q;  %boh8htikh metavlhth
k2 = ss*Q/(ss*Q+1);
k  = k2*mn;
R1 = 1;
R2 = ss^2;
R3 = 1;
R4 = ss*Q;
C  = 1/ss;
C1 = k1*C;

%Kerdos upshles syxnothtes
kh = k;

%Kerdos xamhles syxnothtes
kl = k2;

fprintf('(wz/wo)^2 = %f\n',1/mn);
fprintf('mn = %f\n',mn);
fprintf('k1 = %f\n',k1);
fprintf('k2 = %f\n',k2);
fprintf('k = %f\n',k);
fprintf('R1 = %f\n',R1);
fprintf('R2 = %f\n',R2);
fprintf('R3 = %f\n',R3);
fprintf('R4 = %f\n',R4);
fprintf('C= %f\n',C);
fprintf('C1= %f\n',C1);
fprintf('kerdos upshles kh = %f\n',kh);
fprintf('kerdos xamhles kl = %f\n\n',kl);

%klimakopoihsh
kf = w0;
km = C/(kf*Cdes);

R1 = R1*km;
R2 = R2*km;
R3 = R3*km;
R4 = R4*km;
C = Cdes;
C1 = C1/(kf*km);

%Klimakopoihmena
fprintf('Klimakopoihmena:\n');
fprintf('km = %f\n',km);
fprintf('R1 = %f\n',R1);
fprintf('R2 = %f\n',R2);
fprintf('R3 = %f\n',R3);
fprintf('R4 = %f\n',R4);
fprintf('C= %e\n',C);
fprintf('C1= %e\n',C1);








