function [BG] = CreateBiograph(Fragments,Woverlap,Soverlap)

% This function creates the Biograph object corresponding to set of nodes /
% fragments contained within the cell array of strings 
% (necleodite sequences) Fragments. The graph weight matrix is stored within 
% the input argument Woverlap while the actual overlap string between
% fragments i and j is stored within the Soverlap{i,j} of the input
% arguments storing pairwise overlaping strings.
% Mind that the cell array Fragments is assummed to be cleaned from
% fragments that are completely contained within other fragments.

% Get the number of graph nodes.
nodes_num = size(Woverlap,1);
% Create the biograph object.
BG = biograph(Woverlap,Fragments);
% Set the Layout and ShowWeights properties of the biograph object.
BG.LayoutType = 'equilibrium';
BG.ShowWeights = 'on';
% Initialize edge_index counter.
edge_index = 1;
% Add edge labels on the biograph object.
% Cycle through all non-zero weighted edges:
for i = 1:1:nodes_num
    for j = 1:1:nodes_num
        if(Woverlap(i,j)~=0)
            BG.edges(edge_index).Label = Soverlap{i,j};
            edge_index = edge_index + 1;
        end;
    end;
end;

% View graph.
view(BG);

end

