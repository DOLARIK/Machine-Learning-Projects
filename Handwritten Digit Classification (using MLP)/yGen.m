function y1 = yGen(y,k)

n = size(y,1);
y1 = zeros(n,k);

for i = 1:n
for j = 1:k
if y(i) == j;
y1(i,j) = 1;
end
end
end