I = imread('balloons_noisy.png');

red_channel = I(:, :, 1);
green_channel = I(:, :, 2);
blue_channel = I(:, :, 3);

red_channel = medfilt2(red_channel, [3 3]);
green_channel = medfilt2(green_channel, [3 3]);
blue_channel = medfilt2(blue_channel, [3 3]);

F = cat(3, red_channel, green_channel, blue_channel);

subplot(2, 1, 1);
imshow(I);
title('Noisy Image');

subplot(2, 1, 2);
imshow(F);
title('Image After Noise Removal');


