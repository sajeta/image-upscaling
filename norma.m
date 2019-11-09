% z = zeros(49, 1);
% 
% for i = 1:49
%     [z(i), ~] = gl(0.02*i);
% end
% 
% figure(1)
% clf(1)
% plot(z);
% figure(2)
% clf(2)
% [~, rgb] = gl(0.9);
% imshow(rgb);

% gl(0.95)


im = imread('nova-fleka-1-comb.png');
imm = zeros(size(im,1 )*3, size(im, 2)*3, 3);
imm(:, :, 1) = gl2D(im(:, :, 1), 0.75);
imm(:, :, 2) = gl2D(im(:, :, 2), 0.75);
imm(:, :, 3) = gl2D(im(:, :, 3), 0.75);
% figure(5)
imwrite(imm, 'nova-fleka-1-combx3.png');

% clearvars;
% 
% im = imread('celavo-govno_2.png');
% imm = zeros(size(im,1 )*4, size(im, 2)*4, 3);
% imm(:, :, 1) = gl2D(im(:, :, 1), 0.75);
% imm(:, :, 2) = gl2D(im(:, :, 2), 0.75);
% imm(:, :, 3) = gl2D(im(:, :, 3), 0.75);
% % figure(5)
% imwrite(imm, 'celavo-govno_2x4.png');
