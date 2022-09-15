function y = ADSR_1(x)
    len = length(x);
    y = zeros(1,len);
    for i = 1:len
       if i < len/6
           y(i) = 1.2/(x(len)/6)*x(i);
       elseif i < len/3
           y(i) = -0.2/(x(len)/6)*(x(i)-x(len)/6)+1.2;
       elseif i < 2*len/3
           y(i) = 1;
       else 
           y(i) = 1- 1/(x(len)/3)*(x(i)-2*x(len)/3);
       end
    end
    
