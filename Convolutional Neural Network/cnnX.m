function [pred,t,Jnn_o,C,P,s,Kernel_Size,S,L,La] = cnnX(X,y)
%%
fprintf('\n\n');
fprintf('HEYY!! \n\n');
fprintf('I will be asking you some Doubts regarding the Problem for better learning. \n');
fprintf('Kindly read the questions carefully, you will get only one chance to answer them. \n');
fprintf('All the Questions are compulsory. \n\n')


fprintf('Press Enter Whenever Ready :) \n\n\n');


pause


L  = input('How Many Convolutional Layers do you wish to have in your model? \n');


Nh{1} = size(X{1},1);
Nw{1} = size(X{1},2);
Nd{1} = size(X{1},3);                                                  
classes = size(y,2);

%% Initializing Parameters for Convolutional Layers
for l = 1:L

    fprintf('What should be the Filter Size to build Convolutional Layer %g?',l);
    F{l} = input('\n');
    fprintf('How many Filters do you wish to have for this same layer?');
    K{l} = input('\n');
    
    t{l} = rand(F{l},F{l},Nd{l},K{l})*(2*.001) - .001;
    Delta{l} = zeros(F{l},F{l},Nd{l},K{l});
    Vdw{l} = zeros(F{l},F{l},Nd{l},K{l});
    Sdw{l} = zeros(F{l},F{l},Nd{l},K{l});
    
    fprintf('Should there be a Need of Padding in the Previous Layer? (If Yes, type 1. If No, type 0)');
    P{l} = input('\n');
    fprintf('What Stride should the Filter take?');
    S{l} = input('\n');
    
    fprintf('We are using ReLU as the activation function. What should be the slope of the line in x < 0? (For ConvLayer %g)',l);
    s{l} = input('\n');
    
    fprintf('What should be the Kernel Size while Max Pooling for ConvLayer %g? ',l);
    Kernel_Size{l} = input('\n');

    
    if P{l} == 1
        Same{l} = input('Do you wish to keep this layer of the same size as previous? \n (If Yes then type 1, otherwise 0) \n');
        if Same == 0
            Padding_Size{l} = input('How many Layers of Zero_Padding should be made? \n');
        end
    else Same{l} = 0; Padding_Size{l} = 0;
    end
    
    Nh{l+1} = ((((((Nh{l} - F{l})/S{l}) + 1) - Kernel_Size{l})/Kernel_Size{l}) + 1);
    Nw{l+1} = ((((((Nw{l} - F{l})/S{l}) + 1) - Kernel_Size{l})/Kernel_Size{l}) + 1);
    Nd{l+1} = K{l};
    
end

%% General Hyperparameter Initialization
fprintf('What should be the Regularization Parameter? (usually lies between 0.5 and 1, closer to 1) ->');
lambda = input('\n');

fprintf('What should be the Learning Rate? (usually we take .001) ->');
alpha = input('\n');

iter = input('How many Minimum No. of iterations would you like to have? \n');

target_dev = input('When would you like to stop the Training? When the Development becomes < ');
target_loss = input(' and Loss becomes < ');
fprintf('\n');

B1 = input('What should be the value of B1 for Adam Optimizer? (Usually .9)');
fprintf('\n');
B2 = input('What should be the value of B2 for Adam Optimizer? (Usually .999)');
fprintf('\n');
E = input('What should be the value of E for Adam Optimizer? (Usually 1.0e-8, "7 zeroes after decimal and then 1"');
fprintf('\n');

Flatten_Length = Nh{L+1}*Nw{L+1}*K{L};

fprintf('You get a Flattened Layer of Length = %g \n', Flatten_Length);

La = input('How many Fully Connected Layers do you wish to have in your model? (Excluding the Output Layer) \n');

%% Initializing Parameters for Fully Connected Layers (followed by the Convolutional Layers)
for la = 1:La
    fprintf('How many nodes do you wish to have in FC Layer %g = ', la);
    f{la} = input('\n');
end

for la = 1:La+1
    %fprintf('How many nodes do you wish to have in FC Layer %g = ', la);
    %f{la} = input('\n');
    if la == 1
        
        t{L + la} = rand(Flatten_Length,f{la})*(2*.001) - .001;
        Delta{L + la} = zeros(Flatten_Length,f{la});
        Vdw{L + la} = zeros(Flatten_Length,f{la});
        Sdw{L + la} = zeros(Flatten_Length,f{la});
    end
    
    if la > 1 && la < La+1
        
        t{L + la} = rand(f{la-1},f{la})*(2*.001) - .001;
        Delta{L + la} = zeros(f{la-1},f{la});
        Vdw{L + la} = zeros(f{la-1},f{la});
        Sdw{L + la} = zeros(f{la-1},f{la});
    end
    
    if la == La+1
        
        t{L + la} = rand(f{la-1},classes)*(2*.001) - .001;
        Delta{L + la} = zeros(f{la-1},classes);
        Vdw{L + la} = zeros(f{la-1},classes);
        Sdw{L + la} = zeros(f{la-1},classes);
    end
end

%fprintf('So your Model has %g Convolutional Layers (1 Convolutional Layer involves Convolving once over the input Layer and then Subsampling through Max Pooling). \n', L);    
ex = 1;
loss_s{1} = '';
Jnn_o = 0;

%% Training Begins from here on

fprintf('Now the Training Begins...\n\n');

o = 1;

while 1
    fprintf('|');
    for i = 1:size(y,1)
    %fprintf('Sample No. - %g & ',i);
    % Forward Propagation
    
        % Convolutional Layers
    
        for l = 1:L
        
            if l == 1
                [C{l},dC{l}] = convLayer(X{i},t{l},P{l},S{l},s{l},Kernel_Size{l},0);
            else
                [C{l},dC{l}] = convLayer(C{l-1},t{l},P{l},S{l},s{l},Kernel_Size{l},0);
            end
        end
        
        % Flatten
        
        C{L+1} = squash(C{L});                          % Input Layer of Fully Connected Layers
        
        % Fully Connected Layers
        
        for l = 1:La+2
                
            if l >= 2 && l <= La+1                      % Hidden Layers
                h = C{L + l-1}*t{L + l-1};
                [C{L + l},dC{L + l}] = relu(h,.1);
            
            end
            
            if l == La+2                                % Output Layer
                C{L + l} = C{L+l-1}*t{L+l-1};
                [pred(i,:),dC{L+l}] = sigmoid(C{L+l});
            end
            
        end
        
    % Backward Propagation
    
        %Fully Connected Layers
        
        for l = 1: (La+2)
            
            if l == 1
                % Cross Entropy Loss Gradient = (-1*((y(i,:)./pred(i,:))-((1-y(i,:))./(1-pred(i,:)))))
                % Mean Squared Error Gradient = (pred(i,:) - y(i,:))
                % You can select any of the above Loss Gradient and use it
                % for the variable 'loss_gradient'
                % Just make sure that you use the respective cost Function
                % in the function 'costNN()'
                loss_gradient = (-1*((y(i,:)./pred(i,:))-((1-y(i,:))./(1-pred(i,:))))); 
                d{L+La+3-l} = (loss_gradient).*dC{L+La+3-l};
            end
            
            if l >=2 && l<=La+1
                d{L+La+3-l} = ((d{(L+La+3-l)+1})*(t{L+La+3-l}')).*dC{L+La+3-l};
            end
            
            if l == La+2
                break
            end
        end
        
        % Convolutional Layers
        
        for l = La+2:L+La+1
            
            if l == La+2
                dPool{L+La+2-l} = ((d{(L+La+3-l)+1})*(t{L+La+3-l}'));
                dPool{L+La+2-l} = squashR(dPool{L+La+2-l},C{L});
                dogo = zeros((Nh{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,(Nw{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,K{L+La+2-l});
                dreluQ{L+La+2-l} = sRmod(dPool{L+La+2-l},dogo,Kernel_Size{L+La+2-l}).*dC{L+La+2-l};
                for it = 1:Nd{L+La+2-l}
                    for jt = 1:Nd{L+La+3-l}
                        delta{L+La+2-l}(:,:,it,jt) = convolve(C{L+La+2-l-1}(:,:,it),cbmod(dreluQ{L+La+2-l}(:,:,jt),S{L+La+2-l}),0,1,0,0,0);
                        
                    end
                end
            end
            
            if l>La+2 && l<L+La+1
                dPool{L+La+2-l} = convolve(cbmod(dreluQ{L+La+2-l+1},S{L+La+2-l+1}),rotapi(t{L+La+2-l+1}),1,1,0,F{L+La+2-l+1} - 1,1);
                dogo = zeros((Nh{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,(Nw{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,K{L+La+2-l});
                dreluQ{L+La+2-l} = sRmod(dPool{L+La+2-l},dogo,Kernel_Size{L+La+2-l}).*dC{L+La+2-l};
                for it = 1:Nd{L+La+2-l}
                    for jt = 1:Nd{L+La+3-l}
                        delta{L+La+2-l}(:,:,it,jt) = convolve(C{L+La+2-l-1}(:,:,it),cbmod(dreluQ{L+La+2-l}(:,:,jt),S{L+La+2-l}),0,1,0,0,0);
                    end
                end
            end
            
            if l == L+La+1
                dPool{L+La+2-l} = convolve(cbmod(dreluQ{L+La+2-l+1},S{L+La+2-l+1}),rotapi(t{L+La+2-l+1}),1,1,0,F{L+La+2-l+1} - 1,1);
                dogo = zeros((Nh{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,(Nw{L+La+2-l}-F{L+La+2-l})/S{L+La+2-l} + 1,K{L+La+2-l});
                dreluQ{L+La+2-l} = sRmod(dPool{L+La+2-l},dogo,Kernel_Size{L+La+2-l}).*dC{L+La+2-l};
                for it = 1:Nd{L+La+2-l}
                    for jt = 1:Nd{L+La+3-l}
                        delta{L+La+2-l}(:,:,it,jt) = convolve(X{i}(:,:,it),cbmod(dreluQ{L+La+2-l}(:,:,jt),S{L+La+2-l}),0,1,0,0,0);
                    end
                end
            end
                
            if l == L+La+2
                break
            end
        
        end
        
        for l = 1:L+La+1
            if l <= L
                Delta{l} = delta{l};
            end
            
            if l>L && l<=L+La+1
                Delta{l} = (C{l}')*d{l+1};
            end
        end
        
    % Optimizer
    
        [t,Vdw,Sdw] = adam(t, Delta, o, B1, B2, E, Vdw, Sdw, L+La, alpha);%t = grD(t,Delta,lambda,L+La,alpha);
        
        format long
     
    % Waitbar
        if rem(i,ceil(size(y,1)/50)) == 0
            
                       
            for dex = 1:length(loss_s{ex})
                fprintf('\b');
            end
        
            ex = ex + 1;
            
            fprintf('=')
            dash = '';
            if rem(size(y,1),50) == 0
                dexa_l = 50-ex+1;
            else
                dexa_l = 49-ex+1;
            end
            
            for dexa = 1:dexa_l
                dash = [dash,'-'];
            end
        
            loss_s{ex} = [dash,'> Loss - ',num2str(costNN(y(1:i,:),pred(1:i,:)),10),' | ',num2str(i),' Samples Completed |',' Epoch No. ',num2str(o)];
        
            fprintf(loss_s{ex})        
        
        end
        if i == size(y,1)
            fprintf('\n');
            ex = 1;
        end
        
    end
    
    Jnn_h = costNN(y,pred);                                 % Cost Calculation per Iteration
    Jnn_o = [Jnn_o; Jnn_h];
       
    if o>iter
    fprintf('Iteration No. %i || Loss = %g || Development = %g \n',[o, Jnn_h, (Jnn_o(o-(iter-1)) - Jnn_o(o))]);
    else
        fprintf('Iteration No. %i || Loss = %g \n',[o, Jnn_h]);
    end
    
    if o > iter || (Jnn_h < target_loss && Jnn_h > 0)
        if o > iter
            if (Jnn_o(o-(iter-1)) - Jnn_o(o)) < target_dev         % Stop Condition for Training
               break
            end
        else
            break
        end
    end
        
    o = o + 1;
end
toc

%% Plotting the Loss Function

plot(Jnn_o(2:o))                                    % 'Loss vs Epochs' Plot
xlabel('Epochs');ylabel('Loss_T_r_a_i_n');


end
        
            
    
    

