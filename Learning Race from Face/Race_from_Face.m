%% Extracting Images and Importing Data onto MATLAB Workspace

UTKFace_data_import;

%% Loading Training and Test Data 
split_percent = input('What Percent of data would you like to Use for Training? (Answer should be in *%* {out of 100}) -> \n');
split_fraction = split_percent/100;

% Training Data Load
X = Image;
I = X;

Xtrain = X(1:ceil(split_fraction*size(I,2)));
ytrain_Age = Age(1:ceil(split_fraction*size(I,2)));
ytrain_Gender = Gender(1:ceil(split_fraction*size(I,2)));
ytrain_Race = Race(1:ceil(split_fraction*size(I,2)));

ytrain_Age = ytrain_Age;
ytrain_Gender = yGen(ytrain_Gender+1,2);
ytrain_Race = yGen(ytrain_Race+1,5);

% Test Data Load
Xtest = X(ceil(split_fraction*size(I,2))+1:size(I,2));
ytest_Age = Age(ceil(split_fraction*size(I,2))+1:size(I,2));
ytest_Gender = Gender(ceil(split_fraction*size(I,2))+1:size(I,2));
ytest_Race = Race(ceil(split_fraction*size(I,2))+1:size(I,2));

ytest_Age = ytest_Age;
ytest_Gender = yGen(ytest_Gender+1,2);
ytest_Race = yGen(ytest_Race+1,5);

%% Training a ConvNet

fprintf('Training.....\n\n');
    
[pred,t,Jnn_o,C,P,s,Kernel_Size,S,L,La] = cnnX(Xtrain,ytrain_Race);

%% Writing Data onto your Computer

fprintf('Kindly Select the folder where you wish to store all your Trained Parameters. \n');


