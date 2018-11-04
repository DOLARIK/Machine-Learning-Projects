function MNISTPredict()

while 1
    
    fprintf('We will work with a Vanilla Neural Network with N Hidden Layers \n\n');
    
    H = input('How many Hidden Layers should be there? \n');
    s = input('ReLU Slope = ');
    alpha = input('Learning Rate (usualy start with .001) = ');
    lambda = input('Regularization Parameter (b/w 0 and 1) = ');
    iter = input('How many Minimum No. of iterations would you like to have? \n');
    target_dev = input('When would you like to stop the Training? When the Development becomes < ');
    target_loss = input(' and Loss becomes < ');
    fprintf('\n');
    
    fprintf('Reading Training Data..... \n\n');
        X = loadMNISTImages('train-images.idx3-ubyte');
        X = X';
        X = [ones(60000,1) X];

        y = loadMNISTLabels('train-labels.idx1-ubyte');

    fprintf('Loading Training Data.....\n\n')
        Xtrain = X;
        ytrain = yGen(y+1,10);

    fprintf('Training.....\n\n');
        [pred,t,loss] = nnX(Xtrain,ytrain,H,s,alpha,lambda,iter,target_dev,target_loss);

    fprintf('Writing Training Data.....\n\n');
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\pred.csv',pred);
        for k = 1:size(t,2)
            theta_loc = ['C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\theta' num2str(k) '.csv'];
            dlmwrite(theta_loc,t{k});
        end
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\loss.csv',loss);
    fprintf('Kindly check your Training Data files, the data has been written onto those files.\n\n');

    fprintf('Reading Test Data.....');
        X = loadMNISTImages('t10k-images.idx3-ubyte');
        X = X';
        X = [ones(10000,1) X];

        y = loadMNISTLabels('t10k-labels.idx1-ubyte');

    fprintf('Loading Test Data.....\n\n')
        Xtest = X;
        ytest = yGen(y+1,10);


    fprintf('Predicting Test Values..... \n\n');

        [pred1,pred2,pred3,A] = nnTX(Xtest,y,t,s);

    fprintf('ACCURACY = %g \n\n', A);
    
    fprintf('Writing Test Data..... \n\n');
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\test\pred1.csv',pred1);
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\test\pred2.csv',pred2);
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\test\pred3.csv',pred3);
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\test\accuracy.txt',A);
    fprintf('Kindly check your Test Data files, the data has been written onto those files.\n\n');

    a = dtim(Xtest(:,2:785));
       
    if A > 85
        fprintf('Pretty Good Model. Good Job :) \n');
        break
    else fprintf('Try Retraining the Model with a different Architecture\n');
    end
    
end

    for i = 1:100 
       M(i) = randi([100*(i-1),i*100],1,1);
    end

    figure();
    
    for m = 1:100
        
        imshow(a(:,:,M(m))');
        xlabel(pred3(M(m)));
        
        pause(.8)
        
    end
    
