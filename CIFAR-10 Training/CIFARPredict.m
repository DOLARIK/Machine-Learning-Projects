%% Data Extraction and Importing

extract_cifar;

%% Data Preparation

cifar_data_prep;

%% Training

fprintf('Now we shall begin Training. \n\n');

[pred,t,Jnn_o,Ct,P,s,Kernel_Size,S,L,La] = cnnX(Xtrain,ytrain);

%% Loading Test Data

cifar_test_prep;

%% Testing

fprintf('Exam Time!! \n\n');

[prediction, A, C] = cnnTX(Xtest,labels_test,t,P,s,Kernel_Size,S,L,La);