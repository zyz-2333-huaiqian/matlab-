clear all
close all
load('hall.mat')
%取图片并预处理
hall_piece = hall_gray(1:8,1:8);
hall_piece = double(hall_piece) - 128;
%利用函数进行DCT变换
c_afterm = dct2(hall_piece);
%编程实现DCT变换
N = 8;
row = linspace(0,N-1,N);
col = linspace(1,2*N-1,N);
DCT = cos(pi/16*kron(col,row.'));
DCT(1,:) = sqrt(1/2);
DCT = DCT./2;

c = DCT*double(hall_piece)*(DCT');
%进行比较
diff = c_afterm - c