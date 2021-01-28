function [WIN_VEC] = make_window(N_SAMPLES,WIN_TYPE,PLOT_BOOL)
%Return n-point window of samples.
%
%   FUNCTION
%       [WIN_VEC] = make_window(N_SAMPLES,WIN_TYPE,PLOT_BOOL)
%
%   INPUT PARAMETERS
%       N_SAMPLES       1-by-1 number of samples
%       WIN_TYPE        char denoting window type
%                       options are: 'hanning', 'hamming', 'flattop', 'none'
%       PLOT_BOOL       boolean for plotting the window function
%
%   OUTPUT PARAMETERS
%       WIN_VEC         N_SAMPLES-by-1 n-point window array
%
%   EXAMPLES
%
%
%   NOTES
%
%

% compute the window
switch WIN_TYPE
    case 'hanning'
        WIN_VEC = .5*(1 - cos(2*pi*(1:N_SAMPLES)'/(N_SAMPLES+1)));
        fig_title = 'N-Point Hanning Window';
        
    case 'hamming'
        WIN_VEC = 0.54 - 0.46*cos(2*pi*(1:N_SAMPLES)'/(N_SAMPLES+1));
        fig_title = 'N-Point Hamming Window';
        
    case 'flattop'
        WIN_VEC = 0.21557895 ...
            - 0.41663158*cos(2*pi*(1:N_SAMPLES)'/(N_SAMPLES+1))...
            + 0.277263158 * cos(4*pi*(1:N_SAMPLES)'/(N_SAMPLES+1))...
            - 0.083578947 * cos(6*pi*(1:N_SAMPLES)'/(N_SAMPLES+1))...
            + 0.006947368 * cos(8*pi*(1:N_SAMPLES)'/(N_SAMPLES+1));
        fig_title = 'N-Point Flattop Window';
        
    case 'none'
        WIN_VEC = ones(N_SAMPLES,1);
        fig_title = 'No Window';
        
end

if PLOT_BOOL
    % create figure window
    figure('Units','Inches','Position',[1 1 10 6]);
    
    % plot the data
    plot((1:N_SAMPLES)',WIN_VEC);
    
    % Format axes
    grid on
    title(fig_title)
    xlabel('Sample');
    ylabel('Amplitube');
    xlim([0 N_SAMPLES])
    ylim([-0.25 1])
end

end

