clear; close all; clc

%diavazoume tis akolouthies
high1 = VideoReader('video1_high.avi');
high2 = VideoReader('video2_high.avi');
low1 = VideoReader('video1_low.avi');
low2 = VideoReader('video2_low.avi');

%contrast - a & brightness - b
a = 0.7; 
b = -50; 

% template = read(high1, 1);
% template_new = a.*template + b;
% imshowpair(template, template_new, 'montage'), title('a = 0.7 & b = -50');

%%%% high1 %%%%
i=1;
ecc_mse_h1 = zeros(100,10);
lk_mse_h1 = zeros(100,10);

while hasFrame(high1)
    %pername ta diadoxika frames
    template = read(high1, i);
    template_new = a.*template + b;
    
    image = read(high1, i+1);
    image_new = a.*image + b;
    
    %trexoume thn synarthsh gia ta diadoxika frames
    [~, ~, MSE, ~, MSELK]= ecc_lk_alignment(image_new, template_new, 2, 10, 'affine', eye(2,3));
    
    ecc_mse_h1(i, :) = MSE;
    lk_mse_h1(i, :) = MSELK;

    i = i + 1;
end

figure(1), title('PSNR ERRORs:(Red:LK)-(Black:ECC), high1');
hold on
stem(20*log10(255./lk_mse_h1),'r');
stem(20*log10(255./ecc_mse_h1),'k');
hold off

%%%% high2 %%%%
j=1;
ecc_mse_h2 = zeros(100,10);
lk_mse_h2 = zeros(100,10);

while hasFrame(high2)
    %pername ta diadoxika frames
    template2 = read(high2, j);
    template2_new = a.*template2 + b;
    
    image2 = read(high2, j+1);
    image2_new = a.*image2 + b;
    
    %trexoume thn synarthsh gia ta diadoxika frames
    [~, ~, MSE2, ~, MSELK2]= ecc_lk_alignment(image2_new, template2_new, 2, 10, 'affine', eye(2,3));
    
    ecc_mse_h2(j, :) = MSE2;
    lk_mse_h2(j, :) = MSELK2;

    j = j + 1;
end

figure(2), title('PSNR ERRORs:(Red:LK)-(Black:ECC), high2');
hold on
stem(20*log10(255./lk_mse_h2),'r');
stem(20*log10(255./ecc_mse_h2),'k');
%hold off

%%%% low1 %%%%
k=1;
ecc_mse_l1 = zeros(100,10);
lk_mse_l1 = zeros(100,10);

while hasFrame(low1)
    %pername ta diadoxika frames
    template3 = read(low1, k);
    template3_new = a.*template3 + b;
    
    image3 = read(low1, k+1);
    image3_new = a.*image3 + b;
    
    %trexoume thn synarthsh gia ta diadoxika frames
    [~, ~, MSE3, ~, MSELK3]= ecc_lk_alignment(image3_new, template3_new, 2, 10, 'affine', eye(2,3));
    
    ecc_mse_l1(k, :) = MSE3;
    lk_mse_l1(k, :) = MSELK3;

    k = k + 1;
end

figure, title('PSNR ERRORs:(Red:LK)-(Black:ECC), low1');
hold on
stem(20*log10(255./lk_mse_l1),'r');
stem(20*log10(255./ecc_mse_l1),'k');
%hold off

%%%% low2 %%%%
l=1;
ecc_mse_l2 = zeros(100,10);
lk_mse_l2 = zeros(100,10);

while hasFrame(low2)
    %pername ta diadoxika frames
    template4 = read(low2, l);
    template4_new = a.*template4 + b;
    
    image4 = read(low2, l+1);
    image4_new = a.*image4 + b;
    
    %trexoume thn synarthsh gia ta diadoxika frames
    [~, ~, MSE4, ~, MSELK4]= ecc_lk_alignment(image4_new, template4_new, 2, 10, 'affine', eye(2,3));
    
    ecc_mse_l2(l, :) = MSE4;
    lk_mse_l2(l, :) = MSELK4;

    l = l + 1;
end

figure, title('PSNR ERRORs:(Red:LK)-(Black:ECC), low2');
hold on
stem(20*log10(255./lk_mse_l2),'r');
stem(20*log10(255./ecc_mse_l2),'k');
hold off

