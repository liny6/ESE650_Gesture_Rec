function [ alpha_logmag_hist, alpha_vec_hist, emission_hist ] = HMMforward_novec( HMM, O )
%
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
        alpha_temp = zeros(HMM.S,1);
        for j = 1:HMM.S;
            for i = 1:HMM.S;
                alpha_temp(j) = alpha_temp(j) + alpha_vec_hist(i, t-1)*HMM.A(i, j);
            end
        end
        alpha_temp = alpha_temp.*emission_hist(:,t);
        alpha_mag = sum(alpha_temp);
        alpha_vec_hist(:, t) = alpha_temp./alpha_mag;
        alpha_logmag_hist(t) = alpha_logmag_hist(t-1) + log2(alpha_mag);
    end
end

end

