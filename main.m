figure(1)
clf(1)
get(0,'Factory');
set(0,'defaultfigurecolor',[1 1 1]);
grid on
h = 0.1; %finoæa
% domena
A = 1:h:80;
% funkcija
B = sigmf(A, [2 4]);
% B = 1./(1+(A-40).^2/100);
B = A.*cos(A);

% B = 
% B = 2*A + 3;
M = zeros(size(A));
st = 265; % poèetak maske
en = 290; % kraj maske
M(st:en) = 1;

alpha = 0.95; %razlomljena
D = 0.9;
kk = -1;
[p1, p4, rjr] = anfunk(A, B, M, h, st, en, alpha, '[1 0.3 0.1]', D, kk, 0);
D = 0;
kk = 1;
alpha = 0.99999999;
[~, p2, rjl] = anfunk(A, B, M, h, st, en, alpha, '[0 0.2 0.9]', D, kk, -2);
D = -5000000;
kk = 0;
alpha = 0.9999999;
[~, p3, rjb] = anfunk(A, B, M, h, st, en, alpha, '[0 0.9 0.2]', D, kk, -4);
% legend({'Input function','Partial dif eq', 'Lower mask limit', 'Upper mask limit', ''},'Location','southwest')
p5 = plot([st-1, en+1], [B(st-1), B(en+1)], 'kd', 'linewidth',4);
legend([p1 p2 p3 p4],{'Test image',...
    'Integer order Laplace equation',... 
    'Integer order Cahn-Hilliard type equation',... 
    'Fractional order Cahn-Hilliard type equation'},'Location','northwest')
% title('D\Delta^2 u + K\Delta^{\alpha} u = 0');
ax = gca;
ax.FontSize = 15;
xlabel('Image domain');
ylabel('Image intensity');
xlim([240 340]);
ylim([-35 45]);
saveas(gcf, 'graf2.png');





clearvars();