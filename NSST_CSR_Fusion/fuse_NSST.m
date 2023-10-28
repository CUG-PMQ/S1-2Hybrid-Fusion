function F = fuse_NSST(A,B)
%% NSST decomposition
pfilt = 'maxflat';
% shear_parameters.dcomp =[3,3,4,4];
% shear_parameters.dsize =[8,8,16,16];
shear_parameters.dcomp =[3,3,4,4];
shear_parameters.dsize =[8,8,16,16];
[y1,shear_f1]=nsst_dec2(A,shear_parameters,pfilt);
[y2,shear_f2]=nsst_dec2(B,shear_parameters,pfilt);
%% fusion
y=y1;

imwrite(y1{1},'results/xin-y1.tif');
imwrite(y2{1},'results/xin-p1.tif');

%%这一步用GAN融合的影像作为低频进行读入
  A1 = imread('sourceimages/ronghe1.tif');
% size=[512 512];
% A1=imresize(A1,size)
  y{1}=double(A1)/255;

  
  
%key parameters
load('dict.mat');
lambda=0.01; 
flag=2; % 1 for multi-focus image fusion and otherwise for multi-modal image fusion

%CSR-based fusion
% tic;
% F=CSR_Fusion(A,B,D,lambda,flag);
% toc;
Para.iterTimes=200;
Para.link_arrange=7;
Para.alpha_L=0.02;
Para.alpha_Theta=3;
Para.beta=3;
Para.vL=1;
Para.vTheta=20;
t=3;



for m=2:length(shear_parameters.dcomp)+1
    temp=size((y1{m}));temp=temp(3);
   % i=0;
    for n=1:temp
        Ahigh=y1{m}(:,:,n);
        Bhigh=y2{m}(:,:,n);
      %  y{m}(:,:,n)=highpass_fuse(Ahigh,Bhigh);
       tic;
%F=CSR_Fusion(A,B,D,lambda,flag);
       y{m}(:,:,n)=CSR_Fusion(Ahigh,Bhigh,D,lambda,flag);
       toc;
%        CSR_Fusion(img1, img2, D, lambda, flag)
%        y{m}(:,:,n)=(Ahigh+Bhigh)/2;

    end
   % h=h+1;
end


%%  NSST reconstruction
F=nsst_rec2(y,shear_f1,pfilt);
end