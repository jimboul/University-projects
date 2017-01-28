function bel = BSAS(X,theta,q)
% Basic Sequential Algorithmic Scheme (BSAS)

%   Summary of this function goes here
%   Detailed explanation goes here

N = size(X,1);
nFeatures = size(X,2); 

labels = zeros(1,N); % zero means the point is not yet labeled 

m = 1;
labels(1) = 1; 
for ii = 2:N, 
  % find C_k : d(x_ii,C_k) = min_{1 <= j <= m} d(x_ii,C_j)
  %
  [ d_x_i_C_k, k ] = findClosestCluster( ii, labels, X ); 

  if( (d_x_i_C_k > theta) && (m<q) )
    m = m+1;
  end
  labels(ii) = m;
end

bel = labels; 

end

