clear; close all; clc

%read image and display
I = imread('pudding.png','png','BackgroundColor',[1 1 1]);
figure, imshow(I), title('Original image')

%orizoume ta: megisto platos talatwshs, periodos kai kyklikh syxnothta
A = 0.3; 
T = 30; 
w = 2*pi/T;

%gia tis sheared eikones
window = 420;
start_y = 82;
xBase = 82;

%xrhsimopoioume xwrikes syntetagmenes
xWorldLimits = [0 256];
yWorldLimits = [-256 0];
RI = imref2d(size(I), xWorldLimits, yWorldLimits);

for t=1:100
    sh = A*sin(w*t);
    tmatrix = [1, 0, 0; sh, 1, 0; 0, 0, 1];
    tform = affine2d(tmatrix);
    [image, Rimage] = imwarp(I, RI, tform, 'FillValues', 255); 
    [m ,n, d] = size(image);
    %figure, imshow(image)
    
    xTop = ceil(abs(Rimage.XWorldLimits(1)));
    start_x = xBase-xTop;
    
    frame = padarray(image,[start_y start_x], 255,'pre');
    frame = padarray(frame, [(window - start_y - m) (window - start_x - n)], 255, 'post');
    shared_pudding(:,:,:,t) = frame;
end

implay(shared_pudding,30);















