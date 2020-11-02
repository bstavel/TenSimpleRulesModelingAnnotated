function [a, r] = simulate_M4ChoiceKernel_v1(T, mu, alpha_c, beta_c)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This code simulates Model 4, which tries to capture the tendency for people to repeat their previous actions. In particular, we assume participants compute a 'choice kernal', for each action, which keeps track of % % how often they chose that option in the recent past. The kernal updates the values as in the Rescorla Wagner model, where instead of updating on the reward, it updates based on prior choices. Thus, if alpha == 1
  % it behaves similarly to the win-stay-lose shift model. The softmax function is used as in model 3, with a free parameter respresnting the frequency of exploration.
  %
  % Variables:
  % alpha_c : learning rate, free var
  % beta_c : exploration rate, free var
  % T : number of trials
  % mu : mean reward of the two option, ie [.2, .8]
  %
  % Output:
  % a : Simulated choices
  % r: Simulated reward
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


CK = [0 0];

for t = 1:T

    % compute choice probabilities (this is the softmax function)
    p = exp(beta_c*CK) / sum(exp(beta_c*CK));

    % make choice according to choice probababilities
    a(t) = choose(p);

    % generate reward based on choice
    r(t) = rand < mu(a(t));

    % update choice kernel
    CK = (1-alpha_c) * CK;
    CK(a(t)) = CK(a(t)) + alpha_c * 1;


end
