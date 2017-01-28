function [Soverlap,Woverlap] = OverlapWeightMatrix(Fragments,p_value)

% This function constructs the overlap weight matrix for a given set of
% preprocessed fragments.

L = length(Fragments);
Soverlap = cell(L,L);
Woverlap = zeros(L,L);
for i = 1:1:L
    Fi = Fragments{i};
    for j = 1:1:L
        Fj = Fragments{j};
        if(i==j)
            Soverlap{i,j} = char.empty(1,0);
        else
            Soverlap{i,j} = Overlap(Fi,Fj,p_value);
        end;
        Woverlap(i,j) = length(Soverlap{i,j});
    end;
end;

end