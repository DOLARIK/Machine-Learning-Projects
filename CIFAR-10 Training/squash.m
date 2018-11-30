function A = squash(B)


Bh = size(B,1);
Bw = size(B,2);
Bd = size(B,3);

A = zeros(1,Bh*Bw*Bd);

it = 1;
for k = 1:Bd
    for i = 1:Bh
        for j = 1:Bw
            A(1,it) = B(i,j,k);
            it = it + 1;
        end
    end
end

end