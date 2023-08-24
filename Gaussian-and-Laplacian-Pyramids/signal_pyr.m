close all; clear all; clc

h = 1/16 * [1 4 6 4 1];

n = 256;
n1 = 1:n;
x = 3 + 4*sin(2*pi*n1/128) + cos(2*pi*n1/10+pi/4);
xk{1} = x';

figure
hold on
subplot(2,2,1);
plot(x); title('Random 1D input signal')

for i=1:3
    
    en = [1 zeros(1,n-1)];
    hn = [h zeros(1,n-5)];
    T = toeplitz(1/16*en,hn');
    
    yk = T*xk{i};

    n=n/2;
    I = eye(n);
    xk{i+1} = kron(I,[1 0])*yk;
    
    subplot(2,2,i+1);
    plot(xk{i+1}); title(sprintf('Level of Gaussian Pyramid = %s',num2str(i)))
end
hold off
