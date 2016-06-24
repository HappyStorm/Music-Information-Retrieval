function [a] = inv_spectrogram(b, hop)
    % 
    % Note:
    %     This matlab file is modified from the "invmyspectrogram.m", which
    %     is published from:
    %       ``Spectral Audio Signal Processing'', by Julius O. Smith III, 
    %       W3K Publishing, 2011, ISBN 978-0-9745607-3-1.
    % Copyright ? 2016-06-07 by Julius O. Smith III
    % Center for Computer Research in Music and Acoustics (CCRMA), Stanford University

    %   inv_spectrogram Resynthesize a signal from its spectrogram.
    %   a: inv_spectrogram(b, hop)
    %   b: complex array of STFT values
    %   hop: the overlap-add offset between successive IFFT frames.
    %   The number of rows of b is taken to be the FFT size, NFFT.
    %   inv_spectrogram resynthesizes a by inverting each frame of the
    %   FFT in b, and overlap-adding them to the output array a.

    [nfft, nframes] = size(b);
    nfft = nfft * 2 - 2; % fake 2 * b size

    No2 = nfft / 2; % nfft assumed even
    a = zeros(1, nfft + (nframes - 1) * hop);
    xoff = 0 - No2; % output time offset = half of FFT size
    for col = 1 : nframes
        fftframe = b(:, col);
        fftframe = [fftframe; conj(fftframe(end-1:-1:2))];
        xzp = ifft(fftframe);
        % xzp = real(xzp); % if signal known to be real
        x = [xzp(nfft-No2+1:nfft); xzp(1:No2)];
        if xoff < 0 % FFT's "negative-time indices" are out of range
            ix = 1 : xoff+nfft;
            a(ix) = a(ix) + x(1-xoff:nfft)'; % partial frames out
        else
            ix = xoff+1 : xoff+nfft;
            a(ix) = a(ix) + x';  % overlap-add reconstruction
        end
        xoff = xoff + hop;
    end
end
