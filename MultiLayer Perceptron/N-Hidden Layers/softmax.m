function s = softmax(y)

s = exp(y)/sum(exp(y));
