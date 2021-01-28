function plot_data(t,data,x_label,y_label,x_lim,y_lim)
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
xlabel(x_label);
ylabel(y_label);
xlim(x_lim)

if ~isempty(y_lim)
    ylim(y_lim)
end


end

