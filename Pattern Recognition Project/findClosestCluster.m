function [d_x_i_C_k , k] = findClosestCluster( ii, labels, X )
  
ulabels = unique(labels);

if( ulabels(1)==0 ) 
  ulabels = ulabels(2:end); % Drop the value of 0 which indicates this point has not been labeled
end

x_ii_to_cluster = []; % I have to preallocate it setting this matrix to zeros of its dimensions

for lab = ulabels,
  inds = find( labels==lab );
  rep  = getClusterRepresentative( inds, X ); 
  d = sqrt( ( X(ii,:)' - rep )' * ( X(ii,:)' - rep ) ); 
  x_ii_to_cluster = [ x_ii_to_cluster, d ]; 
end

[d_x_i_C_k,mind] = min(x_ii_to_cluster); 
k = ulabels(mind); % The cluster index to which x_i is closest 

end