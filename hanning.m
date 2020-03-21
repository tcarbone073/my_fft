function [w] = hanning(n,plotHanning)
%
%
%
%
%
%

% comput ehanning window
w = .5*(1 - cos(2*pi*(1:n)'/(n+1)));

switch plotHanning
    case 0
    case 1
        
        % create figure window
        figure('Units','Inches','Position',[1 1 10 6]);
        
        % plot the data
        plot((1:n)',w);
        
        % Format axes
        grid on
        xlabel('Sample');
        ylabel('Amplitube');
        xlim([0 n])
        ylim([0 1])

end

end

