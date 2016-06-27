function [tempogram_fourier, tempogram_autocorrelation, T, BPM] = get_DataTempogram(filename)
    % 1., load wav file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [audio, Fs] = audioread(filename);

    % 2., compute novelty curve
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paraNovelty = [];
    [noveltyCurve, featureRate] = audio_to_noveltyCurve(audio, Fs, paraNovelty);

    % 3., compute tempogram
    %  Fourier-based:
    %       .tempoWindow: trade-off between time- and tempo resolution
    %                     try chosing a long (e.g., 12 sec) and short (e.g., 3 sec) 
    %                     window
    %               .BPM: tempo range and resolution

    %  Autocorrelation-based:
    %       .tempoWindow: trade-off between time- and tempo resolution
    %                     try chosing a long (e.g., 12 sec) and short (e.g., 3 sec) 
    %                     window
    %    .maxLag/.minLag: tempo range
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % Fourier-Tempogram's Y-axis is "BPM", so there is no need to re-scale
    paraTempogram = [];
    paraTempogram.featureRate = featureRate;
    paraTempogram.tempoWindow = 8;         % window length in sec
    paraTempogram.BPM = 10:1:1000; % tempo values
    [tempogram_fourier, T, BPM] = noveltyCurve_to_tempogram_via_DFT(noveltyCurve, paraTempogram);
    tempogram_fourier = normalizeFeature(tempogram_fourier, 2, 0.0001);

    % ACF-Tempogram's Y-axis is "Time-Lag", so it need to be re-scaled
    paraTempogram = [];
    paraTempogram.featureRate = featureRate;
    paraTempogram.tempoWindow = 8;         % window length in sec
    paraTempogram.maxLag = 6;   % corresponding to 10 bpm
    paraTempogram.minLag = 0.06; % corresponding to 1000 bpm
    [tempogram_autocorrelation_timeLag, T, timeLag] = noveltyCurve_to_tempogram_via_ACF(noveltyCurve, paraTempogram);
    tempogram_autocorrelation_timeLag = normalizeFeature(tempogram_autocorrelation_timeLag, 2, 0.0001);
    BPM_in = 60./timeLag;
    BPM_out = 10:1:1000;
    [tempogram_autocorrelation, BPM] = rescaleTempoAxis(tempogram_autocorrelation_timeLag, BPM_in, BPM_out);
    tempogram_autocorrelation = normalizeFeature(tempogram_autocorrelation, 2, 0.0001);
end