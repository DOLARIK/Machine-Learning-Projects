function MNISTPredict()

while 1
    
    fprintf('We will work with a Vanilla Neural Network with 1 Hidden Layer \n\n');
    
    f1 = input('How many Hidden Neurons should be there in the Hidden Layer? \n');
    s = input('ReLU Slope = ');
    alpha = input('Learning Rate (usualy start with .001) = ');
    lambda = input('Regularization Parameter (b/w 0 and 1) = ');
    iter = input('How many Minimum No. of iterations would you like to have? \n');
    target = input('When would you like to stop the Training? When the Development becomes < ');
    
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
        [pred,t1,t2,loss] = grDnnF(Xtrain,ytrain,f1,s,alpha,lambda,iter,target);

    fprintf('Writing Training Data.....\n\n');
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\pred.csv',pred);
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\theta1.csv',t1);
        dlmwrite('C:\Users\npl\Desktop\Divyanshu\Machine Learning\Machine-Learning\Progress\Models\Neural Networks\MNIST\One Hidden Layer\train\theta2.csv',t2);
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

        [pred1,pred2,pred3,A] = grDnnT1(Xtest,ytest,t1,t2,s);

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

    for i = 1:100 
       M(i) = randi([100*(i-1),i*100],1,1);
    end
    
    for m = 1:100
        
        imshow(a(:,:,M(m))');
        xlabel(pred3(M(m)));
        
        pause(1.2)
        
    end
    
end

