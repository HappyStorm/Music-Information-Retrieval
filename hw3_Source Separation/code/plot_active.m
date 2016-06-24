function [] = plot_active(H, islog)
    % PLOT Dictionary
    figure;
    if islog; imagesc(log(1+100*H));
    else imagesc(H); end;
    title('Activity Matrix H');
    ylabel('Dictionary Column Index');
    xlabel('Time (s)');
    set(gca, 'YDir', 'normal');
end