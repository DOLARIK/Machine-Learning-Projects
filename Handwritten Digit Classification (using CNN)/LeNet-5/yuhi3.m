%function MNISTPredict()

%% Loading Training Data

    fprintf('Reading Training Data..... \n\n');
        X = loadMNISTImages('train-images.idx3-ubyte');
        X = X';
        %X = [ones(60000,1) X];
        
        tic
        for i = 1:size(X,1)
            B{i} = (squashR(X(i,:),zeros(28,28))');
        end
        toc
        
        y = loadMNISTLabels('train-labels.idx1-ubyte');

    fprintf('Loading Training Data.....\n\n')
        Xtrain = B;
        ytrain = yGen(y+1,10);
%% Convolutional Neural Network Trainng
    tic
    fprintf('Training.....\n\n');
    
        [pred,t,Jnn_o,C,P,s,Kernel_Size,S,L,La] = cnnX(Xtrain,ytrain);

        
    toc

    
%% Loading Test Data

    fprintf('Reading Test Data..... \n\n');
        X = loadMNISTImages('t10k-images.idx3-ubyte');
        X = X';
        %X = [ones(60000,1) X];
        
        tic
        for i = 1:size(X,1)
            B{i} = (squashR(X(i,:),zeros(28,28))');
        end
        toc
        
        y = loadMNISTLabels('t10k-labels.idx1-ubyte');

    fprintf('Loading Test Data.....\n\n')
        Xtest = B;
        ytest = yGen(y+1,10);
        
%% Convolutional Neural Network Testing

    fprintf('\n\n');
    fprintf('Testing\n');
    
        [prediction, A, C] = cnnTX(Xtest,y,t,P,s,Kernel_Size,S,L,La); %X,y,t,P,s,Kernel_Size,S,L,La
        
    fprintf('\n\n');