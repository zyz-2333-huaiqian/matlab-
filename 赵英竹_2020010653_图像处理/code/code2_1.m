clear all
close all
load('hall.mat')
%取一块图片验证
hall_piece = hall_gray(1:8,1:8);
%在变换域计算
c_pre = dct2(hall_piece);
DC = ones(8,8)*128;
c_dc = dct2(DC);
c_trans = c_pre - c_dc;
%在原图计算
hall_piece2 = hall_piece - 128;
c_afterm = dct2(hall_piece2);

diff = c_trans - c_afterm
