% function imgDB = constructImgDatabase()

function imgDB = constructImgDatabase()

    addpath('./imgDB');
    addpath('./imgDB/Rays_menu_pics');
    addpath('./imgDB/Thanksgiving_menu_pics');
    addpath('./imgDB/Bytes_menu_pics');

%    addpath('./imgDB_test');
    
    % find the correct directory and file
    io_contents = fullfile('names.txt');
    
    % read the file
    filetext = fileread(io_contents);
    
    % each line is separated by a newline ('\n')
    
    expr = '\w+';
    fileread_info = regexp(filetext,expr,'match','dotexceptnewline')'
    numIt = numel(fileread_info)
    
    imgDB = cell(numIt, 1);
    for i=1:numIt
        imgDB{i} = {fileread_info{i}, imread([fileread_info{i} '.jpg'])};
    end

    imgDB

end

% reference data
% http://www.mathworks.com/help/matlab/ref/fileread.html
