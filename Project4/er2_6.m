clear; close all; clc

%diavazoume tis akolouthies
high1 = VideoReader('video1_high.avi');

%dialegoume ta frames pou tha xrhsimopoihtoun ws template
template_h1 = high1.read(1);

%dialegoume ta frames poy tha xrhsimopoihtoun ws image(paramorfwmenh eikona)
image_h1 = high1.read(60);

%%%%% GAUSSIAN %%%%%
%gia ta plots
ecc_mse_h1 = zeros(100,10);
lk_mse_h1 = zeros(100,10);

for i=1:100
    noisytemp_h1 = imnoise(template_h1, 'gaussian', 0, 12);
    noisyimg_h1 = imnoise(image_h1, 'gaussian', 0, 12);
    
    %apply ecc_lk_alignment function to high1
    [~, ~, MSE, ~, MSELK]= ecc_lk_alignment(noisyimg_h1, noisytemp_h1, 2, 10, 'affine', eye(2,3));
    
    ecc_mse_h1(i, :) = MSE;
    lk_mse_h1(i, :) = MSELK;
end

mean_mse = zeros(1, 100);
mean_mse_lk = zeros(1, 100);
psnr_ecc = zeros(1, 100);
psnr_lk = zeros(1, 100);

for j = 1:100
    mean_mse(1, j) = mean(ecc_mse_h1(j, :));
    mean_mse_lk(1, j) = mean(lk_mse_h1(j, :));
    
    psnr_ecc(1, j) = 20*log10(255./mean_mse(1,j));
    psnr_lk(1, j) = 20*log10(255./mean_mse_lk(1,j));
end

figure, title('PSNR 100 iterations: gaussian noise s^2=8');
hold on
plot(psnr_ecc)
hold on
plot(psnr_lk)
legend({'high1-ECC','high1-LK'},'Location','southwest')

%%%%% UNIFORM %%%%%
%uniform noise
lower_bound = -18^(1/3);
upper_bound = 18^(1/3);
u = lower_bound + rand(size(image_h1))*(upper_bound-lower_bound);

%gia ta plots
uecc_mse_h1 = zeros(100,10);
ulk_mse_h1 = zeros(100,10);

for i=1:100
    unoisytemp_h1 = template_h1 + uint8(u);
    unoisyimg_h1 = image_h1 + uint8(u);
    
    %apply ecc_lk_alignment function to high1
    [~, ~, MSE, ~, MSELK]= ecc_lk_alignment(unoisyimg_h1, unoisytemp_h1, 2, 10, 'affine', eye(2,3));
    
    uecc_mse_h1(i, :) = MSE;
    ulk_mse_h1(i, :) = MSELK;
end

umean_mse = zeros(1, 100);
umean_mse_lk = zeros(1, 100);
upsnr_ecc = zeros(1, 100);
upsnr_lk = zeros(1, 100);

for j = 1:100
    umean_mse(1, j) = mean(uecc_mse_h1(j, :));
    umean_mse_lk(1, j) = mean(ulk_mse_h1(j, :));
    
    upsnr_ecc(1, j) = 20*log10(255./umean_mse(1,j));
    upsnr_lk(1, j) = 20*log10(255./umean_mse_lk(1,j));
end

figure, title('PSNR 100 iterations: uniform noise a=18^1/3');
hold on
plot(upsnr_ecc)
hold on
plot(upsnr_lk)
legend({'high1-ECC','high1-LK'},'Location','southwest')











