function A = accuracy(pred,y)

j = 0;
n = size(y,1);

for i = 1:n
    
    if pred(i) == y(i)
        j = j+1;
    end
    
end

A = (j*100/n);