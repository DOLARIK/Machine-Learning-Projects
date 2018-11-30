function [C,dX] = convLayer(Input_Layer, Filter, Padding_Req,Stride,s,Kernel_Size,b)

C = convolve(Input_Layer, Filter, Padding_Req, Stride,0,0,b);

[D,d] = relu(C,s);

[C,X] = maxPool(D, Kernel_Size);

dX = X.*d;