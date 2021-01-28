function fft_data = my_fft(FILENAME,N_BLOCKS,OVERLAP,WIN_TYPE,IFPLOT1,IFPLOT2)

% https://www.sjsu.edu/people/burford.furman/docs/me120/FFT_tutorial_NI.pdf

% set iputs
resol = 0.25;
if isempty(OVERLAP)
    overlap = 0.50;
else
    overlap = OVERLAP;
end

% get mp3 data from file
%  units of amplitude are 'relative fraction of max amplitude', scaled between -1 and 1
if contains(FILENAME,'.xlsx')
    t_vec = xlsread(FILENAME,'Sheet1','F2:F10002');
    amplitude = xlsread(FILENAME,'Sheet1','G2:G10002');
    n_samples = length(t_vec);
    Fs = 1/(t_vec(2)-t_vec(1));
else
    [t_vec, amplitude, n_samples, Fs] = read_mp3(FILENAME);
end

% the duration of a block is 1/resol
t_per_block = round(1/resol);

% correspondingly, the # of sample in the block is its duration multiplied by the sample rate
n_samples_per_block = round(t_per_block*Fs);

% calculating the number of blocks is actually a little bit complicated, but this is the total number of
% blocks that can be made from given samples
if isempty(N_BLOCKS)
    n_blocks = floor((n_samples - n_samples_per_block) / ((1-overlap) * n_samples_per_block) + 1);
else
    n_blocks = N_BLOCKS;
end

% the maximum frequency that we can analyze is the sample rate divided by 2.56 (nyquist sampling theory)
Fm = Fs / 2.56;

% the number of fft lines is equal to the max frequency we can analyze divided by the resolution
% pad with one addional line to account for data at 0 Hz
n_lines = floor(Fm / resol) + 1;

% frequency rector is the vector of fft lines multiplied by the resolution
f_vec = (1:n_lines)'.*resol;

% compute the window
if isempty(WIN_TYPE)
    w_vec = make_window(n_samples_per_block,'hanning',false);
else
    w_vec = make_window(n_samples_per_block,WIN_TYPE,false);
end

auto_spectra = zeros(size(f_vec,1),1);
for i = 1:n_blocks
    
    % i_block is a vector of indicies corresponding to a slice of length 'n_samples_per_block' of the entire
    % sampled data range corresponding to the current iterating block
    i_block = round((1:n_samples_per_block) + (i-1)*n_samples_per_block * (1-overlap))';
    
    % compute the windowed block of data
    i_windowed_samples = w_vec.*amplitude(i_block,1);
       
    % compute the n-point fft
    % this is a two-sided spectrum in complex form
    y1 = fft(i_windowed_samples);
    
    % compute the magnitude of the complex y1
    p2 = abs(y1);
    
    % the fft is a summation of sine waves. to normalize the coefficients, we need to divide by the
    % integration time, which normalizes the energy
    p2 = p2./n_samples_per_block;
    
    % the two-sided power spectrum, 'p2', is symmetric. the first half of the array corresponds to the
    % positive frequency data, and the 2nd half of the array is the negative frequency data. we don't
    % care about the negative frequency data, so we take a slice of just the first half. but, we need to
    % conserve power, so we multiply the remaining positive frequency data by 2.
    p1 = p2(1:n_lines)*4;
    
    
    auto_spectra = auto_spectra + p1;
    
    % plot the data, current block of data, and windowed current block of data
    if IFPLOT1
        if i == 5
            plot_data_subplot(t_vec,...
                amplitude(:,1),...
                t_vec(i_block),...
                amplitude(i_block,1),...
                i_windowed_samples,...
                i,...
                n_blocks);
        end
    end
end

% compute auto spectra
auto_spectra = auto_spectra / n_blocks;

% plot autospectra
if IFPLOT2
    plot_data(f_vec(2:end),auto_spectra(2:end),'Frequency (Hz)','Power',[0 800],[]);
end

% compile into struct
fft_data.filename = FILENAME;
fft_data.timeseries_t_vec = t_vec;
fft_data.timeseries_amp = amplitude;
fft_data.timeseries_n_samples = n_samples;
fft_data.timeseries_Fs = Fs;
fft_data.block_overlap = overlap;
fft_data.block_t = t_per_block;
fft_data.block_n_samples = n_samples_per_block;
fft_data.block_total = n_blocks;
fft_data.spec_resol = resol;
fft_data.spec_Fm = Fm;
fft_data.spec_f_vec = f_vec;

end

