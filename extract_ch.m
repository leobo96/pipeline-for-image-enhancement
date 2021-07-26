function [ch1, ch2, ch3] = extract_ch(input_im)
% This function takes an 3 channel image as input and gives the 3 channels
% singularly. Can be used with RGB or YCbCR
    ch1 = input_im(:,:,1);
    ch2 = input_im(:,:,2);
    ch3 = input_im(:,:,3);
end

