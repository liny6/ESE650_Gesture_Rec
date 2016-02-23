function final_model = HMMlearn( gesture, S, K, max_iter, trials )
%
P_best = -inf;
model_best = RandomHMM(S, K);

for t = 1:trials
    %randomly generate model
    model_est = RandomHMM(S, K);
    model_old = RandomHMM(S, K);
    
    isconverged = 0;
    iter = 0;
    iterstr = [];
    %perform EM
    while iter < max_iter && ~isconverged
        iter = iter + 1;
        P = HMMevallogP( model_est, gesture );
        
        sumP = sum(P);
        P_str = num2str(sumP);
        
        if isnan(sumP)
            fprintf('unstable\n')
            break; %end early if things become unstable
        end
        
        delstr = repmat(sprintf('\b'), [1, length(iterstr)]);
        iterstr = sprintf('Trial %d, Iteration %d likelihood %s\n', t, iter, P_str);
        
        fprintf('%s%s', delstr, iterstr)
        
        %check for convergence
        isconverged = HMMcompare(model_est, model_old);
        model_old = model_est;
        model_est = HMMem(model_est, gesture);
    end
    P = HMMevallogP( model_est, gesture );
    if sum(P) > P_best
        model_best = model_est;
        P_best = sum(P);
    end
end
final_model = model_best;


end

