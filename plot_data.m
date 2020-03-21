function plot_data(t,data)
%
%
%
%

% create figure window
figure('Units','Inches','Position',[1 1 10 6]);

% plot the data
plot(t,data);

% Format axes
grid on
xlabel('Time (seconds)');
ylabel('Amplitube');
xlim([0 60])
ylim([-2 2])


end

