function [T_VEC,SAMPLED_DATA,N_SAMPLES,FS] = read_mp3(FILENAME)
%Read audio file.
%
%   FUNCTION
%       [T_VEC,SAMPLED_DATA,N_SAMPLES,FS] = read_mp3(FILENAME)
%
%   INPUT PARAMETERS
%       FILENAME        name of file to read from
%
%   OUTPUT PARAMETERS
%       T_VEC           n-by-1 array of time data
%       SAMPLED_DATa    n-by-2 array of sampled date (one col for each channel)
%       N_SAMPLES       1-by-1 total number of samples
%       FS              1-by-1 sample rate
%
%   EXAMPLES
%
%
%   NOTES
%
%

% MATLAB builtin 'audioread' returns the sampled data and the sample rate (Hz)
[SAMPLED_DATA,FS] = audioread(FILENAME);

% the total time (in sec.) of the sampled data is the total # of samples divided by the sample rate
N_SAMPLES = size(SAMPLED_DATA,1);
t_total = N_SAMPLES / FS;

% the resolution of the time data (in sec.) is the total time divided by the # of samples
t_step = t_total / N_SAMPLES;

% the vector of discrete time data points is a range from the first time point to the total length,
% stepping by the resolution
T_VEC = (t_step:t_step:t_total)';

end

