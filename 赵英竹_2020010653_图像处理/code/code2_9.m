%计算DC
%1.计算DC系数的差分
c_d = zeros(1,i*j);
c_d(1) = C(1,1);
c_d(2:i*j) = C(1,1:i*j-1) - C(1,2:i*j);
%2.得到categorys
categorys = zeros(size(c_d));
for k = 1:i*j
    categorys(k) = code2_6(c_d(k));
end
%3.进行熵编码
DC_code = [];
for k = 1:i*j
    huffman_single = [];
    %连接huffman编码部分
    for m = 1:DCTAB(categorys(k)+1,1)
        huffman_single = [huffman_single,num2str(DCTAB(categorys(k)+1,m+1))];
    end
    %得到二进制码
    if(c_d(k) > 0)
        huffman_single = [huffman_single,num2str(dec2bin(c_d(k)))];
    elseif(c_d(k) < 0)
        bin = double(dec2bin(abs(c_d(k))))-'0';
        bin = ~bin;
        bin = num2str(double(bin));
        bin = strrep(bin,' ','');
        huffman_single = [huffman_single,bin];
    end
    %将这一部分接到DC码流之后
    DC_code = [DC_code,huffman_single];
end
%计算AC
AC_code = [];
for m = 1:i*j
    AC_single = [];
    count = 0;
    for n = 2:64
        %计算run
        if(C(n,m) == 0)
            count = count + 1;
        else
            %由run/size得到huffman编码
            while count>=16
                AC_single = [AC_single,'11111111001'];
                count = count - 16;
            end
            size = code2_6(C(n,m));
            for k = 1:ACTAB(count*10+size,3)
                AC_single = [AC_single,num2str(ACTAB(count*10+size,k+3))];
            end
            %计算非零数的二进制码
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
save('jpegcodes.mat', 'DC_code', 'AC_code','height','width')
