function [p, pp] = relu(a,s)

p = zeros(size(a,1),size(a,2),size(a,3));



for k = 1:size(a,3)
    for i = 1:size(a,1)
        for j = 1:size(a,2)
            if a(i,j) >= 0;
                p(i,j,k) = a(i,j,k); pp(i,j,k) = 1;
            else 
                p(i,j,k) = s*a(i,j,k); pp(i,j,k) = s;
            end
        end
    end
end
end