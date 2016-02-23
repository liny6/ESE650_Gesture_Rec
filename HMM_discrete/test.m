K = 4;
S = 5;

wave = Load_Gesture_Data('../Proj3_train_set', 'wave');
circle = Load_Gesture_Data('../Proj3_train_set', 'circle');
eight = Load_Gesture_Data('../Proj3_train_set', 'eight');
iinnff = Load_Gesture_Data('../Proj3_train_set', 'inf');
beat = Load_Gesture_Data('../Proj3_train_set', 'beat');

[wave_clustered, waveC] = ClusterObservation(wave(1:end-1), K);
[circle_clustered, circleC] = ClusterObservation(circle(1:end-1), K);
[eight_clustered, eightC] = ClusterObservation(eight(1:end-1), K);
[iinnff_clustered, iinnffC] = ClusterObservation(iinnff(1:end-1), K);
[beat_clustered, beatC] = ClusterObservation(beat(1:end-1), K);

centroids = cell(1, 5);
centroids{1} = waveC;
centroids{2} = circleC;
centroids{3} = eightC;
centroids{4} = iinnffC;
centroids{5} = beatC;

wavemodel = HMMlearn(wave_clustered(1:end), S, K, 50, 100);
circlemodel = HMMlearn(circle_clustered(1:end), S, K, 50, 100);
eightmodel = HMMlearn(eight_clustered(1:end), S, K, 50, 100);
iinnffmodel = HMMlearn(iinnff_clustered(1:end), S, K, 50, 100);
beatmodel = HMMlearn(beat_clustered(1:end), S, K, 50, 100);

save('wavemodel.mat', 'wavemodel')
save('circlemodel.mat', 'circlemodel')
save('eightmodel.mat', 'eightmodel')
save('infmodel.mat', 'iinnffmodel')
save('beatmodel.mat', 'beatmodel')

models = cell(1, 5);
models{1} = wavemodel;
models{2} = circlemodel;
models{3} = eightmodel;
models{4} = iinnffmodel;
models{5} = beatmodel;

save('models.mat', 'models')

%% evaluation

Pwave = HMMevallogP(wavemodel, wave_clustered);
Pcircle = HMMevallogP(wavemodel,circle_clustered);
Peight = HMMevallogP(wavemodel, eight_clustered);
Pinf = HMMevallogP(wavemodel, iinnff_clustered);
Pbeat = HMMevallogP(wavemodel, beat_clustered);

fprintf('wave: %s\n', num2str(Pwave'))
fprintf('circle: %s\n', num2str(Pcircle'))
fprintf('eight: %s\n', num2str(Peight'))
fprintf('inf: %s\n', num2str(Pinf'))
fprintf('beat: %s\n', num2str(Pbeat'))

%% recognition

gestrec(models, wave(end), waveC)
gestrec(models, circle(end), circleC)
gestrec(models, eight(end), eightC)
gestrec(models, iinnff(end), iinnffC)
gestrec(models, beat(end), beatC)
