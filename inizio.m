%Write a code (a script or a function) with a complete pipeline for image enhancement: a 
%sequence of algorithms to remove noise, increase the contrast, remove color cast, and apply
%sharpening.

%Try to parametrize the pipeline (the algorithms), in order to define at the beginning the 
%proper parameters with respect to the image that you are processing.

%Select images to test the pipeline and try different parameters

url = "baita.jpg";

im = imread(url);
im_copy = im;

% Note: comment with "%" near the command to start the procedure if you
% want to skip it

%1. Removing of noise

    % EXPLAINATION
        % It is possible to use low pass filter to reduce noise
        % There are different type of low pass filters.
        % Linear Filters: 
        % a. Average filter 
        % b. Disk Filter 
        % c. Gaussian filter
        % Non-linear filters 
        % a. Median
        % b. Min
        % c. Max
        % Non-linear filters can be applied iteratively to increase the effect

    % PARAMETERS
        % We use denoise_procedure to remove noise
        % It accept the following parameters:
        % 1. The image to be processed
        % 2. The type of filter
        % 3. The dimension of the mask / The sigma for gaussian filter
        % 4. The number of iterations to perform with non-linear filters

    % SETTING OF PARAMETERS
        type = "median"; %accept "average", "disk", "gaussian", "median", "min", "max"
        mask_dimension = 3; %dimension of the mask. Ignore if type is gaussian
        sigma = 1.5; %ignore if type is not  gaussian
        iterations = 2; %ignore if type is not median, min or max

        if type == "gaussian"
            third = sigma;
        else
            third = mask_dimension;
        end

    % STARTING DENOISE PROCEDURE
        im = denoise_procedure(im, type, third, iterations);

%2. Increasing of contrast

    % EXPLAINATION 
        % There are 2 possibilities to enhance contrast
        % a. Applying Histogram Equalization
        % b. Applying a gamma correction
        % Note: It is possible to to apply different gamma correction to different
        % regions of the image. E.g. A low gamma to increase brightness in a dark
        % region and an higher one to darken a bright region
    
    % PARAMETERS
        % We use enhance_constrast to improve contrast
        % It accept the following parameters:
        % 1. The image to be processed
        % 2. The will to apply different gamma correction
        % 3. The will to apply equalization of the histogram
        % 4. First gamma
        % 5. Second gamma

    % SETTING OF PARAMETERS
        different_gamma = false; %set to false if you want to apply one gamma to entire image
        equalization = "equalize"; %accept "equalize" & "none"
        gamma1 = 1.2; % >1 to darken; 0 < x < 1 to brighten
        gamma2 = 0.9; %ignore if different_gamma is set to false
        
    % STARTING CONTRAST ENHANCEMENT PROCEDURE
        im = enhance_contrast(im, different_gamma, equalization, gamma1, gamma2);
        im = im2uint8(im);

%3. Removing color cast

    % EXPLAINATION
        % We remove color cast when we find a bias towards one color
        % There are 2 main approach:
        % 1. Grey World Hypotesis --> it takes average color of the image as reference 
        % 2. White Point --> it takes the brightest point of the image as reference
        % Note: This procedure is useless with gray scale images

    % PARAMETERS
        % We use white_balance to remove color cast
        % It accept the following parameters:
        % 1. The image to be processed
        % 2. Method
        
    % SETTING OF PARAMETERS
        method = "grayWorld"; % accept "whitePoint" & "grayWorld"
        
    % STARTING WHITE BALANCE PROCEDURE
        im = white_balance(im, method);
        
%4. Applying edge sharpening

    % EXPLAINATION
        % We apply edge sharpening if we want to emphasize edges or to
        % obtain cartoonizing effect. This is done performing an high pass
        % filter
        % There are 2 strategies:
        % 1. blackEdges --> empasize edges using black
        % 2. whiteEdges --> tends to saturize edges 
        % The possible high pass filter that can be used to detect edges:
        % a. Sobel
        % b. Prewitt
        % c. Roberts
        % d. Canny
        % e. Laplacian 
        % Note: Laplacian tends to increase noise. It is a good practise to
        % apply a low pass filter to reduce noise and only then applying
        % laplacian filter. "log" filter stands for laplacian of a gaussian
        % and do low pass filter and high pass filter together. So it can 
        % be used instead of laplacian. It only need sigma as extra
        % parameter
        
    % PARAMETERS
        % We use edge_sharpening to remove sharp edges
        % It accept the following parameters:
        % 1. The image to be processed
        % 2. Strategy
        % 3. Type of high pass filter
        % 4. Weight of edges in whiteEdge strategy (used to avoid saturation)
        % 5. Sigma in case "log" method is selected
        
    % SETTING OF PARAMETERS
        strategy = "whiteEdges"; %accept "blackEdges" & "whiteEdges"
        type = "sobel"; %accept "sobel", "prewitt", "canny", "roberts", "laplacian", "log"
        edge_weight = 0.2; %set a value 0 < x < 1. Ignore is strategy is "blackEdges"
        sigma = 1.2; %ignore if type is not "log"
        
    % STARTING WHITE BALANCE PROCEDURE
        im = edge_sharpening(im, strategy, type, edge_weight, sigma);
        
figure, subplot(1,2,1), imshow(im_copy), title("before"), subplot(1,2,2), imshow(im), title("after");