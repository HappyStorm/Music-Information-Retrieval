function [] = plot_reorigin(W, H, s)
    % PLOT RECONSTRUCTION VS. ORIGINAL
    figure;
    subplot(2, 1, 1)
    imagesc(db(s))
    set(gca,'YDir','normal')
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    title('Original')
    ylabel('Frequency')
    xlabel('Time')

    subplot(2, 1, 2)
    imagesc(db(W*H))
    set(gca,'YDir','normal')
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    title('Reconstruction')
    ylabel('Frequency')
    xlabel('Time')
end