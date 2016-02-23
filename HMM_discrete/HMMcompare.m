function isconverged = HMMcompare( model1, model2 )
%HMMCOMPARE Summary of this function goes here
%   Detailed explanation goes here

A_diff = norm(model1.A-model2.A, 'fro');
B_diff = norm(model1.B-model2.B, 'fro');
PI_diff = norm(model1.PI-model2.PI, 'fro');

if A_diff < 1e-5 && B_diff < 1e-5 && PI_diff < 1e-5
    isconverged = 1;
else
    isconverged = 0;
end

end

