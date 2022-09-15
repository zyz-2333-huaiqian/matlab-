clear all
close all
load('hall.mat')
%显示原图
subplot(3,1,1);
imshow(hall_gray);
%进行DCT变换
hall_gray = double(hall_gray) -128;
c = dct2(hall_gray);
%将右侧四列置为0，并显示
c2 = c;
c2(:,165:168) = 0;
hall_piece_idct2 = idct2(c2);
subplot(3,1,2)
imshow(uint8(hall_piece_idct2+128))
%将左侧四列置为0，并显示
c3 = c;
c3(:,1:4) = 0;
hall_piece_idct3 = idct2(c3);
subplot(3,1,3)
imshow(uint8(hall_piece_idct3+128))
