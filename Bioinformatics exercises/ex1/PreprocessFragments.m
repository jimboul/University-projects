function [PreprocessedFragments] = PreprocessFragments(Fragments)

% This function takes as input a cell array of nucleodite fragments and  
% outputs the corresponding cell array of preprocessed fragments by  
% removing all nucleodite sub-sequencies that ara complete contained
% within larger fragments.

% Get the number of sequences within the fragments cell array.
L = length(Fragments);
% Initialize the new container for the pre-processed fragments.
PreprocessedFragments = cell(1,0);
% Set the current fragment index for storing the pre-processed fragments.
new_fragment_index = 1;
% Initialize the vector storing the indices to be removed.
removed_indices = [];
% For each nucleodite sequence check whether there is another sequence that
% completely contains it.
i_range = 1:1:L;
for i = i_range
    Fi = Fragments{i};
    remove_fragment = false;
    j_range = setdiff(i_range,i);
    j_range = setdiff(j_range,removed_indices);
    for j = j_range
        Fj = Fragments{j};
        if(strfind(Fj,Fi))
            remove_fragment = true;
            removed_indices = [removed_indices,i];
            break;
        end;
    end;
    if(~remove_fragment)
        PreprocessedFragments{new_fragment_index} = Fi;
        new_fragment_index = new_fragment_index + 1;
    end;
end;

end