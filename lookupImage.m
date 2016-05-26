
function [matchIdx resImgs] = lookupImage(resArr, imgDB, maxDist)
% matchIdx is a num arrary: 0(not match, no image), other numbers(matched index of imgDB)
% resImgs is a cell array of images

    'lookupImage'
    
    matchIdx = zeros(numel(resArr), 1);
    resImgs = cell(numel(resArr), 1);
    matchName = cell(numel(resArr), 1);
    matchDist = ones(numel(resArr), 1)*maxDist;
    
    minDist = 100;
    match = 0;
    dist = 0;
    matchRate = 0;
    
    for i = 1:numel(resArr)
        
        minDist = 100;
        
        for j = 1:numel(imgDB)
        
            dist = editDist2(resArr{i}{5}, imgDB{j}{1}, maxDist);
            if (dist < minDist)
                minDist = dist;
                match = j;
                if (minDist == 0)
                    ['perfect match: ' resArr{i}{5} ' & ' imgDB{j}{1}]
                    break;
                end
            end
        
        end
        
        if (minDist < maxDist)
            matchRate = matchRate + 1;
            matchIdx(i) = match
            matchDist(i) = minDist
            resImgs{i} = imgDB{match}{2};
            matchName{i} = imgDB{match}{1};
        end
        
    end
    
    matchRate = matchRate/numel(resArr)
    matchIdx
    matchDist
    matchName

end