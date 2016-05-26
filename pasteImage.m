function imgDst = pasteImage(imgDst, x, y, w, h, imgSrc)
    sz = size(imgSrc);
    imgDst(y:y+sz(1)-1, x+w+5:x+w+5+sz(2)-1, :) = imgSrc(:,:,:);
end