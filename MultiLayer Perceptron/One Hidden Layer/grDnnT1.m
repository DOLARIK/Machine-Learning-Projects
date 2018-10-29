function [pred,pred1,pred2,A] = grDnnT1(X,y,t1,t2,s)

    a1 = X ;
    
    z2 = a1*t1;
    a2 = relu(z2,s);
     
    z3 = a2*t2;
    pred = sigmoid(z3);
    
    pred = pred;
    
    pred1 = predGen(pred);
    pred2 = yGenR(pred1);
    pred2 = pred2 - 1;
    A = accuracy(pred1,y);
    %plot(pred2,'x');

end

