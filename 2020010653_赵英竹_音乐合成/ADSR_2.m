function y = ADSR_2(x)
    len = length(x);
    y = zeros(1,len);
    A= 0.8/(x(round(len/6))^2);
    for i = 1:len
       if i < len/5
           y(i) = -A*(x(i)-x(round(len/6)))^2+0.8;
       else 
           y(i) = exp(-2*x(i)/x(len));
       end
    end