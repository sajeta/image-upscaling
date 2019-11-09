function [p1, p2, rj] = anfunk(X, Y, mask, h, hst, hen, rder, col, Dd, kk, ypos)
D = Dd; 
epsxx = 1;
kapa = kk; 

n = max(size(X));
dj = rder;
K = @(m) kapa*4^dj*gamma(1/2+dj)/(sqrt(3.15)*gamma(-dj))*(gamma(abs(m)-dj))/(gamma(abs(m) + 1 + dj));

I1 = sparse((-6*D/(h^4)*epsxx - 2*kapa*1/(h^(2*dj))*K(1) - 2*kapa*1/(h^(2*dj))*K(2) - 2*kapa*1/(h^(2*dj))*K(3) - 2*kapa*1/(h^(2*dj))*K(4) - 2*kapa*1/(h^(2*dj))*K(5)- 2*kapa*1/(h^(2*dj))*K(6)- 2*kapa*1/(h^(2*dj))*K(7) )*eye(n)); 
I2 = sparse(diag((4*D/(h^4)*epsxx + kapa*1/(h^(2*dj))*K(1))*ones(n-1,1),1));
I3 = sparse(diag((4*D/(h^4)*epsxx + kapa*1/(h^(2*dj))*K(1))*ones(n-1,1),-1));
I4 = sparse(diag((-D/(h^4)*epsxx + kapa*1/(h^(2*dj))*K(2))*epsxx*ones(n-2,1),-2));
I5 = sparse(diag((-D/(h^4)*epsxx + kapa*1/(h^(2*dj))*K(2))*epsxx*ones(n-2,1),2));
I6 = sparse(diag(kapa*1/(h^(2*dj))*K(3)*ones(n-3, 1), -3));
I7 = sparse(diag(kapa*1/(h^(2*dj))*K(3)*ones(n-3, 1), 3));
I8 = sparse(diag(kapa*1/(h^(2*dj))*K(4)*ones(n-4, 1), 4));
I9 = sparse(diag(kapa*1/(h^(2*dj))*K(4)*ones(n-4, 1), -4));
I10 = sparse(diag(kapa*1/(h^(2*dj))*K(5)*ones(n-5, 1), 5));
I11 = sparse(diag(kapa*1/(h^(2*dj))*K(5)*ones(n-5, 1), -5));
I12 = sparse(diag(kapa*1/(h^(2*dj))*K(6)*ones(n-6, 1), 6));
I13 = sparse(diag(kapa*1/(h^(2*dj))*K(6)*ones(n-6, 1), -6));
I14 = sparse(diag(kapa*1/(h^(2*dj))*K(7)*ones(n-7, 1), 7));
I15 = sparse(diag(kapa*1/(h^(2*dj))*K(7)*ones(n-7, 1), -7));
A = sparse(I1 + I2 + I3 + I4 + I5 + I6 + I7 + I8 + I9 + I10 + I11+ I12+ I13+ I14+ I15);

T = A;

u = find(mask);
u2 = find(~mask);
spey = speye(n);
TTEMP = speye(n);
% whos -regexp TTEMP
xu = zeros(n, 1);
xu2 = zeros(n, 1);
xu(u) = 1;
xu2(u2) = 1;

T = xu.*T + xu2.*TTEMP;
% figure(1), subplot(121), spy(T);
Xn2 = Y;
Xn2(u) = 0;
Ttran = T.';

% T = Ttran*T;
Xn2 = Xn2.';
% Xn2 = Ttran*Xn2;

rj = T\Xn2;
Yl2 = Y.';

L2 = norm(rj(hst:hen) - Yl2(hst:hen))/norm(Yl2(hst:hen));
% su = sum(kv);
% L2 = sqrt(su);
if rder > 0.9
    rder = 1;
end
fprintf('L2 = %f\nalpha = %.3f, D = %.3f, K = %f.3\n\n', L2, rder, Dd, kk);
% str = sprintf('L2 = %.2f\nalpha = %.2f, D = %.1f, K = %.1f\n\n', L2, rder, Dd, kk);

% text(550, ypos, str);
% subplot(122);
% figure(2)
% clf(2)
hold on

p1 = plot(Y,  '.', 'color', '[0.5 0.4 0.4]', 'linewidth', 1.3);
% plot(hen:max(size(Y)), Y(hen:end), 'color', 'c');
p2 = plot(hst-1:hen+1, rj(hst-1:hen+1), 'color', col, 'linewidth', 3);
% line([hst hst], [min(rj) max(rj)], 'LineStyle',':', 'color', 'r'); 
% line([hen hen], [min(rj) max(rj)],'LineStyle',':', 'color', 'r');
end