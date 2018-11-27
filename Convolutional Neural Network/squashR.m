function B = squashR(A,C)

Bh = size(C,1);
Bw = size(C,2);
Bd = size(C,3);

B = 0*C;

it = 1;
for k = 1:Bd
    for i = 1:Bh
        for j = 1:Bw
            B(i,j,k) = A(1,it);
            it = it + 1;
        end
    end
end

end