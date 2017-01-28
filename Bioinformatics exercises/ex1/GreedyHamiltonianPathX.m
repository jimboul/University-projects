function [P,W] = GreedyHamiltonianPath(Woverlap)

% This function computes a Hamiltonian Path for the graph identified by the
% the given weight matrix Woverlap through the utilization of greedy search
% algorithm.

% Get the number of nodes.
nodes_num = size(Woverlap,1);
% Initialize the vector storing the unvisited nodes so far.
unvisited_nodes = 1:1:nodes_num;
% Determine the edge with the maximum associated overlap weight.
max_weight = max(max(Woverlap));
% Initialize path weight.
W = max_weight;
% Determine the nodes that are being connected with the maximum edge
% weight.
[i_max,j_max] = find(Woverlap==max_weight,1);
% Initialize the hamiltonian path.
P = [i_max,j_max];
% Update vector of unvisited nodes.
unvisited_nodes = setdiff(unvisited_nodes,P);
% While there exist unvisited nodes:
while(~isempty(unvisited_nodes))
    current_node = P(end);
    unvisited_nodes_weights = Woverlap(current_node,unvisited_nodes); 
    [max_weight,j_max] = max(unvisited_nodes_weights);
    next_node = unvisited_nodes(j_max);
    P = [P,next_node];
    W = W + max_weight;
    unvisited_nodes =setdiff(unvisited_nodes,next_node);
end;

end

