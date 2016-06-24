function [] = plot_template(file, s, fs, V, W, H, K, h)
    [~, fn, ~] = fileparts(file);
    fn = strrep(fn, '_', '\_');
    filename = fullfile([fn '.wav']);

    figure;
    phi = angle(s);
    for i = 1 : K
        Mask = (W(:, i) * H(i, :)) ./ (W*H);
        XmagHat = V .* Mask;
    %     XmagHat = W(:, i) * H(i, :);
        xhat(:, i) = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
        subplot(3, 1, i);
        plot([1:length(xhat(:, i))] / fs, xhat(:, i));
        set(gca, 'YDir', 'Normal');
        xlabel('Time (secs)');
        ylabel('Amplitude (m)');
        title(strcat(filename, sprintf('  -  Template %d', i)));
    end
end