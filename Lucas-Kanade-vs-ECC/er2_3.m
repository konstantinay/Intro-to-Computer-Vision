clear; close all; clc

%diavazoume tis akolouthies
high1 = VideoReader('video1_high.avi');
high2 = VideoReader('video2_high.avi');
low1 = VideoReader('video1_low.avi');
low2 = VideoReader('video2_low.avi');

%dialegoume ta frames pou tha xrhsimopoihtoun ws template
template_h1 = high1.read(1);
template_h2 = high2.read(1);
template_l1 = low1.read(1);
template_l2 = low2.read(1);
%imshow(template_l2)

%dialegoume ta frames poy tha xrhsimopoihtoun ws image(paramorfwmenh eikona)
image_h1 = high1.read(80);
image_h2 = high2.read(80);
image_l1 = low1.read(80);
image_l2 = low2.read(80);

%apply ecc_lk_alignment function to high1
[~, ~, MSE, ~, MSELK, time]= ecc_lk_alignment(image_h1, template_h1, 2, 10, 'affine', eye(2,3));

%apply ecc_lk_alignment function to high2
[~, ~, MSE2, ~, MSELK2, time2]= ecc_lk_alignment(image_h2, template_h2, 2, 10, 'affine', eye(2,3));

%apply ecc_lk_alignment function to high2
[~, ~, MSE3, ~, MSELK3, time3]= ecc_lk_alignment(image_l1, template_l1, 2, 10, 'affine', eye(2,3));

%apply ecc_lk_alignment function to high2
[~, ~, MSE4, ~, MSELK4, time4]= ecc_lk_alignment(image_l2, template_l2, 2, 10, 'affine', eye(2,3));

figure, title('MSE error for ECC and LK - frame 80')
hold on
plot(MSE)
hold on
plot(MSELK)
hold on
plot(MSE2,'--')
hold on
plot(MSELK2,'--')
hold on
plot(MSE3,':')
hold on
plot(MSELK3,':')
hold on
plot(MSE4,'-.')
hold on
plot(MSELK4,'-.')
legend({'high1-ECC','high1-LK','high2-ECC','high2-LK',...
    'low1-ECC','low1-LK','low2-ECC','low2-LK'},'Location','northwest','NumColumns',2)








