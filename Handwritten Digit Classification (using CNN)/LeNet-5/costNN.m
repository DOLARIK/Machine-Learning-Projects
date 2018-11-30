function Jnn = costNN(y,pred)

n = size(y,1); k = size(y,2);
A = zeros(n,1);

for i = 1:n
    
    % Cross Entropy Loss = ((1/n)*(-(y(i,:))*((log(pred(i,:)))') - ((ones(1,k)-y(i,:)))*((log(ones(1,k)-pred(i,:)))')))
    % Mean Squared Error = ((1/n)*((pred(i,:) - y(i,:)).^2))
    % You can use any of the above as the Cost Function by equating the
    % chosen one with the variable 'loss'.
    % Just make sure you choose the respective Gradient in the
    % Back-Propagation step of Neural Network
    
    loss = ((1/n)*(-(y(i,:))*((log(pred(i,:)))') - ((ones(1,k)-y(i,:)))*((log(ones(1,k)-pred(i,:)))')));
    
    A(i) = loss;

end

Jnn = sum(A);

end
