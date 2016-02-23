function [HMM, HMMnovec] = RandomHMM_novec( S, K )

% K is number of discrete possible outputs

PI = rand(S, 1);
PI = PI ./ norm(PI, 1);
%PI = zeros(S, 1);
%PI(1) = 1;
%{
A_self = 0.99*ones(S, 1);
A_trans = 1-A_self;
A = diag(A_self);

for s = 1:S-1
    A(s+1, s) = A_trans(s);
end

A(end, end) = 1;
%}

A = rand(S, S);
A = bsxfun(@times, A, 1./sum(A, 2));

B = rand(S, K);
B = bsxfun(@times, B, 1./sum(B, 2));

[HMM, HMMnovec] = ConstructHMM(A, B, PI);



end

