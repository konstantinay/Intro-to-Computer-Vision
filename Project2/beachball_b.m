close all; clear; clc

%diavazoume oles tis eikones se aspro mavro
ball = rgb2gray(imread('ball.jpg'));
mask = rgb2gray(imread('ball_mask.jpg'));
beach = rgb2gray(imread('beach.jpg'));

[M, N] = size(beach);

%kratame mono th mpala se mauro background
maskedball = ball - mask;

%theoroume th diastash ths mpalas ish me 120x120, ara 120/800=0.15
scx = .15; 
scy = .15; 

%angle degree
dg = 0; 

%starting point ths mpalas sthn telikh eikona
pos_x = 700;
%550 - floor(abs(exp(-i/120)*300*sin((2*pi*i/100)-90))) gia i=0
pos_y = 282;

%scaling
sc_matrix = [scx, 0, 0; 0, scy, 0; 0, 0, 1];
tform = affine2d(sc_matrix);
new_ball = imwarp(maskedball, tform, 'FillValues', 0);
new_mask = imwarp(mask, tform, 'FillValues', 255);

%peristrofh kai topothetish - dhmiourgia akolouthias eikonwn
for i = 1:320
    
    %scaling
    sc_matrix = [scx, 0, 0; 0, scy, 0; 0, 0, 1];
    tform = affine2d(sc_matrix);
    new_ball = imwarp(maskedball, tform, 'FillValues', 0);
    new_mask = imwarp(mask, tform, 'FillValues', 255);
    
    %rotation
    rot_matrix = [cos(dg), -sin(dg), 0; sin(dg), cos(dg), 0; 0, 0, 1];
    tform = affine2d(rot_matrix);
    
    rot_ball = imwarp(new_ball, tform, 'FillValues', 0);
    rot_mask = imwarp(new_mask, tform, 'FillValues', 255);
    
    [rbm, rbn] = size(rot_ball);
    [rmm, rmn] = size(rot_mask);
 
    %dior8wsh megethous
 	rot_ball = imcrop(rot_ball,[(rbm-size(new_ball,1))/2 (rbn-size(new_ball,2))/2 120 120]);
    rot_mask = imcrop(rot_mask,[(rmm-size(new_mask,1))/2 (rmn-size(new_mask,2))/2 120 120]);

    %ypologizoume tis diastaseis - diaforetikes se kathe rotation
    padded_ball = padarray(rot_ball, [pos_y pos_x], 0, 'pre');
    padded_ball = padarray(padded_ball, [M-size(padded_ball,1) N-size(padded_ball,2)], 0, 'post');

    padded_mask = padarray(rot_mask, [pos_y pos_x],255,'pre');
    padded_mask = padarray(padded_mask,[M-size(padded_mask,1) N-size(padded_mask,2)], 255, 'post');

    %pername prwta to background, meta th maska kai meta th mpala 
    inv_mask = 255 - padded_mask;
    transf_beach(:, :, i) = beach - inv_mask + padded_ball;

    %aukshsh toy theta - afairoume gia na kanei rotate h mpala opws sto
    %video
    dg = dg - .05;
    
    %f8inoysa metatopish kata ton aksona y
    pos_y = 550 - floor(abs(exp(-i/120)*300*sin((2*pi*i/100)-90))) - floor(i/2);
    
    scx = 0.995 * scx;
    scy = 0.995 * scy; 
end

implay(transf_beach,30);