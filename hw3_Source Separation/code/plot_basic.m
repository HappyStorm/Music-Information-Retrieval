function [] = plot_basic(W, K, fs, nfft)
    % PLOT BASIS Vectors
    freq = linspace(0, fs/2, nfft/2+1);
    % time = linspace(0, length(vio_64)/fs, size(s, 2));
    % color = ['r','g','b',''];
    figure;
    for i = 1 : K
        plot((i-1) * max(max(W)) + (1-W(:, i)), freq, 'LineWidth', 3)
        hold on
    end
    title('Basis Vectors')
    ylabel('Frequency (Hz)')
    xlabel('Basis')
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
end