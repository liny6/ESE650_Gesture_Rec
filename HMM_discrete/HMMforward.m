function [alpha_logmag_hist, alpha_vec_hist, emission_hist] = HMMforward( HMM, O )

[T, ~] = size(O);
alpha_logmag_hist = zeros(1, T);
alpha_vec_hist = zeros(HMM.S, T);
emission_hist = HMM.B * O';

%initialization
alpha_temp = HMM.PI .* emission_hist(:,1);
alpha_mag = sum(alpha_temp);
alpha_vec_hist(:, 1) = alpha_temp./alpha_mag;
alpha_logmag_hist(1) = log2(alpha_mag);

if T > 1
    for t = 2:T
        alpha_temp = HMM.A * alpha_vec_hist(:, t-1) .* emission_hist(:, t);
        alpha_mag = sum(alpha_temp);
        alpha_vec_hist(:, t) = alpha_temp./alpha_mag;
        alpha_logmag_hist(t) = alpha_logmag_hist(t-1) + log2(alpha_mag);
    end
end


end

