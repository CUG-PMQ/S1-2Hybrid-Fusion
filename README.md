This is the documentation for the entire method, including descriptions of PCA, NSST_CSR and GAN.
####PCA：
Our image is provided in the folder, directly execute PCAdaima2_5.m, you can get the matched SAR image and PC1.

####NSST_CSR:
Our images are provided in the folder, and Script_gray.m can be directly executed to obtain the low-frequency components of SAR image and PC1 respectively, and the high-frequency components directly executes the CSR model for fusion.

####GAN:
Put test image pairs in the “Test_near" and "Test_far" folders, and run "test.py" to test the trained model. You can also directly use the trained model we provide.


PCA and NSST CSR use the Matlab2021 compiler.
GAN is used in the following environment: python=3.7, tensorflow=1.13.1, numpy=1.21.5, h5py=3.6.0, scipy=1.2.1, opencv-python=4.5.5.64.
