function [] = plot_eu_kl(w, h, nfft, fs, xhat1, xhat2)
    [~, nmf_f1_EU, nmf_t1_EU] = stft(xhat1(:,1), w, h, nfft, fs);
    [~, nmf_f2_EU, nmf_t2_EU] = stft(xhat1(:,2), w, h, nfft, fs);
    [~, nmf_f3_EU, nmf_t3_EU] = stft(xhat1(:,3), w, h, nfft, fs);

    [~, nmf_f1_KL, nmf_t1_KL] = stft(xhat2(:,1), w, h, nfft, fs);
    [~, nmf_f2_KL, nmf_t2_KL] = stft(xhat2(:,2), w, h, nfft, fs);
    [~, nmf_f3_KL, nmf_t3_KL] = stft(xhat2(:,3), w, h, nfft, fs);

    figure;
    subplot(2, 3, 1), imagesc(nmf_t1_EU, nmf_f1_EU, mirgetdata(mirspectrum(mirframe(xhat1(:, 1) , 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')

    subplot(2, 3, 2), imagesc(nmf_t2_EU, nmf_f2_EU, mirgetdata(mirspectrum(mirframe(xhat1(:, 2), 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')

    subplot(2, 3, 3), imagesc(nmf_t3_EU, nmf_f3_EU, mirgetdata(mirspectrum(mirframe(xhat1(:, 3), 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')

    subplot(2, 3, 4), imagesc(nmf_t1_KL, nmf_f1_KL, mirgetdata(mirspectrum(mirframe(xhat2(:, 1) , 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')

    subplot(2, 3, 5), imagesc(nmf_t2_KL, nmf_f2_KL, mirgetdata(mirspectrum(mirframe(xhat2(:, 2), 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')

    subplot(2, 3, 6), imagesc(nmf_t3_KL, nmf_f3_KL, mirgetdata(mirspectrum(mirframe(xhat2(:, 3), 'Length', w, 'sp', 'Hop', h, 'sp'), 'dB')))
    set(gca, 'YDir', 'Normal')
    xlabel('Time (secs)')
    ylabel('Freq (Hz)')
    title('Short-time Fourier Transform spectrum')
end