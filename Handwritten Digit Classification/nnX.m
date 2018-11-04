function [pred,t,Jnn_o] = nnX(X,y,H,s,alpha,lambda,iter,target_dev,target_loss)

n = size(X,1);                                      % No. of Instances in training X

fX = size(X,2);                                     % No. of Features in One Instance
K = size(y,2);                                      % No. of Classes in Output

Jnn_o = 0;                                          % Initializing the Loss

% Neuron Count of a Particular Hidden Layer

for h = 1:H
    if h == 1                                       
        fprintf('How many neurons do you want in %gst Hidden Layer?', h)
        f{h} = input(' -> \n');
    end
    if h == 2                                       
        fprintf('How many neurons do you want in %gnd Hidden Layer?', h)
        f{h} = input(' -> \n');
    end
    if h > 2 && h <= H
        fprintf('How many neurons do you want in %gth Hidden Layer?', h)
        f{h} = input(' -> \n');
    end
end

% Parameter Randomized Initialization

for h = 1:H+1
    if h == 1
        t{h} = rand(fX,f{h})*(2*.001) - .001;                       
        Delta{h} = zeros(fX,f{h});
    end
    
    if h > 1 && h < H+1
        t{h} = rand(f{h-1},f{h})*(2*.001) - .001;
        Delta{h} = zeros(f{h-1},f{h});
    end
    
    if h == H+1
        t{h} = rand(f{h-1},K)*(2*.001) - .001;
        Delta{h} = zeros(f{h-1},K);
    end
        
end

pred = zeros(n,K);                                  




o = 1;

while 1
      
    for i = 1:n
    
    %Forward Propagation
    
        for l = 1:H+2
        
            if l == 1                                   % Input Layer
                a{l} = X(i,:);
            end
        
            if l >= 2 && l < H+2                        % Hidden Lsyers
            
                z{l} = a{l-1}*t{l-1};                                     
                [a{l},da{l}] = relu(z{l},s);
            
            end
            
            if l == H+2                                 % Output Layer
                z{l} = a{l-1}*t{l-1};
                [pred(i,:),da{l}] = sigmoid(z{l});
            end
            
        end
    
    %Backward Propagation
   
        for l = 1:H+2
            
            if l == 1
                d{H+3-l} = (pred(i,:) - y(i,:)).*da{H+3-l};    %-1*((y(i,:)./pred(i,:))-((1-y(i,:))./(1-pred(i,:))))
            end
            
            if l > 1 && l <H+2
                d{H+3-l} = ((d{(H+3-l)+1})*(t{H+3-l}')).*da{H+3-l};
            end
            
            if l == H+2
                break
            end
            
        end
    
        for l = 1:H+1
            Delta{l} = Delta{l} + (a{l}')*d{l+1};
        end
        
    % Gradient Descent
        
        t = grD(t,Delta,lambda,H,alpha);
    
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

