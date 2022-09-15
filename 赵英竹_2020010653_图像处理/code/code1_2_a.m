clear all
close all
load('hall.mat')
hall_circle = hall_color;
s = size(hall_color);
r= min(s(1),s(2))/2;
center = [s(1)/2,s(2)/2];

for i = 1:s(1)
    for j = 1:s(2)
        if((((i-center(1))^2+(j-center(2))^2) < r^2) &&...
                (((i-center(1))^2+(j-center(2))^2) > (r-2)^2))
            hall_circle(i,j,1)=255;
            hall_circle(i,j,2)=0;
            hall_circle(i,j,3)=0;
        end
    end
end
imwrite(hall_circle,'hall_circle.jpg')
imshow(hall_circle)