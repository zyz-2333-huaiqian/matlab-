function category = code2_6(c_D) 
if (c_D == 0)
    category = 0;
else
    category = log2(abs(c_D));
    category = floor(category)+1;
end
end