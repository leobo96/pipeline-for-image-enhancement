function output_im = denoise_procedure(input_im, type, third, iterations)

% This function receive an image as input and gives a low pass filtered image as output
% The "type" parameter specify the type of filter to apply - It accept
% "average", "disk", "gaussian", "median", "max", "min"
% "third" parameter is used for:
% - dimension of the mask (N) in average, disk and non-linear filters
% - sigma in gaussian filter
% "iterations" specify the number of times non-linear filters (median,min,max) has to be
% applied. It is optional for linear filters

    isGrayLevel = size(input_im,3) == 1;
    
    if type == "average" || type == "disk" || type == "gaussian"
        
        if type == "average" || type == "disk" 
            N = third;
            H = fspecial(type, N);
        elseif type == "gaussian"
            sigma = third;
            N = 2*fix(2.5*sigma)+1;
            H = fspecial(type, N, sigma);
        end
        
        output_im = imfilter(input_im,H);
        
        
    elseif type == "median" || type == "min" || type == "max"
        
        N = third;
        mask = ones(N);

        if type == "min"
            order_th = 1;
        elseif type == "max"
            order_th = N*N;
        elseif type == "median"
            order_th = round((N*N)/2) + 1;
        end
        
        if isGrayLevel %gray level image processing
            output_im = input_im;
            for i = 1:iterations 
                output_im = ordfilt2(output_im, order_th, mask);
            end
            
        else %colored images processing
            [Y, Cb, Cr] = extract_ch(rgb2ycbcr(input_im));
        
            for i = 1:iterations 
                Y = ordfilt2(Y, order_th, mask);
            end

            output_im = ycbcr2rgb(compose(Y,Cb,Cr));
        end
    end
end