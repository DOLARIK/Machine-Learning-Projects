function A = sRmod(B,C,F)

Ch = size(C,1);
Cw = size(C,2);
Cd = size(C,3);

Bh = size(B,1);
Bw = size(B,2);
Bd = size(B,3);



A = ones(Ch,Cw,Cd);



for k = 1:Bd
    for i = 1:Bh
        for j = 1:Bw
           it = i + (i - 1)*(F-1);
           jt = j + (j - 1)*(F-1);
           Z = B(i,j,k)*A(it:it+F-1,jt:jt+F-1,k);
           A(it:it+F-1,jt:jt+F-1,k) = Z;
           
        end
    end
end


           