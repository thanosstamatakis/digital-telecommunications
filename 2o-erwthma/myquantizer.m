function [xq,centers] = myquantizer(x,N,min,max)
% myquantizer - Description
%
% Syntax: [xq,centers] = myquantizer(x,N,min,max)
%
% Long description
for index = 1:length(x)
    if (x(index)>max)
        x(index) = max;
    end
    if (x(index)<min)
        x(index) = min;
    end
end    

xq = x;
centers = [];
end