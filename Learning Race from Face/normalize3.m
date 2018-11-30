function A = normalize3(X)
W = size(X,4);
K = size(X,3);

ex = 1;
loss_s{1} = '';
%fprintf('|');

for w = 1:W
    for k = 1:K
    
        A(:,:,k,w) = ((X(:,:,k,w) - min(min(X(:,:,k,w))))./(max(max(X(:,:,k,w))) - min(min(X(:,:,k,w)))));
        
    end
    %{
    if rem(w,ceil(W/50)) == 0
            
                       
            for dex = 1:length(loss_s{ex})
                fprintf('\b');
            end
        
            ex = ex + 1;
            
            fprintf('=')
            dash = '';
            if rem(W,50) == 0
                dexa_l = 50-ex+1;
            else
                dexa_l = 49-ex+1;
            end
            
            for dexa = 1:dexa_l
                dash = [dash,'-'];
            end
        
            loss_s{ex} = [dash,'> ',num2str(w),' Images Normalized'];
        
            fprintf(loss_s{ex})        
        
        end
        if w == W
            fprintf('\n');
            ex = 1;
        end
    %}
end
