lena = imread('images/Lena1.bmp');
lenaCloseFilter = morphology_close_filter(lena);
imwrite(lenaCloseFilter, 'results/Lena_Close_Filter.jpg');