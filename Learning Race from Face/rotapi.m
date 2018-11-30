function B = rotapi(A)

Ah = size(A,1);
Aw = size(A,2);
Ad = size(A,3);
At = size(A,4);

B = zeros(Ah,Aw,Ad,At);

for t = 1:At
    for k = 1:Ad
        for i = 1:Ah
            for j = 1:Aw
                B(Ah-i+1,Aw-j+1,k,t) = A(i,j,k,t);
            end
        end
    end
end

