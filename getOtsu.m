%% GetOtsu
% Give Otsu, use Otsu thresholding and return the Black and what image
% based on Otsu thresholding.
function BW=getOtsu(img) 
    level = graythresh(img);
    BW = im2bw(img,level);
end