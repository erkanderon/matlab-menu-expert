function imgCp = dispRes(imgCp, matchIdx, resImgs, resArr)
    % resArr{i} = {x, y, w, h, txt}
    % matchIdx 
    % resImgs 
    
    % scale up the cropped image to width = WIDTH
    WIDTH = 800;
    sz = size(imgCp);
    imgCp = imresize(imgCp, [sz(1)*WIDTH/sz(2) WIDTH]);
    ratio = WIDTH/sz(2);
    
    for i=1:numel(resArr)
        
        if (matchIdx(i) > 0)
            sz = size(resImgs{i});
            imgCp = pasteImage(imgCp, resArr{i}{1}*ratio, resArr{i}{2}*ratio, resArr{i}{3}*ratio, resArr{i}{4}*ratio, ...
                imresize(resImgs{i}, [resArr{i}{4}*ratio sz(2)*resArr{i}{4}*ratio/sz(1)]));
        end
        
    end
    
    figure(105);
    imshow(imgCp);
    imwrite(imgCp, 'dispRes.png');


end