
for i = 20796:size(label,2)
    a = strsplit(label{i},'_');
    Age(i) = str2num(a{1,1});
    Gender(i) = str2num(a{1,2});
    Race(i) = str2num(a{1,3});
    
    if i == 15016
        Race(i) = 1;
    elseif i == 20794
        Race(i) = 1;
    elseif i == 20795
        Race(i) = 3;
    else
        Race(i) = str2num(a{1,3});
    end
end

Gender = Gender';
Race = Race';
Age = Age';