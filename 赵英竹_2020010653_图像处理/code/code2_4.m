clear all
close all
load('hall.mat')
%画原图
subplot(2,2,1);
imshow(hall_gray);
%进行变换
c = dct2(hall_gray);
%将系数转置
c2 = c';
hall_piece_idct2 = idct2(c2);
subplot(2,2,2)
imshow(uint8(hall_piece_idct2))
%将系数旋转90
c3 = rot90(c);
hall_piece_idct3 = idct2(c3);
subplot(2,2,3)
imshow(uint8(hall_piece_idct3))
%将系数再旋转90，即旋转180
c4 = rot90(c3);
hall_piece_idct4 = idct2(c4);
subplot(2,2,4)
imshow(uint8(hall_piece_idct4))