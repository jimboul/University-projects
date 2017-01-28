function [S] = ShortestCommonSuperstring(Fragments,Soverlap,P)

% This function extracts the shortest common supersting (S) corresponding
% to the Hamiltonian path stored in vector P. The rest of the input
% variables correspond to the cell array of fragments and their
% pairwise overlaps. Fragments is assumed to be the purified version of
% Fragments after removing strings that are sub-strings of other fragments.

% Get the number of nodes pertaining to the Hamiltonian path, which is also
% the number of nodes within the overalp graph.
nodes_num = length(P);
% Initialize the shortest common superstring S.
S = Fragments{P(1)};
% Incrementally build the shortest common super string by processing path
% nodes from the second to the last.
for n = 2:1:nodes_num
    current_node = P(n);
    previous_node = P(n-1);
    current_overlap = Soverlap{previous_node,current_node};
    Loverlap = length(current_overlap);
    S(end-Loverlap+1:1:end) = '';
    S = strcat(S,Fragments{current_node});
end;

end

