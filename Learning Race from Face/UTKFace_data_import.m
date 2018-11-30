
fprintf('Kindly Select the folder where you have kept the data file. \n');
data_folder_loc = uigetdir;
data_file_loc    = [data_folder_loc,'\UTKFace.tar.gz'];

fprintf('Kindly Select the Folder where you wish to extract all the Images. \n');
data_extract_folder_loc = uigetdir;

fprintf('Now, This is going to take quite a while, so sit back and relax. \n');
%untar(data_file_loc, data_extract_folder_loc);

fprintf('All the Images have been extracted from the Compressed File. \n');

fprintf('Now we will begin Importing them into MATLAB. \n');

images_folder_loc = [data_extract_folder_loc,'\UTKFace\'];
images_loc        = [images_folder_loc,'*.jpg'];
srcFile = dir(images_loc);

ex = 1;
loss_s{1} = '';
n = length(srcFile);
fprintf('|');

for i = 1:n
    
    
    file_name = strcat(images_folder_loc, srcFile(i).name);
    
    Image{i} = imread(file_name);
    label{i} = srcFile(i).name;
    
    a = strsplit(label{i},'_');
    Age(i) = str2num(a{1,1});
    Gender(i) = str2num(a{1,2});
    
    if i == 15016
        Race(i) = 1;
    elseif i == 20794
        Race(i) = 1;
    elseif i == 20795
        Race(i) = 3;
    else
        Race(i) = str2num(a{1,3});
    end
    
    if rem(i,ceil(n/50)) == 0
            
                       
            for dex = 1:length(loss_s{ex})
                fprintf('\b');
            end
        
            ex = ex + 1;
            
            fprintf('=')
            dash = '';
            if rem(n,50) == 0
                dexa_l = 50-ex+1;
            else
                dexa_l = 49-ex+1;
            end
            
            for dexa = 1:dexa_l
                dash = [dash,'-'];
            end
        
            loss_s{ex} = [dash,'> ',num2str(i),' Images Imported'];
        
            fprintf(loss_s{ex})        
        
        end
        if i == n
            fprintf('\n');
            ex = 1;
        end
    
end

Gender = Gender';
Race = Race';
Age = Age';

fprintf('Congratulation!! All the Images have been Successfully Imported. \n');