function P = COEmission( COHMM, O, state_idx)
% Given a COHMM model and observation, output the likelihood
% the output alpha is either a scalar if specific state index is selected,
% or a column vector of length S corresponding to the emission probability
% given each state

    %P = 1/((2*pi)^COHMM.S_num * det(COHMM.C(:,:,state_idx))) * exp(-0.5 * (O-COHMM.mu(:, state_idx))' * COHMM.Cinv * (O-COHMM.mu(:, state_idx)));
    if nargin == 3
        P = sum(COHMM.K(:, state_idx) .* mvnpdf(O, COHMM.mu(:, :, state_idx), COHMM.C(:, :, :, state_idx)));
    else
        P = zeros( COHMM.S, 1 );
        for idx = 1 : COHMM.S
            P(idx) = sum(COHMM.K(:, idx) .* mvnpdf(O, COHMM.mu(:, :, idx), COHMM.C(:, :, :, idx)));
        end
    end

end

