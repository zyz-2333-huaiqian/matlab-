clear all
close all
clc

L = 5;
ur = zeros(1,2^(L*3));
%进行训练
for i = 1:33
    name = ['Faces/',num2str(i),'.bmp'];
    img = double(imread(name));
    ur_single = zeros(1,2^(L*3));
    s = size(img);
    for m = 1:s(1)
        for n = 1:s(2)
            r = floor(img(m,n,1) / (2^(8-L)));
            g = floor(img(m,n,2) / (2^(8-L)));
            b = floor(img(m,n,3) / (2^(8-L)));
            rgb = r*2^(2*L)+g*2^(L)+b;
            ur_single(rgb+1) = ur_single(rgb+1) + 1;
        end
    end
    ur_single = ur_single./(s(1)*s(2));
    ur = ur + ur_single;
end
%取平均
ur = ur./33;

%进行检测
img_test = imread('picture.jpg');
imshow(img_test)

ur = sqrt(ur);
%设定步长
H = 10;
W = 10;
s = size(img_test);
%确定小方格
rous = [];
bw_img = zeros((floor(s(1)/H)),(floor(s(2)/W)));
for i = 1:(floor(s(1)/H))
    for j = 1:(floor(s(2)/W))
        img_piece  = double(img_test((i-1)*H+1:i*H,(j-1)*H+1:j*H,:));
        ur_single = zeros(1,2^(L*3));
        for m = 1:H
            for n = 1:W
                r = floor(img_piece(m,n,1) / (2^(8-L)));
                g = floor(img_piece(m,n,2) / (2^(8-L)));
                b = floor(img_piece(m,n,3) / (2^(8-L)));
                rgb = r*2^(2*L)+g*2^(L)+b;
                ur_single(rgb+1) = ur_single(rgb+1) + 1;
            end
        end
        ur_single = ur_single./(H*W);
        ur_single = sqrt(ur_single);
        rou = 1 -  sum(ur.*ur_single);
        if(rou < 0.83)
            bw_img(i,j) = 1;
        end
        rous = [rous,rou];
        
    end
end

%将小方格合并为方块
[L,n] = bwlabel(bw_img);
for k = 1:n
    [r, c] = find(L==k);
    rc = [r c];
    size_rc = size(rc);
    if(size_rc(1)>=16)
        %寻找一片连通方块的左右上下端点
        left = min(rc(:,1));
        right = max(rc(:,1));
        up = min(rc(:,2));
        bottom = max(rc(:,2));
        
        hei = (bottom - up + 1)*H;
        wei = (right - left + 1)*W;
        rectangle('Position',[(up-1)*H+1 (left-1)*H+1 hei wei],'EdgeColor','r') 
    end
end

