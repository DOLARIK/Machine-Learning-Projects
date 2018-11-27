function A = max1(B)

A = 0*B;
Bh = size(B,1);
Bw = size(B,2);
Bd = size(B,3);


for k = 1:Bd
    for i = 1:Bh
        for j = 1:Bw
            if B(i,j,k) == max(max(B(:,:,k)))
                A(i,j,k) = 1;
            end
        end
    end
end