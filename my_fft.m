% front matter
clc;
clear;
close all;

% get mp3 data from file
[t.sec,amplitude] = read_mp3();

% plot the raw amplitude data
plot_data(t.sec,amplitude)

% compute the hannig window of the data
