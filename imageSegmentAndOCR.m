% function resArr = imageSegmentAndOCR(img)
% resArr is a cell array with element resArr{i} = {x, y, w, h, txt}, x & y are the up-left corner
% numel(resArr) is the total num of detected items


function resArr = imageSegmentAndOCR(img)
    
    menu   = img;
    ocrResults = ocr(menu)
    recognizedText = ocrResults.Text;
    imwrite(menu, 'menu_in.png');
    figure(4); clf(4);
    imshow(menu);
    recognizedText
    regexRes = regexp(recognizedText,'\w+','match')
    regexRes = lower(regexRes{1}); % only take 1st string
    
        h = imrect(gca, [size(menu, 2)*1/4 size(menu, 1)*1/4 size(menu, 2)/2 size(menu, 1)/2]);
        addNewPositionCallback(h,@(p) title(mat2str(p,3)));
        fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
        setPositionConstraintFcn(h,fcn); 

    % bounding box (manually): [43.75 124.5 95.5 58]
    
    resArr = cell(1,1);
    resArr{1} = {44, 125, 96, 58, regexRes}
    
end