function [pred,t,loss,C] = cnnX(X,y)

L  = input('How Many Convolutional Layers do you wish to have in your model? \n');


% Initializing Parameters
for l = 1:L

    fprintf('What should be the Filter Size to build Convolutional Layer %g?',l);
    F{l} = input('\n');
    fprintf('How many Filters do you wish to have for this same layer?');
    K{l} = input('\n');
    t{l} = rand(F{l},F{l},K{l})*(2*.001) - .001;
    Delta{l} = zeros(F{l},F{l},K{l});
    
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
    end
    
end

Nh{1} = size(X,1);
Nw{1} = size(X,2);
Nd{1} = size(X,3);                                                  
classes = size(y,2);

for l = 1:L
    Nh{l+1} = ((((((Nh{l} - F{l})/S{l}) + 1) - Kernel_Size{l})/Kernel_Size{l}) + 1);
    Nw{l+1} = ((((((Nw{l} - F{l})/S{l}) + 1) - Kernel_Size{l})/Kernel_Size{l}) + 1);
end

Flatten_Length = Nh{L}*Nw{L}*Kernel_Size{L};

fprintf('You get a Flattened Layer of Length = %g \n', Flatten_Length);

La = input('How many Fully Connected Layers do you wish to have in your model? (Excluding the Output Layer) \n');



for la = 1:La+1
    fprintf('How many nodes do you wish to have in FC Layer %g = ', la);
    f{la} = input('\n');
    if la == 1
        t{L + la} = rand(Flatten_Length,f{la})*(2*.001) - .001;
        Delta{L + la} = zeros(Flatten_Length,f{la});
    end
    
    if la > 1 && la < La+1
        t{L + la} = rand(f{la-1},f{la})*(2*.001) - .001;
        Delta{L + la} = zeros(f{la-1},f{la});
    end
    
    if la == La+1
        t{L + la} = rand(f{la-1},classes)*(2*.001) - .001;
        Delta{L + la} = zeros(f{la-1},classes);
    end
end

%fprintf('So your Model has %g Convolutional Layers (1 Convolutional Layer involves Convolving once over the input Layer and then Subsampling through Max Pooling). \n', L);    

fprintf('Now the Training Begins...');

while 1
    
    for i = 1:n
    
    % Forward Propagation
    
        % Convolutional Layers
    
        for l = 1:L
        
            if l == 1
                [C{l},dC{l},dCP{L}] = convLayer(X,t{l},P{l},S{l}, Same{l}, Padding_Size{l});
            else
                [C{l},dC{l},dCP{L}] = convLayer(C{l-1},t{l},P{l},S{l}, Same{l}, Padding_Size{l});
            end
        end
        
        % Flatten
        
        C{L+1} = squash(C{L});                          % Input Layer of Fully Connected Layers
        
        % Fully Connected Layers
        
        for l = 1:La+2
                
            if l >= 2 && l <= La+1                      % Hidden Layers
            
                C{L + l} = C{L + l-1}*t{L + l-1};                                     
                [C{L + l},dC{L + l}] = relu(C{L + l},s);
            
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
                d{L+La+3-l} = (pred(i,:) - y(i,:)).*dC{L+La+3-l};
            end
            
            if l >=2 && l<=La+1
                d{L+La+3-1} = ((d{(L+La+3-1)+1})*(t{L+La+3-l}')).*dC{L+La+3-l};
            end
            
            if l == La+2
                break
            end
        end
        
        % Convolutional Layers
        
        for l = La+2:L+La+2
            
            if l < L+La+2
                d{L+La+3-1} = ((d{(L+La+3-1)+1})*(t{L+La+3-l}')).*dC{L+La+3-l}.*dCP{L+La+3-l};
            end
                
            if l == L+La+2
                break
            end
        
        end
        
            
    
    

