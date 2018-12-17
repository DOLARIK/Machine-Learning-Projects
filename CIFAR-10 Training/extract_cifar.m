%% Extraction
fprintf('Select the Folder where you have kept your File. \n');
folder_loc = uigetdir;

fprintf('Select the Folder where you want to Extract the Data. \n');
extract_folder_loc = uigetdir;

file_loc = [folder_loc,'\cifar-10-matlab.tar.gz'];
untar(file_loc,extract_folder_loc);

%% Loading
fprintf('Loading Train Data. \n');
for i = 1:5
    file = [extract_folder_loc,'\data_batch_',num2str(i)];
    X{i} = load(file,'data');
    y{i} = load(file,'labels');
end

