function MNISTPredict1()


while 1
%% Loading Training Data from the Computer

    fprintf('Kindly Select the folder where you have kept your Train Data \n\n');
    train_data_loc = uigetdir;
    train_data_loc_X = [train_data_loc,'\train-images.idx3-ubyte'];
    train_data_loc_y = [train_data_loc,'\train-labels.idx1-ubyte'];    

    
    fprintf('Reading Training Data..... \n\n');
        X = loadMNISTImages(train_data_loc_X);
        X = X';
        X = [ones(60000,1) X];

        y = loadMNISTLabels(train_data_loc_y);

    fprintf('Loading Training Data.....\n\n')
        Xtrain = X;
        ytrain = yGen(y+1,10);

%% Feeding the Data to the Neural Network        
        
    fprintf('Training.....\n\n');
        [pred,t,loss,s] = nnX(Xtrain,ytrain);

%% Writing the Trained Parameters and Other Values and Storing them somewhere in the Computer        
        
    fprintf('Select the folder in which you wish to store all the generated Data \n\n')
    location1 = uigetdir;
        
    fprintf('Writing Training Data.....\n\n');
    fprintf('Select the folder in which you wish to store the Trained Parameter Data Files \n\n')
    train_loc = uigetdir(location1);
        
        pred_loc = [train_loc,'\pred.csv'];
        dlmwrite(pred_loc,pred);
        
        for k = 1:size(t,2)
            theta_loc = [train_loc,'\theta' num2str(k) '.csv'];
            dlmwrite(theta_loc,t{k});
        end
        
        loss_loc = [train_loc,'\loss.csv'];
        dlmwrite(loss_loc,loss);
        
    fprintf('Kindly check your Training Data files, the data has been written onto those files.\n\n');

%% Loading the Test Data    
    
    fprintf('Kindly Select the folder where you have kept your Test Data \n\n');
    test_data_loc = uigetdir;
    test_data_loc_X = [test_data_loc,'\t10k-images.idx3-ubyte'];
    test_data_loc_y = [test_data_loc,'\t10k-labels.idx1-ubyte'];
    
    fprintf('Reading Test Data.....');
        X = loadMNISTImages(test_data_loc_X);
        X = X';
        X = [ones(10000,1) X];

        y = loadMNISTLabels(test_data_loc_y);

    fprintf('Loading Test Data.....\n\n')
        Xtest = X;
        ytest = yGen(y+1,10);


%% Predicting Target Values using the Trained Parameters        
        
    fprintf('Predicting Test Values..... \n\n');

        [pred1,pred2,pred3,A] = nnTX(Xtest,y,t,s);

    fprintf('ACCURACY = %g \n\n', A);

%% Storing Prediction Values in the Computer    
    
    fprintf('Select the folder in which you wish to store the Test Prediction Data \n\n')
    test_loc = uigetdir(location1);
    
    fprintf('Writing Test Data..... \n\n');
        pred1_loc = [test_loc,'\pred1.csv'];
        dlmwrite(pred1_loc,pred1);
        
        pred2_loc = [test_loc,'\pred2.csv'];
        dlmwrite(pred2_loc,pred2);
        
        pred3_loc = [test_loc,'\pred3.csv'];
        dlmwrite(pred3_loc,pred3);
        
        accuracy_loc = [test_loc,'\Accuracy.txt'];
        dlmwrite(accuracy_loc,A);
    fprintf('Kindly check your Test Data files, the data has been written onto those files.\n\n');

    a = dtim(Xtest(:,2:785));
       
    if A > 85
        fprintf('Pretty Good Model. Good Job :) \n');
        break
    else fprintf('Try Retraining the Model with a different Architecture\n');
    end
    
end

%% Slideshow Presentation of Predictions
    for i = 1:100 
       M(i) = randi([100*(i-1),i*100],1,1);
    end

    figure();
    
    for m = 1:100
        
        imshow(a(:,:,M(m))');
        xlabel(pred3(M(m)));
        
        pause(.8)
        
    end
end
    
