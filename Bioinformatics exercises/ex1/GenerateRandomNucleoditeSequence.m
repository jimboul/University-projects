function [N] = GenerateRandomNucleoditeSequence(L)

% This function generates a random nucleodite sequence where each base 
% within the biological alphabet {A,T,C,G} is equi-probable.
% N: is the random nucleodite to be generated.
% L: is the length of the random nucleodite.


% Set the biological vocabulary.
vocabulary = ['A','T','C','G'];
% Get the number of letters within the vocabulary.
vocabulary_length = length(vocabulary);
% Initially, generate a L-lengthed random sequence integers in rangen 
% {1,2,3,4}.
R = randi(vocabulary_length,1,L);
% Transform the sequence of integers into the corresponding string.
N = num2str(R')';
% Replace integers with corresponding base letters.
for letter_index = 1:1:vocabulary_length
    N = strrep(N,num2str(letter_index),vocabulary(letter_index));
end;

end

