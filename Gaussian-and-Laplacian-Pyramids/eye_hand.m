close all;clear all; clc

maska = im2double(imread('eye_mask.png'));
woman = im2double(imread('woman.png'));
hand = im2double(imread('hand.png')); 
woman = imresize(woman,size(maska));
hand  = imresize(hand ,size(maska));

level = 3;
lwoman = genPyr(woman,'lap',level); 
lhand = genPyr(hand,'lap',level);

maskb=1-maska;

B = cell(1,level); 
for p = 1:length(lwoman)
	[Mp Np ~] = size(lwoman{p});
	maskap = imresize(maska,[Mp Np]);
	maskbp = imresize(maskb,[Mp Np]);
	B{p} = lwoman{p}.*maskap + lhand{p}.*maskbp;
end
imgo = pyrReconstruct(B);
figure,imshow(imgo)