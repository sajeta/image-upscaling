function scale(filename, scale_factor, alpha)
    s_y = scale_factor(1);
    s_x = scale_factor(2);
    tmp = split(filename, ".");
    out_filename = join([tmp{1}, "_", s_y, "_", s_x, ".png"], "");
    
    im = imread(filename);
    imm = zeros(size(im,1 )*s_y, size(im, 2)*s_x, 3);
    imm(:, :, 1) = gl2D(im(:, :, 1), alpha, scale_factor);
    imm(:, :, 2) = gl2D(im(:, :, 2), alpha, scale_factor);
    imm(:, :, 3) = gl2D(im(:, :, 3), alpha, scale_factor);
    % figure(5)
    imwrite(imm, out_filename);

end