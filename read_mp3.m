function [t_vec,sampled_data,Fs] = read_mp3()
%
%
%
%
%

% get sample rate and sample frequency
[sampled_data,Fs] = audioread('sample_noise.mp3');

% compute t
t_total = size(sampled_data,1) / Fs;
t_step  = t_total / size(sampled_data,1);
t_vec   = (t_step:t_step:t_total)';

end

