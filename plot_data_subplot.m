function plot_data_subplot(t_data,data,t_block,block_data,windowed_block_data,i,num_blocks)
%
%
%
%
%

% create figure window
figure('Units','Inches','Position',[1 1 10 6]);

% ----------------------------------
% plot the raw data
% ----------------------------------
subplot(2,2,1)
plot(t_data,data);

% Format axes
grid on
xlabel('Time (seconds)');
ylabel('Amplitube');
xlim([0 60])
ylim([-2 2])
title('Figure 1: Time Data')

% ----------------------------------
% plot the block of data
% ----------------------------------
subplot(2,2,2)
plot(t_block,block_data);

% Format axes
grid on
xlabel('Time (seconds)');
ylabel('Amplitube');
xlim([0 60])
ylim([-2 2])


% add title
title_char = ['Figure 2: Time Data Block ' num2str(i) ' of ' num2str(num_blocks)];
title(title_char)

% ----------------------------------
% plot the windowed block of data
% ----------------------------------
subplot(2,2,3)
plot(t_block,windowed_block_data);

% Format axes
grid on
xlabel('Time (seconds)');
ylabel('Amplitube');
xlim([0 60])
ylim([0 1])

% add title
title_char = ['Figure 3: Windowed Time Data Block ' num2str(i) ' of ' num2str(num_blocks)];
title(title_char)

% ----------------------------------
% zoom in on the windowed block of data
% ----------------------------------
subplot(2,2,4)
plot(t_block,windowed_block_data);

% Format axes
grid on
xlabel('Time (seconds)');
ylabel('Amplitube');
xlim([min(t_block) max(t_block)])
ylim([0 1])

% add title
title_char = ['Figure 4: Windowed Time Data Block ' num2str(i) ' of ' num2str(num_blocks) ' (Zoomed)'];
title(title_char)
end

