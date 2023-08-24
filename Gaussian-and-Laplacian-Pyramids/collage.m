close all;clear all; clc

P200 = im2double(imread('P200.jpg'));
cat = im2double(imread('cat.jpg')); 
dog1 = im2double(imread('dog1.jpg'));
dog2 = im2double(imread('dog2.jpg')); 
dragon = im2double(imread('dragon.jpg'));

maskp = zeros(size(P200));
maskc = im2double(imread('cat.bmp'));
maskd1 = im2double(imread('dog1.bmp'));
maskd2 = im2double(imread('dog2.bmp'));
maskdr = im2double(imread('dragon.bmp'));

cat   = imresize(cat,  [300,428]           );
cat   = padarray(cat,  [50,1800],0,'post');
cat   = padarray(cat,  [2098,1036]  ,0,'pre' );

dog1 = imresize(dog1,[948,1264]          );
dog1 = padarray(dog1,[0,335]    ,0,'post');
dog1 = padarray(dog1,[1500,1665],0,'pre' );

dog2   = imresize(dog2,  [700,978]         );
dog2   = padarray(dog2,  [0,800]  ,0,'post');
dog2   = padarray(dog2,  [1748,1486]  ,0,'pre' );

dragon   = imresize(dragon , [524,720]           );
dragon   = padarray(dragon , [60,2050],0,'post');
dragon   = padarray(dragon , [1864,494]    ,0,'pre' );

maskc   = imresize(maskc, [300,428]           );
maskc   = padarray(maskc, [50,1800],0,'post');
maskc   = padarray(maskc, [2098,1036]  ,0,'pre' );

maskd1 = imresize(maskd1,[948,1264]          );
maskd1 = padarray(maskd1,[0,335]    ,0,'post');
maskd1 = padarray(maskd1,[1500,1665],0,'pre' );

maskd2   = imresize(maskd2,  [700,978]         );
maskd2   = padarray(maskd2,  [0,800]  ,0,'post');
maskd2   = padarray(maskd2,  [1748,1486]  ,0,'pre' );

maskdr  = imresize(maskdr , [524,720]           );
maskdr   = padarray(maskdr , [60,2050],0,'post');
maskdr   = padarray(maskdr , [1864,494]    ,0,'pre' );

level = 5;
lP200 = genPyr(P200,'lap',level); 
lcat = genPyr(cat,'lap',level);
ldog1 = genPyr(dog1,'lap',level);
ldog2 = genPyr(dog2,'lap',level);
ldragon = genPyr(dragon,'lap',level);

B = cell(1,level); 
for p = 1:length(lP200)
	[Mp Np ~] = size(lP200{p});
	maskcp = imresize(maskc,[Mp Np]);
	B{p} = lP200{p}.*(1-maskcp) + lcat{p}.*maskcp ;
end
imgo = pyrReconstruct(B);
%figure,imshow(imgo)

limgo = genPyr(imgo ,'lap',level); 

B1 = cell(1,level); 
for p = 1:length(limgo)
	[Mp Np ~] = size(limgo{p});
    maskd1p = imresize(maskd1, [Mp Np]);
	B1{p} = limgo{p}.*(1-maskd1p) + ldog1{p}.*maskd1p;
end
imgo1 = pyrReconstruct(B1);
%figure,imshow(imgo1)

limgo1 = genPyr(imgo1 ,'lap',level); 

B2 = cell(1,level); 
for p = 1:length(limgo1)
	[Mp Np ~] = size(limgo1{p});
    maskd2p = imresize(maskd2, [Mp Np]);
	B2{p} = limgo1{p}.*(1-maskd2p) + ldog2{p}.*maskd2p;
end
imgo2 = pyrReconstruct(B2);
%figure,imshow(imgo2)

limgo2 = genPyr(imgo2 ,'lap',level); 

B3 = cell(1,level); 
for p = 1:length(limgo2)
	[Mp Np ~] = size(limgo2{p});
    maskdrp = imresize(maskdr, [Mp Np]);
	B3{p} = limgo2{p}.*(1-maskdrp) + ldragon{p}.*maskdrp;
end
imgo_final = pyrReconstruct(B3);
figure,imshow(imgo_final)




