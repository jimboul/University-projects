function [Soverlap] = Overlap(Sa,Sb,p_value)

% This function returns the overlap between the input strings Sa and Sb.
% Soverlap is defined as the longest suffix of Sa that is also a prefix of
% Sb.

% Get input strings lengths.
Na = length(Sa);
Nb = length(Sb);
% Get mininum length.
Nmin = min(Na,Nb);
% Initialize the overlap string length.
Noverlap = 0;
% Set up an overlap searching loop.
for k = 0:1:Nmin-1
    suffix = Sa(end-k:1:end);
    prefix = Sb(1:1:1+k);
    if(strcmp(suffix,prefix))
        Noverlap = k+logical(p_value);
    end;
end;
Soverlap = Sa(end-Noverlap+1:1:end);
%fprintf('%d\n',p_value);
end

