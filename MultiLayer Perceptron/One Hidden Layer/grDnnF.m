function [pred,t1,t2,Jnn_o] = grDnnF(X,y,f1,s,alpha,lambda,iter,target_dev,target_loss)

n = size(X,1);                                      % No. of Instances in training X
fX = size(X,2);                                     % No. of Features in One Instance

K = size(y,2);                                      % No. of Classes in Output

Jnn_o = 0;                                          % Initializing the Loss

t1 = rand(fX,f1)*(2*.1) - .1;                       % Weights connecting the Input Layer to the Hidden Layer
Delta1 = zeros(fX,f1);

t2 = rand(f1,K)*(2*.1) - .1;                        % Weights connecting the Hidden Layer to the Output Layer
Delta2 = zeros(f1,K);

pred = zeros(n,K);                                  % Initializing the Prediction Matrix

%Forward Propagation

o = 1;

while 1
    
    
    for i = 1:n

    a1 = X(i,:);                                    % Input Layer

    z2 = a1*t1;                                     
    [a2,da2] = relu(z2,s);                          % Hidden Layer

    z3 = a2*t2;
    [pred(i,:),da3] = sigmoid(z3);                  % Output Layer

    %Backward Propagation

    d3 = (-1*((y(i,:)./pred(i,:))-((1-y(i,:))./(1-pred(i,:))))).*da3;               
    d2 = ((d3)*(t2')).*da2;                         
    
    Delta1 = Delta1 + (a1')*d2;                     % Weight gradient for connection b/w Hidden and Output Layer
    Delta2 = Delta2 + (a2')*d3;                     % Weight gradient for connection b/w Input and Hidden Layer
    
    % Gradient Descent
    t1 = t1*(lambda) - alpha*(Delta1);              
    t2 = t2*(lambda) - alpha*(Delta2);
    
    end
    
    Jnn_h = costNN(y,pred);                         % Cost Calculation per Iteration
    Jnn_o = [Jnn_o; Jnn_h];
       
    if o>10
    fprintf('Iteration No. %i || Loss = %g || Development = %g \n',[o, Jnn_h, (Jnn_o(o-9) - Jnn_o(o))]);
    else
        fprintf('Iteration No. %i || Loss = %g \n',[o, Jnn_h]);
    end
    
    if o > iter || (Jnn_h < target_loss && Jnn_h > 0)
        if o > 10
            if (Jnn_o(o-9) - Jnn_o(o)) < target_dev         % Stop Condition for Training
               break
            end
        else
            break
        end
    end
        
    o = o + 1;
end

plot(Jnn_o(2:o))                                    % 'Loss vs Epochs' Plot
xlabel('Epochs');ylabel('Loss_T_r_a_i_n');

end

