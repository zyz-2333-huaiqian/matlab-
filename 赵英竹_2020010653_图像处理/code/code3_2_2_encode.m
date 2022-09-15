clear all
close all
clc
load('hall.mat')
load('JpegCoeff.mat')
load('secret.mat')

s = size(hall_gray);
C = zeros(64,s(1)*s(2)/64);
cout = 1;
for i = 1:s(1)/8
    for j = 1:s(2)/8
        hall_piece = hall_gray(i*8-7:i*8,j*8-7:j*8);
        hall_piece = double(hall_piece) - 128;
        c_before = dct2(hall_piece);
        c_before = round(c_before ./ QTAB);
        %将信息隐藏
        for m = 1:4
            for n = 1:4
                bit = secret(cout);
                if(bit == '1' && mod(c_before(m,n),2) == 0)
                    c_before(m,n) = c_before(m,n)+1;
                elseif(bit == '0' && mod(c_before(m,n),2) == 1)
                    c_before(m,n) = c_before(m,n)-1;
                end
                cout = cout+1;
            end
        end
        C(:,(i-1)*s(2)/8+j) = code2_7(c_before);
    end
end

c_d = zeros(1,i*j);
c_d(1) = C(1,1);
c_d(2:i*j) = C(1,1:i*j-1) - C(1,2:i*j);
categorys = zeros(size(c_d));
for k = 1:i*j
    categorys(k) = code2_6(c_d(k));
end
%计算DC
DC_code = [];
for k = 1:i*j
    huffman_single = [];
    for m = 1:DCTAB(categorys(k)+1,1)
        huffman_single = [huffman_single,num2str(DCTAB(categorys(k)+1,m+1))];
    end
    if(c_d(k) > 0)
        huffman_single = [huffman_single,num2str(dec2bin(c_d(k)))];
    elseif(c_d(k) < 0)
        bin = double(dec2bin(abs(c_d(k))))-'0';
        bin = ~bin;
        bin = num2str(double(bin));
        bin = strrep(bin,' ','');
        huffman_single = [huffman_single,bin];
    end
    DC_code = [DC_code,huffman_single];
end
%计算AC
AC_code = [];
for m = 1:i*j
    AC_single = [];
    count = 0;
    for n = 2:64
        if(C(n,m) == 0)
            count = count + 1;
        else
            while count>=16
                AC_single = [AC_single,'11111111001'];
                count = count - 16;
            end
            size = code2_6(C(n,m));
            for k = 1:ACTAB(count*10+size,3)
                AC_single = [AC_single,num2str(ACTAB(count*10+size,k+3))];
            end
            
            if(C(n,m) > 0)
                AC_single = [AC_single,num2str(dec2bin(C(n,m)))];
            else
                bin = double(dec2bin(abs(C(n,m))))-'0';
                bin = ~bin;
                bin = num2str(double(bin));
                bin = strrep(bin,' ','');
                AC_single = [AC_single,bin];
            end
            count = 0;
        end 
    end
    AC_code = [AC_code,AC_single,'1010'];
end

height = s(1);
width = s(2);
save('jpegcodes3_2_2.mat', 'DC_code', 'AC_code','height','width')

size_pic = 8*width*height;
size_code = length(DC_code) + length(AC_code) + length(num2str(dec2bin(width))) + length(num2str(dec2bin(height)));
zip = size_pic / size_code