clear; close all; clc

%diavazoume tis eikones kai tis metatrepoume se grayscale
%pollaplasiazoume me 0.5 gia na fainontai ta pania opws sto video
windmill = 0.5*rgb2gray(imread('windmill.png'));
wback = rgb2gray(imread('windmill_back.jpeg'));
mask = rgb2gray(imread('windmill_mask.png'));

%vriskoume to kentro ths background image
center_x = 480;
center_y = 640;

%antistrefoume th maska
newmask = 255-mask;
%imshow(newmask)

%gia na krathsoume mono ta pania se mayro background
sails = windmill + mask;
newsails = 255 - sails;
%imshow(newsails)

dg = 0; %angle degree
for i = 1:360
    
    %rotation    
    rot_matrix = [cosd(dg), -sind(dg), 0; sind(dg), cosd(dg), 0; 0, 0, 1];
    tform = affine2d(rot_matrix);
    
    rotated_mask = imwarp(newmask, tform, 'cubic');
    rotated_sails = imwarp(newsails, tform, 'cubic');
    
    %vriskoume to megethos ths maskas ara to kentro apo ta pterygia
    [m, n] = size(rotated_mask);    
    center_mask = floor(n/2);
    
    %antistoixa an to ypsos einai artio h peritto
    j=0;
    if (mod(n, 2) ~= 0) 
        j=1;
    end
    
    %pername prwta to background, meta th maska kai meta ta pterygia 
    transf_windmill(:,:,i) = wback;
    %ypologizoume tis diastaseis - diaforetikes se kathe rotation
    x = center_x - center_mask;
    X = center_x + center_mask;
    y = center_y - center_mask;
    Y = center_y + center_mask;
    transf_windmill(x:X-1+j, y:Y-1+j, i) = transf_windmill(x:X-1+j, y:Y-1+j, i)...
        + rotated_mask - rotated_sails;
    
    dg = dg + 1;
end

implay(transf_windmill, 50);









