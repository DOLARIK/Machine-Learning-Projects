function y1 = yGenR(y)

n = size(y,1);
k = size(y,2);
y1 = zeros(n,1);

for i=1:n
    for j = 1:k
        if y(i,j) == 1;
            y1(i) = j;
        end
    end
end