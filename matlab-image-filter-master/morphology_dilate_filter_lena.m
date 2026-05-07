lena = imread('images/Lena1.bmp');
lenaDilateFilter = morphology_dilate_filter(lena);
imwrite(lenaDilateFilter, 'results/Lena_Dilate_Filter.jpg');