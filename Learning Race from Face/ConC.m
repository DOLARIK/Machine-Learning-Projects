function c = ConC(a,b)

for i = 1:size(a,1)
for j = 1:size(a,2)
c(:,j) = a(i,j)*b;
end
end