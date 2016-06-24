function [] = plot_dic(W, islog)
    % PLOT Dictionary
    figure;
    if islog; imagesc(log(1+100*W));
    else imagesc(W); end;
    title('Dictionary W');
    ylabel('Frequency');
    xlabel('Dictionary Column Index');
    set(gca, 'YDir', 'normal');
end