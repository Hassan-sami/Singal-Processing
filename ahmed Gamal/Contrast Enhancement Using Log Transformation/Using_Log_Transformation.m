% Description: Contrast Enhancement Using Log Transformation

input=imread('test.jpg');
input=rgb2gray(input);
input=im2double(input);

c=5;
s=c.*log(1+input);
result=s;

subplot(2,2,1)
imshow(input)
title('Grayscale Image','fontsize', [12])
subplot(2,2,2)
imhist(input)
title('Histogram of grayscale image ','fontsize', [12])
subplot(2,2,3)
imshow(result)
title('Log Transformation','fontsize', [12])
subplot(2,2,4)
imhist(result)
title('Histogram of Log Transformation] ','fontsize', [12])


