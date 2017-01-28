function [ w_per ] = perceptron( X,Y,w_init )
%PERCEPTRON Summary of this function goes here
%   Detailed explanation goes here

w_per = w_init;
for iteration = 1 : 100  
  for ii = 1 : size(X,2) % Cycle through training set
    if sign(w_per'*X(:,ii)) ~= Y(ii) % Wrong decision
      w_per = w_per + X(:,ii) * Y(ii);   % then add this point to w_per
    end
  end
  % Show misclassification rate
  %misclassification_rate = sum(sign(w_per'*X)~=Y)/size(X,2);   
  %disp(misclassification_rate);
end

