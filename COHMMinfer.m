function Q = COHMMinfer( COHMM, O )
% infers the probability of the sequence of states given model and
% observation

[T, ~] = size(O);

%final state sequence
Q = zeros(T, 1);

%initialize parameters for dynamic programming

%"score" - the likelyhood of the joint probability of a given state
%sequence and observation
delta = COHMM.PI .* COEmission( COHMM, O(1, :) );
%normalize delta as i go to avoid underflow
delta = delta./norm(delta, 1);
%best previous state to get to the current state
psi = zeros(COHMM.S, T);

%iteration

for i = 2:T
    % EL - evolve likelihood
    % EL_idx - index of the max 
    [EL, EL_idx] = max(bsxfun(@times, COHMM.A, delta'), [], 2);
    %first update the best previous state to evolve to this state
    psi(:, i) = EL_idx;
    %then update delta
    delta = EL .* COEmission( COHMM, O(i, :) );
    delta = delta ./ norm(delta, 1);
end

%termination: i won't bother with P* since I don't care about the
%likelihood of the sequence

[~, Q_T] = max(delta(:, T));
Q(T) = Q_T;

%backtracking
for i = T-1:-1:1
    Q(i) = psi(Q(i+1), i+1);
end

    

end

