function [t,Vdw,Sdw] = adam(t, Delta, iter, B1, B2, E, Vdw, Sdw, H, alpha)

        
        for l = 1:H+1
            
            Vdw{l} = (B1*Vdw{l}) + (1-B1)*Delta{l};
            Sdw{l} = (B2*Sdw{l}) + (1-B2)*((Delta{l}).^2);
            
            Vdw_corr{l} = Vdw{l}/(1-(B1.^iter));
            Sdw_corr{l} = Sdw{l}/(1-(B2.^iter));
            
        % Variables to ensure the elimination of NaN from the Weight    
            boom = Vdw_corr{l}./((Sdw_corr{l}.^.5)+E);
            
            boom_hasnan = isnan(boom);
            
            boom_boom = t{l}(boom_hasnan);
           
        % Weight Update     
            t{l} = t{l} - alpha*(boom);
            
        % Removing all the NaNs from the Weight(if any)
            boom_boom_size = size(boom_boom);
  
            if boom_boom_size(1,1) == 0 || boom_boom_size(1,2) == 0
                t{l} = t{l};
            else
            t{l}(boom_hasnan) = boom_boom;
            end            
        end