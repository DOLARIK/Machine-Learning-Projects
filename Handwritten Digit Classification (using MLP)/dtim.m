function a = dtim(b)

n = size(b,2);
m = size(b,1);
s = (n)^.5;
a = zeros(s,s,m);
for j = 1:m
    for i = 1:s:n
        a((i+s-1)/s,:,j) = b(j,i:i + s -1);
    end
end