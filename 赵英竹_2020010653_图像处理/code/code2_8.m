clear all
close all
clc
load('hall.mat')
load('JpegCoeff.mat')
s = size(hall_gray);
C = zeros(64,s(1)*s(2)/64);
%每次取一块8×8
for i = 1:s(1)/8
    for j = 1:s(2)/8
        hall_piece = hall_gray(i*8-7:i*8,j*8-7:j*8);
        %预处理
        hall_piece = double(hall_piece) - 128;
        %DCT
        c_before = dct2(hall_piece);
        %量化
        c_before = round(c_before ./ QTAB);
        %扫描
        C(:,(i-1)*s(2)/8+j) = code2_7(c_before);
    end
end