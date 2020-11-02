function [a, r] = simulate_M1random_v1(T, mu, b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code simulates Model 1, which is the random sampling model. In this model, we assume the participants are not engaged in the task, but are still responding. This is not uncommon.
% This helps experimenters determine if any participants are simply checked out and not actually enganging with the task.
% This model assumes that participants choose between the two options randomly, perhaps with some bias for one over the other.
% the bias is captures by the var 'b' where 0 < b < 1
% Thus the model only has one free param
%
% Variables:
% b : free var
% T : number of trials
% mu :  mean reward of the two option, ie [.2, .8]
%
% Output:
% a : Simulated choices
% r: simulated reward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for t = 1:T

    % compute choice probabilities
    p = [b 1-b];

    % make choice according to choice probababilities using a function defined in this folder, where in this case the probability of choosing 1 is b and choosing 2 is 1-b
    a(t) = choose(p);

    % generate reward based on choice. rand is a function with 0 arguements produced a random number between 0 and 1, a will be 1 b% of the time
    r(t) = rand < mu(a(t));

end
