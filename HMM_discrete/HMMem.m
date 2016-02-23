function model = HMMem( HMM, Gesture )

[~, num_EX] = size(Gesture);
A_top = zeros(HMM.S, HMM.S);
A_bot = zeros(1, HMM.S);
B_top = zeros(HMM.K, HMM.S);
PI_acc = zeros(1, HMM.S);


for ex = 1:num_EX
    O = Gesture(ex).IMU_data;
    [T, ~] = size(O);
    
    %% E step
    %forward backward
    [alphamag, alphavec, emissions] = HMMforward( HMM, O);
    [betamag, betavec] = HMMbackward( HMM, O, emissions );
    Xi = zeros( HMM.S, HMM.S, T );
    gamma = zeros(T, HMM.S);
    %find Xi
    for t = 1:T-1
        % Beta zhi Alpha heng
        Xi_top = (emissions(:, t+1) .* betavec(:, t+1)) * alphavec(:, t)' .* HMM.A;
        Xi_bot = sum(sum(Xi_top));
        Xi(:, :, t) = Xi_top./Xi_bot;
        gamma(t, :) = sum(Xi(:, :, t), 1);
    end
    
    %% M step
    
    A_top = A_top + sum(Xi, 3);
    A_bot = A_bot + sum(gamma, 1);
    B_top = B_top + O' * gamma;
    PI_acc = PI_acc + gamma(1, :);
end

    A = bsxfun(@times, A_top, 1./A_bot);
    B = bsxfun(@times, B_top, 1./A_bot)';
    
    indBzero = find(B <= 1e-8);
    
    if(~isempty(indBzero))
        B(indBzero) = 1e-10;
        B = bsxfun(@times, B, 1./sum(B, 2));
    end
    
    PI = PI_acc' ./ num_EX;
    
    model = ConstructHMM(A, B, PI);
end

