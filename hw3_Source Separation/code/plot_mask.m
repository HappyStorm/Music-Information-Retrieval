function [] = plot_mask(W, H, K)
    % PLOT MASKS
    figure;
    CLIP = 100;
    m = max(max(db(W*H)));
    for i = 1 : K
        subplot(K, 1, i)
        R = (max( db(W(:, i) * H(i, :) ./ (W*H)) - m, -CLIP) + CLIP)/CLIP;
        imagesc(R)
        set(gca,'YDir','normal')
        set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
        set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
        set(gca, 'YTick', []);
        set(gca, 'XTick', []);
        ylabel('Frequency')
        xlabel('Time')
        title(['Mask for Basis Vector ' int2str(i) ])
    end
end