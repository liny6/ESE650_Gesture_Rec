function [ Xi, gamma ] = COHMMpair( COHMM, O)
% This calculates the likelihood of a pair of states at step t
% output Xi is a S by S by T-1 array 
[T, ~] = size(O);
Xi = zeros(COHMM.S, COHMM.S, T-1);
gamma = zeros(COHMM.S, T-1);

[alpha_mag, alpha_vec, emissions] = COHMMforward( COHMM, O );
[beta_mag, beta_vec] = COHMMbackward( COHMM, O, emissions );

for i = 1:T-1
    % calculate the top of the fraction
    Xi_top_vec = alpha_vec(:, i) * (beta_vec(:, i+1)' .* emissions(:, i+1)') .* COHMM.A;
    % normalize the fraction to obtain Xi
    Xi_mag = 2 ^ (alpha_mag(i) + beta_mag(i+1) - alpha_mag(T)) / sum(alpha_mag(:, T));
    Xi(:, :, i) = Xi_mag * Xi_top_vec;
    gamma(:, i) = sum(Xi, 2);
end