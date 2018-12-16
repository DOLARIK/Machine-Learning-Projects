%% Loading Test Data

file = [extract_folder_loc,'\test_batch'];
Xt = load(file,'data');
yt = load(file,'labels');

%% Data Prep

fprintf('Preparing Data into Testable format. \n');

it = 1;
    for i = 1:10000
        Xtest{it} = normalize3(rgb2gray(im2double(uint8(squashR(Xt.data(i,:),zeros(32,32,3))))));
        labels_test(it,1) = double(yt.labels(i,1));
        ytest(it,:) = yGen(labels_test(it,1) + 1,10);
        it = it + 1;
    end
