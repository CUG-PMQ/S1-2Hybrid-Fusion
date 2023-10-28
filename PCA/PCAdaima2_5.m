%% 图像融合imread('RGB11.tif');

multispectralImage = imread('quyu1-1.tif');
%multispectralImage = im2double(multispectralImage);
multispectralImage = mat2gray(multispectralImage);
%multispectralImage = im2uint8(multispectralImage);
%multispectralImage = im2double(multispectralImage);
%multispectralImage = uint16(multispectralImage);
% im=mat2gray(multispectralImage);
% im=im2uint16(im);
% m = multispectralImage(:,:,2:4);
% imwrite(m,'band16.tif');

%%%
% panchromaticImage = imread('SAR111.tif');
panchromaticImage = imread('quyu1-VV.tif');
%panchromaticImage = im2double(panchromaticImage);
panchromaticImage = mat2gray(panchromaticImage);
%%panchromaticImage = uint16(panchromaticImage);

fusionImage = ImageFusion(multispectralImage,panchromaticImage);

%figure(3) 
% imshow(fusionImage(:,:,2:4));
% %imshow(fusionImage);
% imwrite(fusionImage,'1.tif');


F=fusionImage(:,:,1:3);
%F = fusionImage;
%figure;
str = sprintf('%s%d%s','第',3,'主成分');
% imshow(mat2gray(F));title(str);
% imwrite(mat2gray(F),'3bandronghe11.tif');
%imshow(F);title(str);
imwrite(F,'PCA1.tif');
%Tiff(F,'8band1111.tif');


