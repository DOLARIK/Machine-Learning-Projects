function [pred,pred1,pred2,A] = nnTX(X,y,t,s)

    g = size(t,2);
       
    for i = 1:g+1
        
        if i == 1
            a{i} = X;
        end
        
        if i > 1 && i < g+1
            a{i} = relu(a{i-1}*t{i-1},s);
        end
        
        if i == g+1
            pred = sigmoid(a{i-1}*t{i-1});
        end
        
    end
    
    pred1 = predGen(pred);
    pred2 = yGenR(pred1);
    pred2 = pred2 - 1;
    A = accuracy(pred2,y);
    %plot(pred2,'x');

end

