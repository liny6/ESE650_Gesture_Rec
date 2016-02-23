function [ beta_logmag_hist, beta_vec_hist ] = HMMbackward( HMM, O, emission_hist )

[T, ~] = size(O);
beta_logmag_hist = zeros(1, T);
beta_vec_hist = zeros(HMM.S, T);

%
beta_temp = ones(HMM.S, 1);
beta_mag = sum(beta_temp);
beta_vec_hist(:, T) = beta_temp./beta_mag;
beta_logmag_hist(T) = log2(beta_mag);

if T > 1
    for t = T-1: -1 : 1
        beta_temp = HMM.A * (emission_hist(:, t+1) .* beta_vec_hist(:, t+1));
        beta_mag = sum(beta_temp);
        beta_vec_hist(:, t) = beta_temp ./ beta_mag;
        beta_logmag_hist(t) = beta_logmag_hist(t+1) + log2(beta_mag);
    end
end
end

