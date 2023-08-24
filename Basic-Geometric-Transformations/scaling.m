clear; close all; clc

%read image and display
I = imread('saturn.jpg','jpg');
[M, N] = size(I);
%figure, imshow(I)

%create the scaled images to use for composition
t1 = [1/4, 0, 0; 0, 1/4, 0; 0, 0 ,1];
t2 = [1/6, 0, 0; 0, 1/6, 0; 0, 0 ,1];
t3 = [1/8, 0, 0; 0, 1/8, 0; 0, 0 ,1];

tform1 = affine2d(t1);
tform2 = affine2d(t2);
tform3 = affine2d(t3);

image1 = imwarp(I, tform1);
[m1, n1] = size(image1);
image2 = imwarp(I, tform2);
[m2, n2] = size(image2);
image3 = imwarp(I, tform3);
[m3, n3] = size(image3);

%create the final image
final = I;
final(1:m1, 1:n1) = image1;
final(M-m1+1:M, N-n1+1:N) = image1;
final(60:60+m2-1, 295:295+n2-1) = image2;
final((M-40)-m3+1:M-40, 480:480+n3-1) = image3;
final(M-m3+1:M, 30:30+n3-1) = image3;
final(300:300+m3-1, 10:10+n3-1) = image3;
figure, imshow(final), title('Composition of scaled images')

















