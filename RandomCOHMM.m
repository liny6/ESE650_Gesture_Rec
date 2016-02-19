function COHMMmodel = RandomCOHMM( S, G)
%RANDOMCOHMM generates a random COHMM given number of hidden states and
%number of GMM for emission

PI = rand(S, 1);
PI = PI ./ norm(PI, 1);

A = rand(S, S);
A = bsxfun(@times, A, 1./sum(A, 1));

K = rand(G, S);
K = bsxfun(@times, K, 1./sum(G, 1));

mu_acc = 40*rand(G, 3, S) - 20;
mu_gyro = 20*rand(G, 3, S) - 10;

mu = cat(2, mu_acc, mu_gyro);

C = zeros(6, 6, G, S);

for i = 1:G
    for j = 1:S
        somemat = 5*rand(6) - 2.5*rand(6);
        C(:, :, i, j) = somemat*somemat;
    end
end

COHMMmodel = ConstructCOHMM( A, PI, K, mu, C );

end

