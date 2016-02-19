function gesture_data = Load_Gesture_Data(folder, gesture)

% load files relevant to desired gesture
data_dir = dir(sprintf('%s/%s*.txt',folder, gesture));

% load all the data in a struct

for i = 1 : length( data_dir )
    data_temp = dlmread(sprintf('%s/%s', folder, data_dir(i).name));
    time_stamp = data_temp(:, 1);
    IMU_data = data_temp(:, 2:end);
    gesture_data(i) = struct('ts', time_stamp, 'IMU_data', IMU_data);
end


end