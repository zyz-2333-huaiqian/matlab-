close all
clear all
clc
load('snow_code.mat')
load('JpegCoeff.mat')

%DC解码
DC = zeros(1,320);
DC_d = zeros(1,320);
j = 1;
while isempty(DC_code) == 0
    for i = 1:12
        len = DCTAB(i,1);
        if(strcmp(strrep(num2str(DCTAB(i,2:len+1)),' ','') , DC_code(1:len)))
            category = i-1;
            DC_code = DC_code(len+1:end);
            if(category ~= 0)
                bin = DC_code(1:category);
                DC_code = DC_code(category+1:end);
                if(bin(1) == '1')
                    DC_d(j) = bin2dec(bin);
                else
                    DC_d(j) = bin2dec(bin) + 1 - 2^category;
                end
            else
                DC_d(j) = 0;
            end
            j = j+1;
            break
        end
    end
end
DC(1) = DC_d(1);
for i = 2:320
    DC(i) = DC(i-1) - DC_d(i);
end

%AC解码
m = 1;%列数
n = 1;%行数
AC = zeros(63,320);
while isempty(AC_code) == 0
    if(length(AC_code)>11 && strcmp('11111111001',AC_code(1:11)))       
        n = n+16;
        AC_code = AC_code(12:end);
    elseif(strcmp('1010',AC_code(1:4)))
        m = m+1;
        n = 1;
        AC_code = AC_code(5:end);
    else
    for i = 1:160
        len = ACTAB(i,3);
        if(len< length(AC_code) && strcmp(strrep(num2str(ACTAB(i,4:len+3)),' ','') , AC_code(1:len)))
            run = ACTAB(i,1);
            if(run ~= 0)
                n = n+run;
            end
            size = ACTAB(i,2);
            AC_code = AC_code(len+1:end);
            bin = AC_code(1:size);
            AC_code = AC_code(size+1:end);
            if(bin(1) == '1')
                AC(n,m) = bin2dec(bin);
            else
                AC(n,m) = bin2dec(bin) + 1 - 2^size;
            end
            n = n+1;
        break
        end
    end

    end
end

%反zigzag idct
C = zeros(64,320);
C(1,:) = DC;
C(2:end,:) = AC;
pic = zeros(height,width);
izigzag = [1 2 6 7 15 16 28 29; ...
 3 5 8 14 17 27 30 43; ...
 4 9 13 18 26 31 42 44; ...
 10 12 19 25 32 41 45 54; ...
 11 20 24 33 40 46 53 55; ...
 21 23 34 39 47 52 56 61; ...
 22 35 38 48 51 57 60 62; ...
 36 37 49 50 58 59 63 64];
for i = 1:height/8
    for j = 1:width/8
        before = reshape(C(:,(i-1)*width/8+j),1,64);
        after = zeros(8,8);
        for x = 1:8
            for y = 1:8
                after(x,y) = before(izigzag(x,y));
            end
        end
        after = after .* QTAB;
        inver = idct2(after);
        pic(i*8-7:i*8,j*8-7:j*8) = round(inver + 128);
    end
end
save('tran_pic.mat','pic');
imshow(uint8(pic))

%PNSR
load('snow.mat')
MSE_pre = (double(snow) - pic).^2;
MSE = sum(sum(MSE_pre))/(128*160);
PSNR = 10*log10(65025/MSE)