trans = [0.9,0.1;0.1,0.9];
emis = [0.4 0.4 0.1 0.1;0.2 0.2 0.3 0.3];

%% For a random sequence of length 4
[seq,states] = hmmgenerate(4,trans,emis,'Symbols',['A' 'G' 'T' 'C'],'Statenames',{'a';'b'});
numeric_states = cell2mat(states);
modified_seq = [0 0 0 0];
for i = 1:4
    if (seq(i) == 'A')
        modified_seq(i) = 1;
    elseif (seq(i) == 'G')
        modified_seq(i) = 2;
    elseif (seq(i) == 'T')
        modified_seq(i) = 3;
    elseif (seq(i) == 'C')
        modified_seq(i) = 4;
    end
end

estimatedStates = hmmviterbi(modified_seq,trans,emis);

fprintf('The sequence is: %s\n',seq);

fprintf('Program paused. Press enter to continue.\n');
pause;

modified_estimatedStates = [0 0 0 0];

for i = 1:4
    if (estimatedStates(i) == 1)
        modified_estimatedStates(i) = 'a';
        fprintf('The state after Viterbi algorithm is: a\n');
    elseif (estimatedStates(i) == 2)
        modified_estimatedStates(i) = 'b';
        fprintf('The state after Viterbi algorithm is: b\n');
    end
end

fprintf('The states are: %s\n',numeric_states);

fprintf('Program paused. Press enter to continue.\n');
pause;

viterbi_accuracy = sum(numeric_states == modified_estimatedStates)/4;

fprintf('The most likely sequence of states using Viterbi algorithm agrees with the random sequence %f of the time.\n',viterbi_accuracy);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% For a fixed sequence of length 4

% The sequence will be the following: GTCC

[~,states] = hmmgenerate(4,trans,emis,'Symbols',['A' 'G' 'T' 'C'],'Statenames',{'a';'b'});
seq = 'GTCC';
numeric_states = cell2mat(states);
modified_seq = [0 0 0 0];
for i = 1:4
    if (seq(i) == 'A')
        modified_seq(i) = 1;
    elseif (seq(i) == 'G')
        modified_seq(i) = 2;
    elseif (seq(i) == 'T')
        modified_seq(i) = 3;
    elseif (seq(i) == 'C')
        modified_seq(i) = 4;
    end
end

estimatedStates = hmmviterbi(modified_seq,trans,emis);

fprintf('The sequence is: %s\n',seq);

fprintf('Program paused. Press enter to continue.\n');
pause;

modified_estimatedStates = [0 0 0 0];

for i = 1:4
    if (estimatedStates(i) == 1)
        modified_estimatedStates(i) = 'a';
        fprintf('The state after Viterbi algorithm is: a\n');
    elseif (estimatedStates(i) == 2)
        modified_estimatedStates(i) = 'b';
        fprintf('The state after Viterbi algorithm is: b\n');
    end
end

fprintf('The states are: %s\n',numeric_states);

fprintf('Program paused. Press enter to continue.\n');
pause;

viterbi_accuracy = sum(numeric_states == modified_estimatedStates)/4;

fprintf('The most likely sequence of states using Viterbi algorithm agrees with the random sequence %f of the time.\n',viterbi_accuracy);

