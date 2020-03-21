function [w] = hanning(n)
%
%
%
%
%
%

% comput ehanning window
w = .5*(1 - cos(2*pi*(1:n)'/(n+1)));

end

