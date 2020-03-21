% front matter
clc;
clear;
close all;

% ----------------------------------
% set iputs
% ----------------------------------
resol = 0.25;
overlap = 0.50;

% get mp3 data from file
[t.sec,amplitude,Fs] = read_mp3();
num_samples = size(amplitude,1);

% plot the amplitude data in time domain
% plot_data(t.sec,amplitude)

% block size
block_size.num_samples = round(Fs/resol); % number of samples per 1 block
block_size.t_sec       = round(1/resol);  % legnth of 1 block

% number of blocks
num_blocks = floor((num_samples - block_size.num_samples) / ((1-overlap) * block_size.num_samples) + 1);

% compute the number of lines for the fft
Fm = Fs / 2.56;
num_lines = Fm / resol + 1; % +1 to add zero Hz

% compute the hannig window
w = hanning(block_size.num_samples,0);

for i = 1:num_blocks
    
    % get the indices of the current block
    current_block   = round((1:block_size.num_samples) + (i-1)*block_size.num_samples * (1-overlap))';
    
    % compute the windowed block os data
    current_windowed_samples = w.*amplitude(current_block,1);
    
    % plot the data, current block of data, and windowed current block of data
    if i == 5 % plot one as example
        plot_data_subplot(t.sec,...
            amplitude(:,1),...
            t.sec(current_block),...
            amplitude(current_block,1),...
            current_windowed_samples,...
            i,...
            num_blocks);
    end
    
    %     
    
end


