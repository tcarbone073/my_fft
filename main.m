clc;
clear;
close all;

% filename, n_blocks, overlap, win_type, if_plot_subplot, if_plot_autospectra
fft_data = my_fft('sample_noise2.mp3',[],[],[],false,true)
;
