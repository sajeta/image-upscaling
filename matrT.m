function T = matrT(n, m)
    idx1 = (1: n*m);
    idx2 = zeros(1, n*m);
    
    for i = 1:n*m
        if mod((i-1)*m, n*m) == 0
            shift = (i-1)*m / (n*m);
        end
        idx2(i) = 1 + mod((i-1)*m, n*m) + shift;
    end
    
    T = sparse(idx1, idx2, 1, m*n, m*n);
    

% function T = matrT(n, m)
%     T = zeros(n*m, n*m);
%     
%     for j = 1:n
%         t = zeros(m, m*n);
%         block = zeros(m,m);
%         block(1, j) = 1;
% 
%         for i = 1:n
%             block2 = switch_row(block, 1, i);
%             t(:, 1+(i-1)*m: i*m) = block2;
%         end
%         
%         T(1+(j-1)*m: j*m, :) = t;
%     end
% 
% 
%         
% function M = switch_row(A, i, j)
%     M = A;
%     M([i j], :) = M([j i], :);
%     
%     
% function M = switch_col(A, i, j)
%     M = A;
%     M(:, [i j]) = M(:, [j i]);