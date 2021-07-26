function edges = extract_edges(input_im, type, sigma)
% This function takes an image as input and gives its edges based on type
% of filter applied
% type corresponds to type of high pass filter applied.
    % It accept "sobel" "prewitt" "canny" "roberts" "laplacian" "log"
    % (laplacian of a gaussian)
% sigma controls the width of the gaussian curve in log filter.
    % It should be left clear if "log" is not used
    
    isGrayLevel = size(input_im,3) == 1;
    
    if isGrayLevel
        gray = input_im;
    else
        gray = im2gray(input_im);
    end
    
    if type == "log"
        N = 2*fix(2.5*sigma)+1;
        H = fspecial("log", N, sigma);
        edges = imfilter(gray,H);
    else
       edges = edge(gray,type); 
    end
end