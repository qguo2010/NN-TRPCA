clear
addpath('model');
addpath('image');
addpath('metric');
X = double(imread('Elephant.jpg'));
X           =    X/255;
maxP        =    max(abs(X(:)));


%Adding random noise to the image
Xn          =    X;
rhos        =    0.3;
[n1,n2,n3]  =    size(Xn);
ind         =    find(rand(n1*n2*n3,1)<rhos);
Xn(ind)     =    rand(length(ind),1);


%Image restoration
tic
Xhat        =     NNTRPCA(Xn);
toc 


figure(1)
subplot(1,3,1)
imshow(X)
subplot(1,3,2)
imshow(Xn)
subplot(1,3,3)
imshow(Xhat)

%Quantitative results
psnr      =     PSNR(X,Xhat,maxP)
X         =     X.*255;
Xhat      =     Xhat.*255;
ssim      =     zeros(n3,1);
for i     =     1:n3
   ssim(i)=     ssim_index(X(:, :, i), Xhat(:, :, i));
end
ssim      =     mean(ssim)
fsim      =     FeatureSIM(X,Xhat)
ergas     =     ErrRelGlobAdimSyn(X,Xhat)

