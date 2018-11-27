function [pred,t,Jnn_o,s] = nnX(X,y)

fprintf('We will work with a Vanilla Neural Network with N Hidden Layers \n\n');
    
H = input('How many Hidden Layers should be there? \n');

s = input('ReLU Slope = ' );


alpha = input('Learning Rate (usualy start with .001) = ');
%lambda = input('Regularization Parameter (b/w 0 and 1) = ');
iter = input('How many Minimum No. of iterations would you like to have? \n');
target_dev = input('When would you like to stop the Training? When the Development becomes < ');
target_loss = input(' and Loss becomes < ');
fprintf('\n');

B1 = input('What should be the value of B1 for Adam Optimizer? (Usually .9) -> ');
fprintf('\n');
B2 = input('What should be the value of B2 for Adam Optimizer? (Usually .999) -> ');
fprintf('\n');
E = input('What should be the value of E for Adam Optimizer? (Usually 1.0e-8, "7 zeroes after decimal and then 1") -> ');
fprintf('\n');


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
        Vdw{h} = zeros(fX,f{h});
        Sdw{h} = zeros(fX,f{h});
    end
    
    if h > 1 && h < H+1
        t{h} = rand(f{h-1},f{h})*(2*.001) - .001;
        Delta{h} = zeros(f{h-1},f{h});
        Vdw{h} = zeros(f{h-1},f{h});
        Sdw{h} = zeros(f{h-1},f{h});
    end
    
    if h == H+1
        t{h} = rand(f{h-1},K)*(2*.001) - .001;
        Delta{h} = zeros(f{h-1},K);
        Vdw{h} = zeros(f{h-1},K);
        Sdw{h} = zeros(f{h-1},K);
    end
        
end

pred = zeros(n,K);                                  

ex = 1;
loss_s{1} = '';
o = 1;

while 1
    fprintf('|');  
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
                % Cross Entropy Loss Gradient = (-1*((y(i,:)./pred(i,:))-((1-y(i,:))./(1-pred(i,:)))))
                % Mean Squared Error Gradient = (pred(i,:) - y(i,:))
                % You can select any of the above Loss Gradient and use it
                % for the variable 'loss_gradient'
                % Just make sure that you use the respective cost Function
                % in the function 'costNN()'
                loss_gradient = (pred(i,:) - y(i,:));
                d{H+3-l} = (loss_gradient).*da{H+3-l};    
            end
            
            if l > 1 && l <H+2
                d{H+3-l} = ((d{(H+3-l)+1})*(t{H+3-l}')).*da{H+3-l};
            end
            
            if l == H+2
                break
            end
            
        end
    
        for l = 1:H+1
            Delta{l} = (a{l}')*d{l+1};
        end
        
    % Optimizer
        
        [t,Vdw,Sdw] = adam(t, Delta, iter, B1, B2, E, Vdw, Sdw, H, alpha);%t = grD(t,Delta,lambda,H,alpha);
    
    % Waitbar    
        
        if rem(i,ceil(n/50)) == 0
                       
            for dex = 1:length(loss_s{ex})
                fprintf('\b');
            end
            
            ex = ex + 1;
            
            fprintf('=')
                        
            dash = '';
            if rem(n,50) == 0
                dexa_l = 50-ex+1;
            else
                dexa_l = 49-ex+1;
            end
            
            for dexa = 1:dexa_l
                dash = [dash,'-'];
            end
        
            loss_s{ex} = [dash,'> Loss - ',num2str(costNN(y(1:i,:),pred(1:i,:)),10),' | ',num2str(i),' Samples Completed |',' Epoch No. ',num2str(o)];
        
            
            fprintf(loss_s{ex})        
        
        end
        if i == n
            fprintf('\n');
            ex = 1;
        end
        
    end
    
    Jnn_h = costNN(y,pred);                                 % Cost Calculation per Iteration
    Jnn_o = [Jnn_o; Jnn_h];
       
    if o>iter
    fprintf('Iteration No. %i || Loss = %g || Development = %g \n',[o, Jnn_h, (Jnn_o(o-(iter-1)) - Jnn_o(o))]);
    else
        fprintf('Iteration No. %i || Loss = %g \n',[o, Jnn_h]);
    end
    
    if o > iter || (Jnn_h < target_loss && Jnn_h > 0)
        if o > iter
            if (Jnn_o(o-(iter-1)) - Jnn_o(o)) < target_dev         % Stop Condition for Training
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

