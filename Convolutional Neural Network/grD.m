function t = grD(t,Delta,lambda,H,alpha)

        for l = 1:H+1
            t{l} = t{l}*(lambda) - alpha*(Delta{l});
        end
        
end