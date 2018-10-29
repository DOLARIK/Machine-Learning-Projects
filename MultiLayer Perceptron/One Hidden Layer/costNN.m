function Jnn = costNN(y,pred)

n = size(y,1); k = size(y,2);
A = zeros(n,1);

for i = 1:n

A(i) = (1/n)*(-(y(i,:))*((log(pred(i,:)))') - ((ones(1,k)-y(i,:)))*((log(ones(1,k)-pred(i,:)))'));

end

Jnn = sum(A);

end
