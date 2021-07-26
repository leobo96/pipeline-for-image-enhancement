function output_im = compose(ch1, ch2, ch3)
   % This function takes 3 channels as input and gives the image obtained
   % combining the channels
   output_im(:,:,1) = ch1;
   output_im(:,:,2) = ch2;
   output_im(:,:,3) = ch3;
end


