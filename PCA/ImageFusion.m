function fusionImage = ImageFusion(multispectralImage,panchromaticImage)
%图像融合
% multispectralImage = cell2mat(struct2cell(load(multispectralImage_path)));
% multispectralImage = im2double(multispectralImage);
% %multispectralImage = imread('CAIJIAN2-11111.tif');
% 
% panchromaticImage = cell2mat(struct2cell(load(panchromaticImage_path)));
% panchromaticImage = im2double(panchromaticImage);
% %panchromaticImage = imread('VVCAIJIAN1.tif');

[~,~,D] = size(multispectralImage);
[rows,cols] = size(panchromaticImage);
for i = 1 : D
    multispectralImage_resized(:,:,i) = imresize(multispectralImage(:,:,i),[rows,cols],'bilinear');
end
n = rows*cols;%%%%%%%%%%%%%%总像素数
X = [];
for i = 1 : D
    X = [X,reshape(multispectralImage_resized(:,:,i),[],1)];
end
Z = X-ones(n,1)*mean(X);%%%%%%%%%%%%数据去中心化
Sigma = (Z'*Z)/n;%%%%%%%%%%%%%求协方差矩阵
[vector,lambda] = eig(Sigma);%%%%%%%%%%%%%%%求特征向量与特征值
temp = (sortrows([vector;sum(lambda)]',-(D+1)))';
V = temp(1:D,:);
Y = X*V;%%%%%%%%%%%%%%%%%%PCA正变换，获得各个主成分

%%
y1 = Y(:,1);
y2 = reshape(y1,[rows,cols]);
figure(1)
imshow(y2);
imwrite(y2,'y1.tif');

%% 成分替换之前进行的处理
% P1=imread('12BANDVVronghe.tif');
% P1=mat2gray(P1);
%% 进行替换处理的操作
% % P1=imread('butongjishufenxi/SR/ronghe2.tif');
% % %P1=mat2gray(P1);
% % P1=im2double(P1);
% % figure(2)
% % imshow(P1);
% % P = reshape(P1,[],1);
%%
P = reshape(panchromaticImage,[],1);
% P1 = reshape(P,[rows,cols]);
% figure(2)
% imshow(P1);
% imwrite(P1,'P11.tif');

%P = reshape(P,[],1);
P = (P-min(P))/(max(P)-min(P));
P = P*(max(y1)-min(y1))+min(y1);
proportion = max(y1);
P = im2uint8(P/proportion);
y1 = im2uint8(y1/proportion);
P = im2double(histeq(P,imhist(y1)))*proportion;
% 
P2 = reshape(P,[rows,cols]);
figure(2)
imshow(P2);
imwrite(P2,'P1.tif');

%% 进行成分替换
Y_replaced = [P,Y(:,2:D)];

%% PCA反变换
X_result = Y_replaced*V';
for i = 1 : D
    fusionImage(:,:,i) = reshape(X_result(:,i),rows,cols);
end
end
