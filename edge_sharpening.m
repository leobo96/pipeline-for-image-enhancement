function output_im = edge_sharpening (input_im, strategy, type,  edge_weight, sigma)
% This function takes an image as input and gives an output image with
% unsharped edges
% strategy accept 2 values: "blackEdges" and "whiteEdges"
% type accept the following values: "sobel", "prewitt", "roberts", "canny",
% "laplacian", "log"
% sigma controls the width of gaussian filter in "log" method, so it is only
% needed when log method is used.
% edge_weight controls the weight to assign to edges in case second
% strategy is applied
    
    isColor = size(input_im,3) == 3;
    
    edges = extract_edges(input_im, type, sigma);
    
    if strategy == "blackEdges"
        edges = im2uint8(edges);
        if isColor
            [R, G, B] = extract_ch(input_im);
            output_im = compose(R-edges,G-edges,B-edges);
        else
            output_im = input_im - edges;
        end
        
    elseif strategy == "whiteEdges"
        edges = not(edges);
        edges = im2uint8(edges);
        if isColor
           edges = compose(edges,edges,edges);
        end
        output_im = (1-edge_weight)*input_im + edge_weight * edges;
    end
end