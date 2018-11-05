function C = convolve(Input_Layer, Filter, Padding_Req, Stride, Same, Padding_Size)

A = Input_Layer;
    Ah = size(A,1);
    Aw = size(A,2);
    Ad = size(A,3);
    
S = Stride;   

B = Filter;                                                        % Filter
    F = size(B,1);
    K = size(B,3);


if Padding_Req == 1    
    
    %Padding = input('Do you want to keep the same size as of input layer or you want to input your padding credentials? \n');
    Ph = Padding_Size;
    Pw = Padding_Size;
        
    if Same == 1                                 % Padding
        Ph = ((Ah-1)*S - (Ah-F))/2;
        Pw = ((Aw-1)*S - (Aw-F))/2;
    end

    %if strcmp(Padding,'Input') == 1                                % Padding
        %Ph = input('Height Padding \n');
        %Pw = input('Height Padding \n');
    %end
    

    
    Z = zeros(Ah+(2*Ph),Aw+(2*Pw),Ad);
    
    Z(Ph+1:Ah+(2*Ph)-Ph,Pw+1:Aw+(2*Pw)-Pw,:) = A;
    A = Z;
        Ah = size(A,1);
        Aw = size(A,2);
        Ad = size(A,3);
        
end



I = size(B,1);
J = size(B,2);

Ch = (Ah - F)/S + 1;
Cw = (Ah - F)/S + 1;

C = zeros(Ch,Cw,K);         % Convolution

%it = 0; jt = 0;
for i = 1:Ch
    for j = 1:Cw
        for k = 1:K
            it = i + (i - 1)*(S-1);
            jt = j + (j - 1)*(S-1);
            C(i,j,k) = sum(sum(sum(B(:,:,:,k).*A(it:it+I-1,jt:jt+J-1,:))));
        end
    end
end

end



