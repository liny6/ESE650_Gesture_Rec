function [alpha_logmag_hist, alpha_vec_hist, Emission_hist] = COHMMforward( COHMM, O )
% continuous observation HMM forward emission probability
% the probabilities are tracked by a log magnitude to avoid underflow
% output is a 1xT vector for magnitude, and a SxT array for "direction"

% calculate number of steps of the observation
[T, ~] = size(O);
alpha_logmag_hist = zeros(1, T);
alpha_vec_hist = zeros(COHMM.S, T);
Emission_hist = zeros(COHMM.S, T);

% calculate alpha based on the first reading
emission_temp = COEmission( COHMM, O(1, :) );
alpha_temp = COHMM.PI .* emission_temp;
alpha_mag = norm(alpha_temp, 1);
alpha_vec_hist(:, 1) = alpha_temp./alpha_mag;
alpha_logmag_hist(1) = log2(alpha_mag);
Emission_hist(:, 1) = emission_temp;

if T > 1  
    %induction
    for i = 2 : T
        emission_temp = COEmission( COHMM, O(i, :) );
        alpha_temp = COHMM.A * alpha_vec_hist(:, i-1) .* emission_temp;
        alpha_mag = norm(alpha_temp, 1);
        alpha_vec_hist(:, i) = alpha_temp./alpha_mag;
        alpha_logmag_hist(i) = alpha_logmag_hist(i-1) + log2(alpha_mag);
        Emission_hist(:, i) = emission_temp;
    end
end

end

