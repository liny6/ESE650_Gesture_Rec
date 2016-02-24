function [gesture_clustered, centroids] = ClusterObservation( gesture, clusters )
    
    gesture_clustered = cell(1, length(gesture));
    
    totalT = 0;
    for c = 1:length(gesture)
        [~, num_EX] = size(gesture{c});
        
        for ex = 1:num_EX
            [T, D] = size(gesture{c}(ex).IMU_data);
            totalT = totalT + T;
        end
        
    end
    alldata = zeros(totalT, D);
    startT = 1;
    
    for c = 1:length(gesture)
        [~, num_EX] = size(gesture{c});

        for ex = 1:num_EX
            [T, ~] = size(gesture{c}(ex).IMU_data);
            endT = startT + T-1;
            alldata(startT:endT, :) = gesture{c}(ex).IMU_data;
            startT = endT + 1;
        end
        
        [idx, centroids] = kmeans(alldata, clusters);
        allclustered = zeros(totalT, clusters);
        onesidx = sub2ind([totalT, clusters], 1:totalT, idx');
        allclustered(onesidx) = 1;  
    end
    
    startT = 1;
    
    for c = 1:length(gesture)
        [~, num_EX] = size(gesture{c});
        
        for ex = 1:num_EX
            [T, ~] = size(gesture{c}(ex).IMU_data);
            endT = startT + T-1;
            gesture_clustered{c}(ex) = struct('IMU_data', allclustered(startT:endT, :));
            startT = endT + 1;
        end
        
    end
    
end
