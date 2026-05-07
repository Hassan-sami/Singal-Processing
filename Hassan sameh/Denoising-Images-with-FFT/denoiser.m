% Read the original image
img1 = imread('Cameraman.tif');
ft = fft2(img1);
f_s = fftshift(ft);

% Display the Fourier Transform (magnitude) of the image
figure, imshow(log(1 + abs(f_s)), []);
title('Original Image Fourier Transform');

% Create a test noise pattern
img_test = 35 * ones(256, 256);
for i = 1:16:size(img_test, 2)
    img_test(:, i:min(i+7,256)) = -35;
end

% Display the noise pattern
figure, imshow(img_test, []);
title('Test Noise Pattern');

% Fourier Transform of the test noiseD
test_ft = fft2(img_test);
figure, imshow(log(1 + abs(fftshift(test_ft))), []);
title('Noise Fourier Transform');

% Add noise to original image
img_n = double(img1) + img_test;
figure, imshow(img_n, []);
title('Noisy Image');

% Fourier Transform of noisy image
ft_n = fft2(img_n);
fs_n = fftshift(ft_n);
figure, imshow(log(1 + abs(fs_n)), []);
title('Noisy Image Fourier Transform');

% Calculate threshold
mag_fs = abs(fs_n);
f_max = max(mag_fs(:)); % old MATLAB compatible

disp(['Maximum magnitude in Fourier spectrum: ', num2str(f_max)]);

% Binary mask based on threshold
fsb = im2bw(mag_fs / (f_max / 30), 1); % Create binary mask

% Define center
rc = 128;
cc = 128;

% Filtering high-magnitude noise
for i = 1:256
    for j = 1:256
        % Skip center region (low frequencies)
        dist = sqrt((rc - i)^2 + (cc - j)^2);
        if dist < 15
            fsb(i, j) = 0;
        end

        % If above threshold, replace with local average
        if fsb(i, j) == 1
            i_min = max(i-2,1);
            i_max = min(i+2,256);
            j_min = max(j-2,1);
            j_max = min(j+2,256);
            region = fs_n(i_min:i_max, j_min:j_max);
            meean = sum(region(:)) / numel(region); % old MATLAB compatible mean
            fs_n(i, j) = meean;
        end
    end
end

% Display binary mask and modified spectrum
figure, imshow(log(1 + abs(fsb)), []);
title('Binary Mask');

figure, imshow(log(1 + abs(fs_n)), []);
title('Modified Fourier Spectrum');

% Inverse Fourier Transform to recover image
final_img = ifft2(ifftshift(fs_n));
final_img = real(final_img); % discard tiny imaginary parts
figure, imshow(uint8(final_img));
title('Denoised Image');