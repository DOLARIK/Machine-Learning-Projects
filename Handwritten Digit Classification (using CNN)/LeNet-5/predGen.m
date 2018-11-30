function y = predGen(pred)

i1 = size(pred,1);
j1 = size(pred,2);

y = zeros(i1,j1);

for i = 1:i1
    for j = 1:j1
        if pred(i,j) == max(pred(i,:))
            y(i,j) = 1;
        end
    end
end
