function output_im = enhance_contrast(input_im, spatial_varying_toggle, equalization, gamma1, gamma2 )
% This function takes an image as input and gives an image with enhanced contrast
% spatial_varying_toogle accept true or false value. We set it to true if 
    % we want to apply different gamma correction to different regions 
% equalization accept "equalize" as value to perform an histogram equalization
% gamma1 is the first gamma value if we perform different gamma correction
    % in different region (spatial_varying_toogle on); It is the only gamma
    % value if we perform gamma correction globally
% gamma2 is the second gamma value if we perform different gamma correction
    % in different region (spatial_varying_toogle on); It should be left
    % clear if we perform gamma correction globally
    
    if spatial_varying_toggle == true
        
        isColor = size(input_im,3) == 3;
        
        if isColor
            [y, cb,cr] = extract_ch(rgb2ycbcr(input_im));
        else
            y = input_im;
        end
        
        soglia = graythresh(y);
        parte_da_scurire = imbinarize(y, soglia);
        parte_da_schiarire = imcomplement(parte_da_scurire);
        scurita = imadjust(y,[],[],gamma1);
        schiarita = imadjust(y,[],[],gamma2);
        y = im2double(scurita).*parte_da_scurire + im2double(schiarita).*parte_da_schiarire;
        
        if isColor
            output_im = ycbcr2rgb(compose(y,im2double(cb),im2double(cr)));
        else
            output_im = y;
        end
        
    else %gamma applied globally
        output_im = imadjust(input_im, stretchlim(input_im),[],gamma1);
    end
    
    if equalization == "equalize"
        output_im = histeq(output_im);
    end
    
end