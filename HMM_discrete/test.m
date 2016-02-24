K = 25;
S = 10;

gesturestr = cell(1, 6);
data = cell(1,6);

gesturestr{1} = 'wave';
gesturestr{2} = 'circle';
gesturestr{3} = 'eight';
gesturestr{4} = 'inf';
gesturestr{5} = 'beat3';
gesturestr{6} = 'beat4';

for i = 1:length(gesturestr)
    data{i} = Load_Gesture_Data('../Proj3_train_set', gesturestr{i});
end

[data_clustered, centroids] = ClusterObservation(data, K);

save(sprintf('centroids%d%d.mat', S, K), 'centroids')

models = cell(1, length(data_clustered));

for i = 1:length(data_clustered)
    models{i} = HMMlearn(data_clustered{i}, S, K, 50, 100);
end

save(sprintf('models%d%d.mat', S, K), 'models')

%% evaluation

for i = 1:length(models)
    P = cell(length(models), length(data_clustered));
    for j = 1:length(data_clustered)
        P{i, j} = HMMevallogP(models{i}, data_clustered{j});
    end
    fprintf('evaluation using the %s model\n', gesturestr{i})
    for j = 1:length(data_clustered)
        fprintf('%s: %s\n', gesturestr{j}, num2str(P{i, j}'));
    end    
    fprintf('\n')
end
%% recognition
%load up validation set

validation_set = cell(1, length(models));
for i = 1:length(models)
    validation_set{i} = Load_Gesture_Data('../Proj3_train_set_additional', gesturestr{i});
    n = gestrec(models, validation_set{i}, centroids, gesturestr, i);
end

