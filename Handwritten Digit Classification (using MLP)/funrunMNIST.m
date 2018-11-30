%% Load the Files
fprintf('Kindly Select the folder where you have kept your Test Data \n\n');
    test_data_loc = uigetdir;
    test_data_loc_X = [test_data_loc,'\t10k-images.idx3-ubyte'];


Xtest = loadMNISTImages(test_data_loc_X);
Xtest = Xtest';
a = dtim(Xtest);

fprintf('Kindly Select the Folder in which you have stored your test prediction values');
[file,path] = uigetfile({'*.*'},'Kindly Select the Folder in which you have stored your test prediction values');
location = [path,file];
pred = csvread(location);

%% Slideshow
    for i = 1:100
        M(i) = randi([10*(i-1),i*10],1,1);
    end

    for m = 1:100
        
        imshow(a(:,:,M(m))');
        xlabel(pred(M(m)));
        
        pause(.8)
        
    end