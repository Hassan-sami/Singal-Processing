%% Load Image
original_img = im2double(imread('image.png')); % Replace with image
[H, W, C] = size(original_img);

%% Create Gaussian Blur Kernel
sigma = 1.5; % Standard deviation (1.0-2.0)
kernel_size = 3; % Odd number (3,5,7)
half_size = floor(kernel_size/2);

[X,Y] = meshgrid(-half_size:half_size, -half_size:half_size);
G = exp(-(X.^2 + Y.^2)/(2*sigma^2));
G = G ./ sum(G(:)); % Normalize kernel

%% Apply Gaussian Blur
blurred_img = zeros(size(original_img));
for c = 1:C
    blurred_img(:,:,c) = conv2(original_img(:,:,c), G, 'same');
end

%% Create and Apply Unsharp Mask
amount = 1.2; % Sharpening strength (0.5-1.5)
mask = original_img - blurred_img;
sharpened_img = original_img + amount * mask;
sharpened_img = max(0, min(1, sharpened_img)); % Clip to valid range

%% Create Difference Image
diff_img = abs(original_img - sharpened_img) * 5; % Amplify differences

%% Create Comparison Image
separator = ones(H, 3, 3); % Vertical white separator
comparison = [original_img, separator, sharpened_img];

%% Display All Results in Separate Figures
% Figure 1: Sharpened Image Only
figure(1);
imshow(sharpened_img);
title('Sharpened Image', 'FontSize', 8, 'FontWeight', 'bold');
set(gcf, 'Position', [100 100 W*0.8 H*0.8]);

% Figure 2: Original vs Sharpened Comparison
figure(2);
imshow(comparison);
title('Original (left) vs Sharpened (right)', 'FontSize', 8, 'FontWeight', 'bold');
set(gcf, 'Position', [200 100 (W*2+3)*0.8 H*0.8]);

% Figure 3: Blurred Image
figure(3);
imshow(blurred_img);
title('Blurred Image (Gaussian)', 'FontSize', 8, 'FontWeight', 'bold');
set(gcf, 'Position', [300 100 W*0.8 H*0.8]);

% Figure 4: Difference Image
figure(4);
imshow(diff_img);
title('Difference Map (5x amplified)', 'FontSize', 8, 'FontWeight', 'bold');
colorbar;
set(gcf, 'Position', [400 100 W*0.8 H*0.8]);

%% Save All Results
imwrite(sharpened_img, 'sharpened.png');
imwrite(comparison, 'comparison.png');
%imwrite(blurred_img, 'blurred.png');
%imwrite(diff_img, 'difference.png');

%disp('All results saved as:');
disp('- sharpened.png');
disp('- comparison.png');
%disp('- blurred.png');
%disp('- difference.png');