%Mege8oi susthmatos
w0 = 10536.958394;
WWz = 15700  ;
Q = 7.662751;
k1 = 0.9; %prepei mn<k1<1
ws=1; 
C = 1e-8 ; %zhtoumenos puknoths


%%
%Stratigikh
mn = (w0^2)/(WWz^2);
wz = WWz/w0;
R1 = 2/(k1*wz^2 -1); %gia w0=1
R2 = 1/(1-k1);
R3 = (k1/(Q^2) + k1*(wz^2) -1)/2 ;
R4 = 1/k1;
R5 = 1;
R6 = 1; 
C1 = k1/(2*Q);
C2 = 2*Q;

%Kerdos upshles syxnothtes
kh = R5/(R3+R5);

%Kerdos xamhles syxnothtes
kl = kh/mn;

fprintf('mn = %f\n',mn);
fprintf('k1 = %f\n',k1);
fprintf('wz = %f\n',wz);
fprintf('R1 = %f\n',R1);
fprintf('R2 = %f\n',R2);
fprintf('R3 = %f\n',R3);
fprintf('R4 = %f\n',R4);
fprintf('R5 = %f\n',R5);
fprintf('R6 = %f\n',R6);
fprintf('C1= %f\n',C1);
fprintf('C2= %f\n',C2);
fprintf('kerdos upshles kh = %f\n',kh);
fprintf('kerdos xamhles kl = %f\n',kl);

%klimakopoihsh
kf = w0*ws;
km = C1/(kf*C);

R1 = R1*km;
R2 = R2*km;
R3 = R3*km;
R4 = R4*km;
R5 = km;
R6 = km; 
C1 = C;
C2 = C2/(kf*km);

%Klimakopoihmena
fprintf('Klimakopoihmena:\n\n');
fprintf('km = %f\n',km);
fprintf('R1 = %f\n',R1);
fprintf('R2 = %f\n',R2);
fprintf('R3 = %f\n',R3);
fprintf('R4 = %f\n',R4);
fprintf('R5 = %f\n',R5);
fprintf('R6 = %f\n',R6);
fprintf('C1= %e\n',C1);
fprintf('C2= %e\n',C2);


