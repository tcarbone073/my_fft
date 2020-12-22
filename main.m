% https://www.sjsu.edu/people/burford.furman/docs/me120/FFT_tutorial_NI.pdf


% front matter
clc;
clear;
close all;

% set iputs
resol = 0.25;
overlap = 0.50;
filename = 'sample_noise.mp3';

% get mp3 data from file
%  units of amplitude are 'relative fraction of max amplitude', scaled between -1 and 1
[t.sec, amplitude, n_samples, Fs] = read_mp3(filename);

% the duration of a block is 1/resol
t_per_block = round(1/resol);

% correspondingly, the # of sample in the block is its duration multiplied by the sample rate
n_samples_per_block = round(t_per_block*Fs);

% calculating the number of blocks is actually a little bit complicated, but this is the total number of
% blocks that can be made from given samples
n_blocks = floor((n_samples - n_samples_per_block) / ((1-overlap) * n_samples_per_block) + 1);

% the maximum frequency that we can analyze is the sample rate divided by 2.56 (nyquist sampling theory)
Fm = Fs / 2.56;

% the number of fft lines is equal to the max frequency we can analyze divided by the resolution
% pad with one addional line to account for data at 0 Hz
n_lines = floor(Fm / resol) + 1;

% frequency rector is the vector of fft lines multiplied by the resolution
f_vec = (1:n_lines)'.*resol;

% compute the window
w_vec = make_window(n_samples_per_block,'hanning',false);

auto_spectra = zeros(size(f_vec,1),1);
for i = 1:n_blocks
    
    % i_block is a vector of indicies corresponding to a slice of length 'n_samples_per_block' of the entire
    % sampled data range corresponding to the current iterating block
    i_block = round((1:n_samples_per_block) + (i-1)*n_samples_per_block * (1-overlap))';
    
    % compute the windowed block of data
    i_windowed_samples = w_vec.*amplitude(i_block,1);
    
    % plot the data, current block of data, and windowed current block of data
    if i == 5 % block 5 as example
        plot_data_subplot(t.sec,...
            amplitude(:,1),...
            t.sec(i_block),...
            amplitude(i_block,1),...
            i_windowed_samples,...
            i,...
            n_blocks);
    end
    
    % compute the n-point fft
    % this is a two-sided spectrum in complex form
    y1 = fft(i_windowed_samples);
    
    % compute the magnitude of the complex y1
    p2 = abs(y1);
    
    % the two-sided power spectrum, 'p2', is symmetric. the first half of the array corresponds to the
    % positive frequency data, and the 2nd half of the array is the negative frequency data. we don't
    % care about the negative frequency data, so we take a slice of just the first half. but, we need to
    % conserve power, so we multiply the remaining positive frequency data by 2.
    p1 = p2(1:n_lines)*2;
    
   
    auto_spectra = auto_spectra + p1;
    
end

% compute auto spectra
auto_spectra = auto_spectra / n_blocks;

% plot autospectra
plot_data(f_vec,auto_spectra,'Frequency (Hz)','Power',[0 500],[]);