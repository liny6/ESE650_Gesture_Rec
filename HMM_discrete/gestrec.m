function n = gestrec( models, gesture, centroids, geststr, gestind )
%GESTREC Summary of this function goes here
%   Detailed explanation goes here
[~, numEX] = size(gesture);
nummodels = length(models);

P = zeros(numEX, nummodels);

for ex = 1:numEX
    Oraw = gesture(ex).IMU_data;
    [K, ~] = size(centroids);
    [T, N] = size(Oraw);
    centroidsK1N = reshape(centroids, [K, 1, N]);
    Oraw1TN = reshape(Oraw, [1, T, N]);
    alldiff = bsxfun(@minus, Oraw1TN, centroidsK1N);
    allsqdist = sum(alldiff.^2, 3);
    [~, minind] = min(allsqdist, [], 1);
    O = zeros(T, K);
    oneidx = sub2ind([T, K], 1:T, minind);
    O(oneidx) = 1;
    Ostruct = struct('IMU_data', O);
    
    
    for i = 1:length(models)
        P(ex, i) = HMMevallogP(models{i}, Ostruct);
    end
    
end
[~, n] = max(P, [], 2);

for i = 1:length(n)
    fprintf('for validation set %s, the determined gesture is %s\n', geststr{gestind}, geststr{n(i)})
end
    

end

