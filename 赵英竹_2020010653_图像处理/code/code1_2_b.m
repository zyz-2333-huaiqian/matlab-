clear all
close all
load('hall.mat')
hall_m = hall_color;
s = size(hall_color);
for i = 1:s(1)
    for j = 1:s(2)
        if(mod(floor((i-1)/10)+floor((j-1)/12),2) == 1)
            hall_m(i,j,1)=0;
            hall_m(i,j,2)=0;
            hall_m(i,j,3)=0;
        end
    end
end
imwrite(hall_m,'hall_m.jpg')
imshow(hall_m)
