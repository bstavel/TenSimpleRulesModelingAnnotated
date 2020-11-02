function [a, r] = simulate_M3RescorlaWagner_v1(T, mu, alpha, beta)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This code simulates Model 3, which is the Rescorla Wagner model. In this model, participants first learn the expected value of each slot machine based in the history of previous outcomes and then use these values
  % to make a decision about what to do next. A simple model of learning is the Rescorla Wagner learning rule, whereby the value of option k is updated in response to reward r, learning rate alpha, and the outcome on % % the last trial. The decision making portion of the model in this case is the softmax choice rule, which is dependent on the value of option k and an exploration or mistake free parameter b.
  %
  % Variables:
  % alpha : learning rate, free var
  % beta : exploration rate, free var
  % T : number of trials
  % mu : mean reward of the two option, ie [.2, .8]
  %
  % Output:
  % a : Simulated choices
  % r: Simulated reward
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q = [0.5 0.5]; % At the first trial, assume the liklihood of picking either option is 50-50

for t = 1:T

    % compute choice probabilities (this is the softmax function)
    p = exp(beta*Q) / sum(exp(beta*Q));

    % make choice according to choice probababilities
    a(t) = choose(p);

    % generate reward based on choice
    r(t) = rand < mu(a(t));

    % update values (this is the rescorla wagner learning rule)
    delta = r(t) - Q(a(t));
    Q(a(t)) = Q(a(t)) + alpha * delta;

end
