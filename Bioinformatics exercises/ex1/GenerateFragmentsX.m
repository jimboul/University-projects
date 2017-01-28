function [Fragments,OccurrenceMatrix,Coverage] = GenerateFragmentsX(N,Cmean,FSmin,FSmax,Pinc)

% This function serves as an extention to the original GenerateFragments 
% function. It takes as input the nucleodite string stored in N producing
% the cell array Fragments which stores fragments of the initial nucledite
% string in such away so that the average coverage is Coverage, the minimum
% fragment size is FSmin and the maximum fragment size is FSmax. Pinc is
% the probability of incorportating a particular fragment.
% The additional functionality provided corresponds to the computation of 
% the Occurrence matrix which may subsequently be utilized in order to compute 
% the actual coverage achieved through the underluing process.   

% Get the lenght of the input nucleodite sequence.
nucleodite_length = length(N);
% Initialize "Fragments" container.
Fragments = cell(1,0);
% Set current fragment index.
fragment_index = 1;

% Set up fragment generation loop.
% The outer loop will be executed copies_number times. Given that each 
% candidate fragment will be icluded within the "Fragments" cell array with
% a probability of (1/2), the overall average coverage will be Cmean. 
% This is true since X ~ B(n,p) with p = 1/2, with X being the random
% variable indicating whether a particular fragment have been included or 
% not. Therefore, for the related Binomial Distribution we have that 
% E[X] = n*p  = (2*Cmean) * (1/2) = Cmean.

% For the general case, however, if p = Pinc then in order to achieve an
% average coverage of Cmean the number of copies from the original
% nucleodite sequence "copies_number" should be estimated by the following
% relation:
% E[X] = copies_number * Pinc <=>
% Cmean = copies_number * Pinc <=>
% copies_number = Cmean * (Pinc)^(-1)

copies_number = round(Cmean * (Pinc)^(-1));

% Initialize an [copies_number x nucleodite_length] OccurrenceMatrix such
% that:
% OccurenceMatrix[i,j] = 1 iff the j-th base within the original nucleodite
%                          sequence is included by any fragment of the i-th 
%                          copy.
% OccurenceMatrix[i,j] = 0 iff the j-th base within the original necleodite
%                          sequence is not included by any fragment of the
%                          i-th copy.

OccurrenceMatrix = zeros(copies_number,nucleodite_length);

for copy_index = 1:1:copies_number
    % At each iteration, the given nucleodite string will be randomly
    % fragmented into pieces of sizes within the range [FSmin,FSmax] and
    % each fragment will be included within the final collection with a
    % probability of Pinc.
        
    % Compute the maximum number of fragments that might be needed. This is
    % the case where all fragments are of size FSmin.
    maximum_fragments = round(nucleodite_length/FSmin);
    
    % Constuct a random sequence of fragment sizes within the [FSmin,FSmax]
    % range so that the total length is equal to the length of the original
    % nucleodite sequence.
    fragment_sizes = randi([FSmin FSmax],1,maximum_fragments);
    % Compute the cumulative fragment sizes in order to identify the number 
    % of fragments that are actually required.
    cumulative_fragment_sizes = cumsum(fragment_sizes);
    % Variable "maximum_index" stores the actual number of fragments that 
    % are required.
    maximum_index = find(cumulative_fragment_sizes >= nucleodite_length,1);
    % Check whether the total fragment size of the randomly generated
    % sequence of fragment sizes exceeds the length of the nucleodite
    % sequence.
    fragment_size_difference = cumulative_fragment_sizes(maximum_index) - nucleodite_length;
    % If the fragment_size_difference is greater than zero then the
    % contents of fragment_sizes vector must be modified accordingly.
    if(fragment_size_difference > 0)
        % If the remaining fragment size at the last position in the
        % correspoding vector is greater than FSmin then the resulting
        % action is to reduce the fragment size accordingly. Otherwise, the
        % fragment size contents of the last position in the corresponding
        % vector will not be used and the additional fragment size will be 
        % incorporated by the first available index within the fragment_sizes
        % vector. Morover, the maximum_index will be reduced by 1 since the
        % fragment size contents of the last position will not be used.
        if(fragment_sizes(maximum_index)-fragment_size_difference >= FSmin)
            fragment_sizes(maximum_index) = fragment_sizes(maximum_index) - fragment_size_difference;
        else
            remaining_fragment_size = fragment_sizes(maximum_index) - fragment_size_difference;
            maximum_index = maximum_index - 1;
            increment_index = find(fragment_sizes+remaining_fragment_size<=FSmax,1);
            fragment_sizes(increment_index) = fragment_sizes(increment_index) + remaining_fragment_size;
        end;
    end;
    % Update fragment_sizes and cumulative_fragment_sizes.
    fragment_sizes = fragment_sizes(1:maximum_index);    
    cumulative_fragment_sizes = cumsum(fragment_sizes);
    
    % Get the actual number of fragments.
    fragments_number = length(fragment_sizes);
    
    % Loop throught the various fragment sizes.
    for internal_fragment_index = 1:1:fragments_number
        % Include current internal fragment with probability Pinc.
        include_fragment_flag = hardlim(Pinc-rand());
        if(include_fragment_flag)
            % Get the current fragment positions.
            first_position = cumulative_fragment_sizes(internal_fragment_index) - fragment_sizes(internal_fragment_index) + 1;
            last_position = cumulative_fragment_sizes(internal_fragment_index);
            fragment_positions = first_position:last_position;
            % Get current internal fragment.
            fragment = N(fragment_positions);
            % Update occurrence matrix.
            OccurrenceMatrix(copy_index,fragment_positions) = 1;
            % Update Fragments cell array.
            Fragments{fragment_index} = fragment;
            fragment_index = fragment_index + 1;
        end;
    end;
end;    
% Compute the actual coverage.
Coverage = mean(sum(OccurrenceMatrix));
    
end

