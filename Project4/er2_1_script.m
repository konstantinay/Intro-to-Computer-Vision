clear; close all; clc

template = imread('cameraman.tif');
%imshow(template)

%shearing to create template image
tmatrix = [1 0 0; 0.4 1 0; 0 0 1];
tform = affine2d(tmatrix);
image = imwarp(template, tform, 'cubic', 'FillValues', 255);
imshow(image)

%apply ecc_lk_alignment function
[results, results_lk, MSE, rho, MSELK, time]= ecc_lk_alignment(image, template, 3 , 10, 'affine', eye(2,3));


