function [ K ] = zetaK( i, j, dj, pom )
m = abs(i*pom - j)/pom;
K = 4^dj*gamma(1/2+dj)/(sqrt(3.15)*gamma(-dj))*(gamma(abs(m)-dj))/(gamma(abs(m) + 1 + dj));
if isnan(K)
    K = 0;
end
end

