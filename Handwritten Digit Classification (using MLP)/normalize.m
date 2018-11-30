function A = normalize(X)

f = size(X,2);

for i = 1:f
    
    X(:,i) = (X(:,i) - min(X(:,i)))/(max(X(:,i)) - min(X(:,i)));
    
end

A = X;

end