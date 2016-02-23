K = 5;
S = 4;

wave = Load_Gesture_Data('../Proj3_train_set', 'wave');
wave_clustered = ClusterObservation(wave, K);
O = wave_clustered(1).IMU_data;

[HMM, HMM_novec] = RandomHMM_novec(S, K);

[alphamag1, alphavec1, em1] = HMMforward( HMM, O);
[alphamag2, alphavec2, em2] = HMMforward_novec( HMM_novec, O);