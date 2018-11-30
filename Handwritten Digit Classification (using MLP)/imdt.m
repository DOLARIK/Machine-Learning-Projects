function b = imdt(a,s)

a = imresize(a,[s s]);
b = zeros(1,s*s);

for i = 1:s
    for j = 1:s
        b(i*j) = a(i,j);
    end
end
