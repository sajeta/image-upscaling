function [ sum ] = xiK( i, dj, pom, dim, js, je)
sum = 0;
for k = js:je
    sum = sum + zetaK( i, k, dj, pom );
end
% sum
% pause;
end

