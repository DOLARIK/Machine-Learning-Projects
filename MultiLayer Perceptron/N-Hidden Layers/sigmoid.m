function [p,pp] = sigmoid(a)

p = ((1 + exp(-a)).^(-1));
pp = p.*(1 - p);

end