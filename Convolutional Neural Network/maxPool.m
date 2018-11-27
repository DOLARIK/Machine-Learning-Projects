function [C,X] = maxPool(Input_Layer, Kernel_Size)

A = Input_Layer;
    Ah = size(A,1);
    Aw = size(A,2);
    Ad = size(A,3);

F = Kernel_Size;

Ch = (Ah - F)/F + 1;
Cw = (Aw - F)/F + 1;

C = zeros(Ch,Cw,Ad);         % Convolution

X = zeros(Ah,Aw,Ad);

it = 0; jt = 0;

zt = 1;

for k = 1:Ad
    for i = 1:Ch
        for j = 1:Cw
                it = i + (i - 1)*(F-1);
                jt = j + (j - 1)*(F-1);
                C(i,j,k) = max(max(A(it:it+F-1,jt:jt+F-1,k)));
            
                Y{1,zt} = A(it:it+F-1,jt:jt+F-1,:);
                X(it:it+F-1,jt:jt+F-1,:) = max1(Y{1,zt});
            
                zt = zt + 1;
            
            
        end
    end      
end
