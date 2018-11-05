function [C,d,X] = convLayer(Input_Layer, Filter, Padding_Req,Stride,s,Kernel_Size)

C = convolve(Input_Layer, Filter, Padding_Req, Stride);

[C,d] = relu(C,s);

[C,X] = maxPool(C, Kernel_Size);