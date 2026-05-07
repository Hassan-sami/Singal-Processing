
    % Load and prepare the image
    image = imread('LenaNoise.jpg');
    image = im2double(image); % Convert to grayscale
%     noisyImage = image + 0.05 * randn(size(image)); % Add Gaussian noise

    % Set parameters
    sigma = 0.05;
    h = .4 * sigma;
    patchShape = 'square'; % or 'circle'
    patchSize = 5;         % Must be odd
    searchSize = 11;       % Must be odd

    % Denoise using NLM
    denoisedImage = nlmeans(image, sigma, h, patchShape, patchSize, searchSize);

    % Display results
    figure;
    subplot(1,3,1); imshow(image); title('Original');
%     subplot(1,3,2); imshow(noisyImage); title('Noisy');
    imwrite(denoisedImage,'result.png');
    subplot(1,3,3); imshow(denoisedImage); title('Denoised');
