function [HMM, HMM_novec] = ConstructHMM( A, B, PI )

[S, K] = size(B);

HMM = struct('A', A, 'B', B, 'PI', PI, 'S', S, 'K', K);
HMM_novec = struct('A', A', 'B', B, 'PI', PI, 'S', S, 'K', K);


end

