function [a, r] = simulate_M2WSLS_v1(T, mu, epsilon)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This code simulates Model 2, which is the Noisy win-stay-lose shift model. In the win-stay-lose model, we assume the participant repeats rewarded actions and switches away
  % from unrewarded actions. In the noisy version of this model, the model applies the win-stay-lose algorithm with a probability of '1-epsilon', and picks randomly with probability 'epsilon'
  %
  % Variables:
  % epsilon : free var
  % T : number of trials
  % mu : mean reward of the two option, ie [.2, .8]
  %
  % Output:
  % a : Simulated choices
  % r: Simulated reward
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% last reward/action (initialize as nan)
rLast = nan;
aLast = nan;

for t = 1:T

    % compute choice probabilities
    if isnan(rLast)

        % first trial choose randomly
        p = [0.5 0.5];

    else

        % choice depends on last reward
        if rLast == 1

            % win stay (with probability 1-epsilon) here we divide epsilon by 2, because it chooses randomly with probability epsilon which means it randomly chooses 1 with epsilon/2 probability and 2 with epsilon/2
            p = epsilon/2*[1 1];
            p(aLast) = 1-epsilon/2;

        else

            % lose shift (with probability 1-epsilon)
            p = (1-epsilon/2) * [1 1];
            p(aLast) = epsilon / 2;

        end
    end

    % make choice according to choice probababilities using a function defined in this folder
    a(t) = choose(p);

    % generate reward based on choice
    r(t) = rand < mu(a(t));


    aLast = a(t);
    rLast = r(t);
end
