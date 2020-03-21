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

% block size
block_size.num_samples = round(Fs/resol); % number of samples per 1 block
block_size.t_sec       = round(1/resol);  % legnth of 1 block

% number of blocks
num_blocks = floor((num_samples - block_size.num_samples) / ((1-overlap) * block_size.num_samples) + 1);

% compute the number of lines for the fft
Fm = Fs / 2.56;
num_lines = floor(Fm / resol) + 1; % +1 to add zero Hz
f_vec = (1:num_lines)'.*resol;

% compute the hannig window
w = hanning(block_size.num_samples,0);

auto_spectra = zeros(size(f_vec,1),1);
for i = 1:num_blocks
    
    % get the indices of the current block
    current_block   = round((1:block_size.num_samples) + (i-1)*block_size.num_samples * (1-overlap))';
    
    % compute the windowed block os data
    current_windowed_samples = w.*amplitude(current_block,1);
    
    % plot the data, current block of data, and windowed current block of data
    if i == 5 % block 5 as example
        plot_data_subplot(t.sec,...
            amplitude(:,1),...
            t.sec(current_block),...
            amplitude(current_block,1),...
            current_windowed_samples,...
            i,...
            num_blocks);
    end
    
    % compute the n-point fft
    y1 = fft(current_windowed_samples);
    p2 = abs(y1);
    p1 = p2(1:num_lines)*2; % multiply by 2 to conserve power
    
   
    auto_spectra = auto_spectra + p1;
    
end

% compute auto spectra
auto_spectra = auto_spectra / num_blocks;

% plot autospectra
plot_data(f_vec,auto_spectra,'Freqyency (Hz)','Power',[0 500],[]);