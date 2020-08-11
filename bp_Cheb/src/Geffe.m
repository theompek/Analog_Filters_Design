%To spript ektelei tis pra3ei tou algori8mu Geffe

w0 = 5652; %kentrikh syxnothta 
bw = 3743; %Bandwith w2-w1
%Migadikoi syzhgeis poloi -S2+-jW2
S2 = 0.1754;
W2 = 1.0163;

%Geffe algorithm
qc = w0 / bw ;
C = S2^2+W2^2;
D = 2*S2/qc;
E = 4+C/(qc^2);
G = sqrt(E^2-4*D^2);
Q = sqrt(0.5*(E+G))/D;
k = S2*Q/qc;
W = k+sqrt(k^2-1);
w02 = W*w0;
w01 = w0/W;


fprintf('qc = %f\n',qc);
fprintf('C = %f\n',C);
fprintf('D = %f\n',D);
fprintf('E = %f\n',E);
fprintf('G = %f\n',G);
fprintf('Q = %f\n',Q);
fprintf('k = %f\n',k);
fprintf('W = %f\n',W);
fprintf('w02 = %f\n',w02);
fprintf('w01 = %f\n',w01);

