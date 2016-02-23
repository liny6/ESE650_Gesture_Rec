function P = HMMevallogP( HMM, gesture )
%HMMEVALLOGP Summary of this function goes here
%   Detailed explanation goes here
[~, numEX] = size(gesture);
P = zeros(numEX, 1);

for ex = 1 : numEX
    logmags = HMMforward(HMM, gesture(ex).IMU_data);
    P(ex) = logmags(end);
end

end

