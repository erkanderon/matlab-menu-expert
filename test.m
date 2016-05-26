clear all; close all;

menu   = imread('menu_in.png');

ocrResults     = ocr(menu)
recognizedText = ocrResults.Text;
figure;
imwrite(menu, 'imgCp.png');
imshow(menu);

recognizedText

        h = imrect(gca, [size(menu, 2)*1/4 size(menu, 1)*1/4 size(menu, 2)/2 size(menu, 1)/2]);
        addNewPositionCallback(h,@(p) title(mat2str(p,3)));
        fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
        setPositionConstraintFcn(h,fcn); 

% bounding box (manually): [43.75 124.5 95.5 58]


imshow(strcat(recognizedText,'.jpg'))
