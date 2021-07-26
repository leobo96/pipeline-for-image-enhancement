function output_im = white_balance(input_im, method)
% This function takes an image as input and gives a white balanced image
% based on method
% Note: This function should not be used with gray scale images
% method accept 2 values: "grayWorld" and "whitePoint

    isColor = size(input_im, 3) == 3;
    
    if isColor
        [R, G, B] = extract_ch(input_im);

        if method == "grayWorld"
            avgR = mean(mean(R));
            avgG = mean(mean(G));
            avgB = mean(mean(B));
            GrayRef = (avgR + avgG + avgB)/3;
            Kr = GrayRef/avgR;
            Kg = GrayRef/avgG;
            Kb = GrayRef/avgB;

        elseif method == "whitePoint"

            Rmax = max(max(R));
            Gmax = max(max(G));
            Bmax = max(max(B));
            Kr = 255/Rmax;
            Kg = 255/Gmax;
            Kb = 255/Bmax;

        end

        R = R * Kr;
        G = G * Kg;
        B = B * Kb;

        output_im = compose(R,G,B);
    else
        output_im = input_im; %do nothing with gray scale images
    end
    
end
