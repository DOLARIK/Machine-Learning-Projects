function B = cbmod(A,S)

Ah = size(A,1);
Aw = size(A,2);
Ad = size(A,3);

Bh = S*(Ah-1) + 1;
Bw = S*(Aw-1) + 1;
Bd = Ad;

B = zeros(Bh,Bw,Bd);

for k = 1:Ad
    for i = 1:Ah
        for j = 1:Aw            
            it = i + (i - 1)*(S-1);
            jt = j + (j - 1)*(S-1);        
            B(it,jt,k) = A(i,j,k);
        end
    end
end


