clear all;
close all;
clc;
tic;
%% NSST tool box
load('dict.mat');  
%% 
%% 
%% 
addpath(genpath('shearlet')); 

A=imread('sourceimages/y1.tif');
B=imread('sourceimages/P1.tif');

% size=[800 800];
% 
% A=imresize(A,size);
% B=imresize(B ,size);

%    figure;imshow(A);
% figure;imshow(B);
 
img1 = double(A)/255;
img2 = double(B)/255;

% imwrite(img1,'results/A7.tif');
% imwrite(img2,'results/B7.tif');

figure;imshow(img1);
figure;imshow(img2);


% img1=gpuArray(img1);
% img2=gpuArray(img2);


% image fusion with NSST-PAPCNN 
imgf=fuse_NSST(img1,img2); 

F=uint8(imgf*255);
figure,imshow(F);
imwrite(F,'results/1.tif');

toc;
