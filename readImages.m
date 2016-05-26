%% Read Images
% Returns a cell structure of all images in the provided filepath directory
% Note: only finds .jpg files
function data = readImages(filepath)
    fnames = dir(strcat(filepath, '*.jpg'));
    numfids = length(fnames);
    data = cell(1,numfids);
    for K = 1:numfids
      data{K} = imread(...
          strcat(filepath, fnames(K).name));
    end
end