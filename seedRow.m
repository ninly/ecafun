function out = seedRow(N)
% a row vector of zeros with a 1 in the middle
    out = zeros(1,N);
    out(ceil(N/2)) = 1;
end