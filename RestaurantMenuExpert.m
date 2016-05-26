% Restaurant Menu Expert
% imgSrcType
% 1: webcam
% 2: test image

function RestaurantMenuExpert(imgSrcType)

%clear all; 
close all;

't_imgDB start!'
tic;
%% stage 0
% construct the string-image database, this can be executed only once then export to file
imgDB = constructImgDatabase();
% imgDB is a array of cell of cell, 
% imgDB{item_idx}{1} is the name string, imgDB{item_idx}{2} is the corresponding image
t_imgDB = toc

frmidx = 0;

while 1

    frmidx = frmidx+1;

    %% stage 1
    % keep capturing & displaying frames until user press "enter", then output the last image 
    % (from camera or stored images, process into matlab image structure)
        [imgCam imgCp ROI] = captureImageAndROISel(imgSrcType);
        sz_imgCp = size(imgCp)
        
    
    %% stage 2
    % image pre-processing: rotation, image adjustment
    % image segmentation into connected components
    % OCR string result
        resArr = imageSegmentAndOCR(imgCp);
        resArr = getOCRBoundingBox(imgCp, 1, imgSrcType);

        % resArr is a cell array with element resArr{i} = {x, y, w, h, txt}, x & y are the up-left corner
        % numel(resArr) is the total num of detected items
        % ex: 
        %   data = cell(3, 1)
        %   data{1} = {1, 2, 3, 4, 'test'}
        %   data{1}{5}, ans = test

    't_OCR_correct start!'
    tic;
    %% stage 3
    % string matching with our menu image database, and load the corresponding photo
        [matchIdx, resImgs] = lookupImage(resArr, imgDB, 9);
        % matchIdx is a num arrary: 0(not match, no image), other numbers(matched index of imgDB)
        % resImgs is a cell array of images
    t_OCR_correct = toc
    
    't_display start!'
    tic;
    %% stage 4
    % display all search results on the source image
        imgo = dispRes(imgCp, matchIdx, resImgs, resArr);
    t_display = toc
    
    %keyboard
    break
    
    %% stage 5
    % side-by-side show our result and source image
        % imgCp, imgo
        
    
    
    ['frame#:' num2str(frmidx)]

end

end




