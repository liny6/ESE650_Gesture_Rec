function [gesture_clustered, centroids] = ClusterObservation( gesture, clusters )

[~, num_EX] = size(gesture);
totalT = 0;

for ex = 1:num_EX
    [T, D] = size(gesture(ex).IMU_data);
    totalT = totalT + T;
end

alldata = zeros(totalT, D);

startT = 1;

for ex = 1:num_EX
    [T, ~] = size(gesture(ex).IMU_data);
    endT = startT + T-1;
    alldata(startT:endT, :) = gesture(ex).IMU_data;
    startT = endT + 1;
end

[idx, centroids] = kmeans(alldata, clusters);
allclustered = zeros(totalT, clusters);
onesidx = sub2ind([totalT, clusters], 1:totalT, idx');
allclustered(onesidx) = 1;

startT = 1;
for ex = 1:num_EX
    [T, ~] = size(gesture(ex).IMU_data);
    endT = startT + T-1;
    gesture_clustered(ex) = struct('IMU_data', allclustered(startT:endT, :));
    startT = endT + 1;
end

end
