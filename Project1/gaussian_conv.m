close all;clear; clc

h=1/16 * [1 4 6 4 1];
h1=h;

figure
hold on
subplot(3,2,1);
plot(h); title('Num of convs = 0')

y=1;

for i=1:2:10
    h1 = conv(h,h1);    
    y=y+1;
    subplot(3,2,y)
    plot(h1); title(sprintf('Num of convs = %s',num2str(i)))
end

hold off