function rep = getClusterRepresentative(inds, X)

rep = mean( X(inds,:), 1 )';

end