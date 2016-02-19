function COHMMmodel = ConstructCOHMM( A, PI, K, mu, C )
%makes a struct of continuous observation HMM model

[G, D, S] = size(mu);

% D - dimension of measurement vector
% S - number of states
% G - number of GMM per state

% A - state transition matrix, S x S
% PI - starting state, S x 1
% K - weighing coefficient for GMMs, G x S
% mu - means for GMM, G x D x S
% C - covariance for GMM, D x D x G x S

COHMMmodel = struct('A', A, 'PI', PI, 'K', K, 'mu', mu, 'C', C, 'S', S, 'G', G, 'D', D);

end

