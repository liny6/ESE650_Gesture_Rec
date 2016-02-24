%load models

load models1025.mat
load centroids1025.mat

gesturestr = cell(1, 6);

gesturestr{1} = 'wave';
gesturestr{2} = 'circle';
gesturestr{3} = 'eight';
gesturestr{4} = 'inf';
gesturestr{5} = 'beat3';
gesturestr{6} = 'beat4';



%% recognition
%load up validation set

validation_set = cell(1, length(models));
for i = 1:length(models)
    validation_set{i} = Load_Gesture_Data('../Proj3_train_set_additional', gesturestr{i});
    n = gestrec(models, validation_set{i}, centroids, gesturestr, i);
end
