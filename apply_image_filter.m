function filtered_image = apply_image_filter()
    % APPLY_IMAGE_FILTER - Loads an image, applies a filter, and displays results
    
    % Get image file from user
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif;*.jpeg', 'Image Files'}, 'Select an Image');
    if isequal(filename, 0)
        disp('User canceled image selection');
        return;
    end
    image_path = fullfile(pathname, filename);
    
    % Read the image
    original_image = imread(image_path);
    
    % Convert to grayscale if it's a color image
    if size(original_image, 3) == 3
        original_image = rgb2gray(original_image);
    end
    
    % Display available filters
    disp('Available filters:');
    disp('1. Gaussian Blur');
    disp('2. Sobel Edge Detection');
    disp('3. Laplacian Sharpening');
    disp('4. Median Filter');
    disp('5. Custom Filter');
    
    % Get filter choice from user
    choice = input('Enter filter choice (1-5): ');
    
    % Apply selected filter
    switch choice
        case 1 % Gaussian Blur
            hsize = input('Enter filter size (e.g., 5): ');
            sigma = input('Enter sigma value (e.g., 2): ');
            filter_kernel = fspecial('gaussian', hsize, sigma);
            filtered_image = imfilter(original_image, filter_kernel);
            
        case 2 % Sobel Edge Detection
            filtered_image = edge(original_image, 'sobel');
            
        case 3 % Laplacian Sharpening
            alpha = input('Enter sharpening amount (0-1, e.g., 0.2): ');
            filter_kernel = fspecial('laplacian', alpha);
            filtered_image = imfilter(original_image, filter_kernel);
            filtered_image = original_image - filtered_image; % Enhance edges
            
        case 4 % Median Filter
            window_size = input('Enter window size (e.g., 3): ');
            filtered_image = medfilt2(original_image, [window_size window_size]);
            
        case 5 % Custom Filter
            disp('Enter a 3x3 filter kernel (e.g., [0 1 0; 1 -4 1; 0 1 0] for Laplacian)');
            custom_filter = input('Enter 3x3 matrix: ');
            filtered_image = imfilter(original_image, custom_filter);
            
        otherwise
            error('Invalid choice');
    end
    
    % Display results
    figure;
    subplot(1,2,1); imshow(original_image); title('Original Image');
    subplot(1,2,2); imshow(filtered_image); title('Filtered Image');
    
    % Save the result if desired
    save_choice = input('Save filtered image? (y/n): ', 's');
    if lower(save_choice) == 'y'
        [save_name, save_path] = uiputfile({'*.jpg';'*.png'}, 'Save Filtered Image');
        if ~isequal(save_name, 0)
            imwrite(filtered_image, fullfile(save_path, save_name));
            disp('Image saved successfully');
        end
    end
end