function a = choose(p)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % This code chooses an option based on a vector of probabilities between the two options
  %
  % Variables:
  % p : probabilities
  %
  % Output:
  % a : Simulated choice
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %BRS not sure why we include the -eps and the cumsum. How is this different then b < rand ?
a = max(find([-eps cumsum(p)] < rand));
