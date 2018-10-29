function [pred,t1,t2] = grDnnS(X,y,f1,f2,s,alpha,lambda,iter)

n = size(X,1);
fX = size(X,2);

K = size(y,2);

%Jnn_h = zeros(iter*n,1);
%Jnn_o = zeros(iter,1);
Jnn_o = 0;

t1 = rand(fX,f1)*(2*.1) - .1;
Delta1 = zeros(fX,f1);

t2 = rand(f1,f2)*(2*.1) - .1;
Delta2 = zeros(f1,f2);

t3 = rand(f2,K)*(2*.1) - .1;
Delta3 = zeros(f2,K);

pred = zeros(n,K);

%Forward Propagation
%wb = waitbar(0,'Iterating...');
o = 1;
while 1
    
    
    for i = 1:n

    %waitbar(i/n);

    a1 = X(i,:);

    z2 = a1*t1;
    [a2,da2] = relu(z2,s);
    
    z3 = a2*t2;
    [a3,da3] = relu(z3,s);

    z4 = a3*t3;
    [pred(i,:),da4] = sigmoid(z4);

    %Backward Propagation

    d4 = (2*(pred(i,:)-y(i,:))).*da4;
    d3 = ((d4)*(t3')).*da3;
    d2 = ((d3)*(t2')).*da2;

    Delta1 = Delta1 + (a1')*d2;
    Delta2 = Delta2 + (a2')*d3;
    Delta3 = Delta3 + (a3')*d4;
    
    t1 = t1*(lambda) - alpha*(Delta1);
    t2 = t2*(lambda) - alpha*(Delta2);
    t3 = t3*(lambda) - alpha*(Delta3);
    %l = i + n*(o-1);
    %Jnn_h(l) = costNN(y(i,:),pred(i,:));
    
    %if l >= 2
    %if Jnn_h(l)>Jnn_h(l-1)
    %    alpha = alpha/1.1;
    %end
    %end
    
    %format long
    
    %if o>=2
     %   [o i Jnn_h(l) Jnn_o(o-1) alpha]
    %else        
     %   [o i Jnn_h(l) alpha]
    %end
    
    %[o i Jnn_o alpha]
    
    end
    

    
    %Jnn_o(o) = costNN(y,pred,K);
    %Jnn_h(o)
    
    Jnn_h = costNN(y,pred);
    Jnn_o = [Jnn_o; Jnn_h];
    
    %if 0 > 10
    %if (Jnn_o(o-1) - Jnn_o(o)) < 0 
    %    alpha = alpha/1.1;
    %end
    %end
    
    if o>10
    [o Jnn_h (Jnn_o(o-10) - Jnn_o(o))]
    else
        [o Jnn_h]
    end
    
    
    
    %o
    
    if o>iter
    %if (Jnn_o(o-10) - Jnn_o(o)) > 0
    if (Jnn_o(o-10) - Jnn_o(o)) < 0.002
        break
    end
    end
        
    o = o + 1;
%end

%end
%Jnn_h(o) = costNN(X,y,pred,K);
%a1; a2; a3;
%waitbar(o/iter);
%delete(wb);
end

plot(Jnn_o(2:o))
xlabel('Epochs');ylabel('Loss_T_r_a_i_n');

end

%D1 = Delta1/n;
%D2 = Delta2/n;
%D3 = Delta3/n; 


%t1,t1,t3


%end