function [a, r] = simulate_M5RWCK_v1(T, mu, alpha, beta, alpha_c, beta_c)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This code simulates Model 5, which mixes model 3, the Rescorla Wagner model and model 4, the choice kernal model. The values update as in Model 3, and the choices are updated as in Model 4. Then the terms are combined to compute the choice probababilities via the softmax function, where the inputs are the sum of updated values and updated choice.
  %
  % Variables:
  % alpha : learning rate, free var
  % beta : exploration rate, free var
  % alpha_c : learning rate for choice, free var
  % beta_c : exploration rate for choice , free var
  % T : number of trials
  % mu : mean reward of the two option, ie [.2, .8]
  %
  % Output:
  % a : Simulated choices
  % r: Simulated reward
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q = [0.5 0.5];
CK = [0 0];

for t = 1:T

    % compute choice probabilities (softmax function is based on Reward of that option, 'Q', and the choice kernal 'C')
    V = beta * Q + beta_c * CK;
    p = exp(V) / sum(exp(V));

    % make choice according to choice probababilities
    a(t) = choose(p);

    % generate reward based on choice
    r(t) = rand < mu(a(t));

    % update values
    delta = r(t) - Q(a(t));
    Q(a(t)) = Q(a(t)) + alpha * delta;

    % update choice kernel
    CK = (1-alpha_c) * CK;
    CK(a(t)) = CK(a(t)) + alpha_c * 1;


end
