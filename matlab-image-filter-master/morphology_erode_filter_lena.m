lena = imread('images/Lena1.bmp');
lenaErodeFilter = morphology_erode_filter(lena);
imwrite(lenaErodeFilter, 'results/Lena_Erode_Filter.jpg');