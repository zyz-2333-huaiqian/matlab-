clear all
close all
clc
load('hall.mat')
load('jpegcodes.mat')
size_pic = 8*width*height;
size_code = length(DC_code) + length(AC_code)...
+ length(num2str(dec2bin(width))) + length(num2str(dec2bin(height)));
zip = size_pic / size_code