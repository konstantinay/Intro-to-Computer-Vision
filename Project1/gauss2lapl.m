close all; clear all; clc

h = 1/16 * [1 4 6 4 1];

n = 256;
n1 = 1:n;
x = 3 + 4*sin(2*pi*n1/128) + cos(2*pi*n1/10+pi/4);
G{1} = x';

for i=1:3    
    en = [1 zeros(1,n-1)];
    hn = [h zeros(1,n-5)];
    T = toeplitz(1/16*en,hn');
    
    yk = T*G{i};

    n=n/2;
    I = eye(n);
    G{i+1} = kron(I,[1 0])*yk;
end

for i=1:3
    G1 = upsample(G{i+1},2);
    L{i} = G{i} - G1;
end
L{i+1}=G{i+1};

G2{i+1} = L{i+1};
for i = 3:-1:1 
    G1 = upsample(G2{i+1},2); 
    G2{i} = L{i} + G1; 
end 

figure
hold on
for i=1:4
   subplot(4,1,i);
   plot(L{i}); 
   sgtitle('Laplacian from Gaussian pyramid')
end

figure
hold on
for i=1:4
   subplot(4,1,i);
   plot(G2{i}); 
   sgtitle('Gaussian from Laplacian pyramid')
end



