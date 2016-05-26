% function [imgCam imgCp ROI] = captureImageAndROISel(type)
% type: 1 = webcam, 2 = test image
% imgCam: cam image
% imgCp: cropped image by ROI

% first, directly test by command window
% Trial>>  webcamlist
% ans = 
%     'Logitech HD Pro Webcam C920'
%     'USB 2.0 1.3M UVC WebCam'
% Trial>> cam = webcam(1)
% cam = 
%                     Name: 'Logitech HD Pro Webcam C920'
%               Resolution: '640x480'
%     AvailableResolutions: {1x19 cell}
%             ExposureMode: 'auto'
%             ...
% 

function [imgCam imgCp ROI] = captureImageAndROISel(type)

    if (type == 1)
        webcamlist
        cam = webcam(1)
        imgCands = cell(1,5);
        imgCnt = 0;
        while (imgCnt < 20)
            imgCnt = imgCnt+1;
            imgCam = snapshot(cam);
            figure(1); clf(1)
            imshow(imgCam);
            imwrite(imgCam, ['capImg_' num2str(mod(imgCnt, 10)+1) '.png']);
            if (imgCnt-15 > 0)
                imgCands{imgCnt-15} = imgCam
            end
            imgCnt
        end
        % get best shot within 5 images
        bestIdx = 0;
        sharp = 0;
        for i=1:5
            [Gmag,Gdir] = imgradient(imgCands{i}(:,:,2)); % only see G-channel
            gsum = sum(sum(abs(Gmag)));
            if (gsum > sharp)
                sharp = gsum;
                bestIdx = i;
            end
        end
        sharp
        bestIdx
        imgCam = imgCands{bestIdx};
        
        clear cam;

%        figure(2); clf(2);
%        imshow(imgCam);
%        imwrite(imgCam, 'imgCam.png');
%        title('Please select the ROI');
%        h = imrect(gca, [size(imgCam, 2)*1/4 size(imgCam, 1)*1/4 size(imgCam, 2)/2 size(imgCam, 1)/2]);
%        addNewPositionCallback(h,@(p) title(mat2str(p,3)));
%        fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'));
%        setPositionConstraintFcn(h,fcn); 
%        ROI = input('Enter ROI (x, y, width, height): ');
%        ROI
%        imgCp = imcrop(imgCam, ROI);
%        figure(3); clf(3);
%        imshow(imgCp);
%        title('Cropped Image with Selected ROI');
%        imwrite(imgCp, 'imgCp.png');
        
    else
%        imgCam = imread('menua.jpg');
        imgCam = imread('menu-English.jpg');
%        imgCam = imread('test_menu.png');
    end


    figure(2); clf(2);
    imwrite(imgCam, 'imgCam.png');
    [imgCp, ROI] = imcrop(imgCam);
    figure(3); clf(3);
    imshow(imgCp);
    title('Cropped Image with Selected ROI');
    imwrite(imgCp, 'imgCp.png');
    ROI;

end


% reference data
% http://www.mathworks.com/matlabcentral/answers/5634-image-capture-using-webcam
%     this might be useful, about color space problem

% http://www.mathworks.com/help/supportpkg/usbwebcams/ug/acquire-images-from-webcams.html
%     get images from a webcam

% http://www.mathworks.com/help/images/ref/imrect.html
%     imrect example