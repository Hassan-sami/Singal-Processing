lena = imread('images/Lena1.bmp');
lenaOpenFilter = morphology_open_filter(lena);
imwrite(lenaOpenFilter, 'results/Lena_Open_Filter.jpg');