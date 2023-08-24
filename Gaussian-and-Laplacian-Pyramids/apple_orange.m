close all;clear all; clc

apple = im2double(imread('apple1.jpg'));
orange = im2double(imread('orange1.jpg')); 
apple = imresize(apple,[size(orange,1) size(orange,2)]);
[M N, ~] = size(apple);

v = 210;
level = 5;

maska = zeros(size(apple));
maska(:,1:v,:) = 1;
maskb = 1-maska;
figure; imshow(maska)

gmaska = genPyr(apple,'gauss',level);

lapple = genPyr(apple,'lap',level); 
lorange = genPyr(orange,'lap',level);

B = cell(1,level); 
for p = 1:level
	[Mp Np ~] = size(lapple{p});
	maskap = imresize(maska,[Mp Np]);
	maskbp = imresize(maskb,[Mp Np]);
	B{p} = lapple{p}.*maskap + lorange{p}.*maskbp;
end
imgo = pyrReconstruct(B);
figure,imshow(imgo) 