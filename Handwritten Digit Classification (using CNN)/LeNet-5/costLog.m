function Jlog = costLog(X,y,theta)

n = size(X,1);
z = X*theta;
pred = (1 + exp(-z)).^(-1);

Jlog = (1/n)*(-(y')*(log(pred)) - ((ones(n,1)-y)')*(log(ones(n,1)-pred)));