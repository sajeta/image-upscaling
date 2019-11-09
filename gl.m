function [ n, rgb ] = gl( dj )
tic
im = imread('ImageUpscaling\small.png');
imm = imread('ImageUpscaling\original.png');
immm = imread('ImageUpscaling\upscaled.png');

[n, p, k] = size(im);

% if p~=n
%     fprintf("m!=n");
%     quit
% end
fprintf("Dimenzije ulaznih parametara: %d\n", n);

% n = 10;

m = 2*n;
% dj = 0.75;
pom = n/m;
%inic A
A = zeros(m, n);
A(1, 1) = 1;
A(end, end) = 1;
% v = zeros(n, 1);
for i = 2:m-1
    js = 1;
    je = n;
    for j = js:je
        if j>n
            je = j-1;
            continue;
        end
%         fprintf("%d/%d . %d/%d\n", i, m, j, n);
        A(i, j) = zetaK( i, j, dj, pom );
    end
    tmp = xiK(i, dj, pom, n, js, je);
    A(i, :) = A(i, :)./tmp;
end

% sum(A, 2)
% A(:, 20)
% pause;

% isnan(A)
% pause;

I = sparse(eye(p));
I = sparse(I);
H_1 = kron(I, A);

slika1 = im(:, :, 1);
% slika = slika.';

u1 = double(reshape(slika1, [n*p 1]));
u1 = double(u1./255);
u1 = double(u1);
v1 = H_1*u1;
v1 = reshape(v1, [m p]);
% v1 = v1 - min(min(v));
% v1 = v1./max(max(v));
% imshow(v1);

slika2 = im(:, :, 2);
u2 = double(reshape(slika2, [n*p 1]));
u2 = double(u2./255);
u2 = double(u2);
v2 = H_1*u2;
v2 = reshape(v2, [m p]);

slika3 = im(:, :, 3);
u3 = double(reshape(slika3, [n*p 1]));
u3 = double(u3./255);
u3 = double(u3);
v3 = H_1*u3;
v3 = reshape(v3, [m p]);

rgb = zeros(size(v1, 1), 2*size(v1, 2), 3);

rgb(:, 1:size(v1, 2), 1) = v1;
rgb(:, 1:size(v1, 2), 2) = v2;
rgb(:, 1:size(v1, 2), 3) = v3;


imm = double(imm);
imm = imm./255;

immm = double(immm);
immm = immm./255;

% max(max(imm))
% max(max(v2))
rgb(:, size(v1, 2)+1:end, 1) = imm(:, :, 1);
rgb(:, size(v1, 2)+1:end, 2) = imm(:, :, 2);
rgb(:, size(v1, 2)+1:end, 3) = imm(:, :, 3);

n = norm(v2-imm(:, :, 2))/norm(imm(:, :, 2));
n = n*100;

% imshow(rgb);

toc
end