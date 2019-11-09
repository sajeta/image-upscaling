function imag = PM2(im, dt, tuk)
im = double(im);

nagib = 10;
g =@(s, x) 1./(1+s./nagib);

xp1 = zeros(size(im, 1)+2, size(im, 2)+2);
xm1 = xp1;
yp1 = xp1;
ym1 = xp1;
org = xp1;


for t = 0:dt:tuk
    xp1(1:end-2, 2:end-1) = im;
    xm1(3:end, 2:end-1) = im;
    yp1(2:end-1, 1:end-2) = im;
    ym1(2:end-1, 3:end) = im;
    org(2:end-1, 2:end-1) = im;
    PM = g( (xp1-org).^2 + (yp1-org).^2, nagib).*(xp1-org) - ...
        g( (org-xm1).^2 + (yp1-org).^2, nagib).*(org-xm1) + ...
        g( (xp1-org).^2 + (yp1-org).^2, nagib).*(yp1-org) - ...
        g( (xp1-org).^2 + (org-ym1).^2, nagib).*(org-ym1);
         
    im = im + dt.*PM(2:end-1, 2:end-1);
end

im = im/max(max(im));
imag = im;
end