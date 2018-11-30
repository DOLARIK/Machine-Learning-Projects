%% Data Preparation

fprintf('Preparing Data into Trainable format. \n');

it = 1;
for b = 1:5
    for i = 1:10000
        Xtrain{it} = squashR(X{1,b}.data(i,:),zeros(32,32,3));
        labels(it,1) = double(y{1,1}.labels(i,1));
        ytrain(it,:) = yGen(labels(it,1) + 1,10);
        it = it + 1;
    end
end
