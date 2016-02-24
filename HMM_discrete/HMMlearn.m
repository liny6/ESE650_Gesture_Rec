function final_model = HMMlearn( gesture, S, K, max_iter, trials )
%
P_best = -inf;
model_best = RandomHMM(S, K);

for t = 1:trials
    %randomly generate model
    model_est = RandomHMM(S, K);
    model_old = model_est;
    
    isconverged = 0;
    iter = 1;
    
    %first evaluate on random model
    P = HMMevallogP( model_est, gesture );
        
    sumP_old = sum(P);
    P_str = num2str(sumP_old);
    iterstr = sprintf('Trial %d, Iteration %d likelihood %s\n', t, iter, P_str);
    
    fprintf('%s', iterstr)
    
    while iter < max_iter && ~isconverged
        %perform EM
        iter = iter + 1;
        model_est = HMMem(model_est, gesture);
        
        %evaluate joint probability
        P = HMMevallogP( model_est, gesture );
        sumP = sum(P);
        
        if isnan(sumP)
            fprintf('unstable\n')
            break; %end early if things become unstable
        end
        
        %{
        if sumP < sumP_old
            fprintf('auxiliary function suboptimality observed, terminate early to speed up the process\n')
            model_est = model_old;
            break;
        end
        %}
        
        sumP_old = sumP;
        
        P_str = num2str(sumP);
        delstr = repmat(sprintf('\b'), [1, length(iterstr)]);
        iterstr = sprintf('Trial %d, Iteration %d likelihood %s\n', t, iter, P_str);
        
        fprintf('%s%s', delstr, iterstr)
        
        %check for convergence
        isconverged = HMMcompare(model_est, model_old);
        model_old = model_est;
    end
    %P = HMMevallogP( model_est, gesture );
    if sumP > P_best
        model_best = model_est;
        P_best = sum(P);
    end
end
final_model = model_best;


end

