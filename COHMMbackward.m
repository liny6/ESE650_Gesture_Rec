function [beta_logmag_hist, beta_vec_hist] = COHMMbackward( COHMM, O, Emission_hist )
% continuous observation HMM backward emission probability
% the probabilities are tracked by a log magnitude to avoid underflow

[T, ~] = size(O);
beta_logmag_hist = zeros(1, T);
beta_vec_hist = zeros(COHMM.S, t);

% initialize beta to be one 
beta_temp = ones( COHMM.S, 1 );
beta_mag = norm(beta_temp, 1);
beta_vec_hist(:, T) = beta_temp./beta_mag;
beta_logmag_hist(T) = log2(beta_mag);

if T > 1
    %induction
    if nargin < 3
        for i = T-1:-1:1
            beta_temp = COHMM.A * (COEmission( COHMM, O(i+1, :) ) .* beta_vec_hist(:, i+1));
            beta_mag = norm(beta_temp, 1);
            beta_vec_hist(:, i) = beta_temp ./ beta_mag;
            beta_logmag_hist(i) = beta_logmag(i+1) + log2(beta_mag);
        end
    else
        for i = T-1:-1:1
            beta_temp = COHMM.A * (Emission_hist(:, i+1) .* beta_vec_hist(:, i+1));
            beta_mag = norm(beta_temp, 1);
            beta_vec_hist(:, i) = beta_temp ./ beta_mag;
            beta_logmag_hist(i) = beta_logmag(i+1) + log2(beta_mag);
        end
    end
end

end

