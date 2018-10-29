function [p, pp] = relu(a,s)

p = zeros(size(a,1),size(a,2));


for i = 1:size(a,1)
    for j = 1:size(a,2)
        if a(i,j) >= 0;
            p(i,j) = a(i,j); pp(i,j) = 1;
        else p(i,j) = s*a(i,j); pp(i,j) = s;
        end
    end
end

end