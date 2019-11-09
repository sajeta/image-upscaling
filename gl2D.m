function [ v1 ] = gl2D(im, dj, scale_factor)
dj = 0.95;
s_y = scale_factor(1);
s_x = scale_factor(2);
%izbrisatii
% tic
% im = imread('ImageUpscaling\LM.png');
% imm = imread('ImageUpscaling\original.png');
% immm = imread('ImageUpscaling\upscaled.png');
% im = imread('shell.png');

[n, p, ~] = size(im);
fprintf("Dimenzije ulaznih parametara: %d\n", n);

m = floor(s_y*n);
pom = n/m;
A = zeros(m, n);
A(1, 1) = 1;
A(end, end) = 1;
for i = 2:m-1
    js = 1;
    je = n;
    for j = js:je
        if j>n
            je = j-1;
            continue;
        end
        A(i, j) = zetaK( i, j, dj, pom );
    end
    tmp = xiK(i, dj, pom, n, js, je);
    A(i, :) = A(i, :)./tmp;
end

I = sparse(eye(p));
I = sparse(I);
H_1 = kron(I, A);

slika1 = im;

u1 = double(reshape(slika1, [n*p 1]));
u1 = double(u1./255);
u1 = double(u1);
v1 = H_1*u1;
v1 = reshape(v1, [m p]);
% imshow(v1);
% pause;

v1 = v1.';
[n, p, ~] = size(v1);
fprintf("Dimenzije ulaznih parametara: %d\n", n);

m = floor(s_x*n);
pom = n/m;
A = zeros(m, n);
A(1, 1) = 1;
A(end, end) = 1;
for i = 2:m-1
    js = 1;
    je = n;
    for j = js:je
        if j>n
            je = j-1;
            continue;
        end
        A(i, j) = zetaK( i, j, dj, pom );
    end
    tmp = xiK(i, dj, pom, n, js, je);
    A(i, :) = A(i, :)./tmp;
end

I = sparse(eye(p));
I = sparse(I);
H_1 = kron(I, A);

slika1 = v1;
% slika = slika.';

u1 = double(reshape(slika1, [n*p 1]));
% u1 = double(u1./255);
u1 = double(u1);
v1 = H_1*u1;
v1 = reshape(v1, [m p]);
v1 = v1.';
imshow(v1);
size(v1)
% toc
% pause;
% imm = double(imm);
% imm = imm./255;
% rgb = zeros(size(v1, 1), 2*size(v1, 2));
% rgb(:, 1:size(v1, 2)) = v1;
% 
% rgb(:, size(v1, 2)+1:end) = imm(:, :, 2);
% 
% 
% 
% n = norm(v1-imm(:, :, 2))/norm(imm(:, :, 2));
% n = n*100
% imshow(rgb);
% rgb = 1;

end