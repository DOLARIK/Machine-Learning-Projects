ex = 1;
for I = 1:size(C,1)
for w = 1:2
for k = 1:size(C{I,w},3)
Cax{I,w} = C{I,w}(:,:,k);
Bax = Cax{I,w};
%{
for i = 1:size(Cax{I,w},1)
    for j = 1:size(Cax{I,w},2)
        if Cax{I,w}(i,j) >= .5
            Bax(i,j) = 1;
        else Bax(i,j) = 0;
        end
    end
end

%imresize(Bax,[128,128]);
%figure = imshow(Bax);
%}
subplot(7,7,1);
pred_label = [num2str(y(I)),'_','D_i_g_i_t ',num2str(prediction(I)),'_','P_r_e_d_i_c_t_i_o_n'];
subimage(Xtest{I}); title(pred_label);
axis off

if w == 1 && ex == 1
    ex = 14;
%    ex = ex + 1
end
if w == 2 && ex == 20
    ex = 28;
%    ex = ex + 1;
end

ex = ex + 1;

label = ['Filter ',num2str(k),'_','W_',num2str(w)];
subplot(7,7,ex); 
subimage(Bax); title(label);
truesize([56 56]);
scale = 0.01;
pos = get(gca, 'Position');
pos(2) = pos(2)+scale*pos(4);
pos(4) = (1-scale)*pos(4);
set(gca, 'Position', pos)
%tightfig;
axis off

%{
imshow(Bax)
%figure, imshow(Bax)


xlabel(label);
scale = 0.25;
pos = get(gca, 'Position');
pos(2) = pos(2)+scale*pos(4);
pos(4) = (1-scale)*pos(4);
set(gca, 'Position', pos)
%resize(Xtest{10000},
%figure()
%imshow(Xtest{10000})
%}
end
%ex = 21;
end
ex = 1;
pause(1)
end

