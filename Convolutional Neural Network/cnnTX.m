function [prediction, A, C] = cnnTX(X,y,t,P,s,Kernel_Size,S,L,La)

ex = 1;
loss_s{1} = '';    
fprintf('|');
n = size(X,2);
    
    for i = 1:n    
        % Convolutional Layers
    
        for l = 1:L
        
            if l == 1
                C{l} = convLayer(X{i},t{l},P{l},S{l},s{l},Kernel_Size{l},0);
            else
                C{l} = convLayer(C{l-1},t{l},P{l},S{l},s{l},Kernel_Size{l},0);
            end
        end
        
        % Flatten
        
        C{L+1} = squash(C{L});                          % Input Layer of Fully Connected Layers
        
        % Fully Connected Layers
        
        for l = 1:La+2
                
            if l >= 2 && l <= La+1                      % Hidden Layers
                h = C{L + l-1}*t{L + l-1};
                C{L + l} = relu(h,.1);
            
            end
            
            if l == La+2                                % Output Layer
                C{L + l} = C{L+l-1}*t{L+l-1};
                pred(i,:) = sigmoid(C{L+l});
            end
            
        end      
        
        % Waitbar
        
        if rem(i,ceil(size(y,1)/50)) == 0
                                      
            for dex = 1:length(loss_s{ex})
                fprintf('\b');
            end
            
            ex = ex + 1;
            fprintf('=')
            dash = '';
            if rem(size(y,1),50) == 0
                dexa_l = 50-ex+1;
            else
                dexa_l = 49-ex+1;
            end
            
            for dexa = 1:dexa_l
                dash = [dash,'-'];
            end
        
            loss_s{ex} = [dash,'> Loss - ',num2str(costNN(y(1:i,:),pred(1:i,:)),10),' | ',num2str(i),' Samples Completed |'];
            
            
            fprintf(loss_s{ex})       
        
        end
        if i == size(y,1)
            fprintf('\n');
            ex = 1;
        end
    end
    
    
    pred1 = predGen(pred);
    pred2 = yGenR(pred1);
    pred2 = pred2 - 1;
    prediction = pred2;
    A = accuracy(pred2,y);
    %plot(pred2,'x');
