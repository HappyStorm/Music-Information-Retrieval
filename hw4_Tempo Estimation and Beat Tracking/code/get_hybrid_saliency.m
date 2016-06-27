function saliency = get_hybrid_saliency(tempogram_dft, tempogram_acf,...
                                        multiples, min_constraint, max_constraint)                            
    % Fourier-Tempogram
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % generate abs tempogram and avg tempogram, initial T1 T2
    tempogram_abs_dft = abs(tempogram_dft);
    tempogram_avg_dft = sum(tempogram_abs_dft, 2) / size(tempogram_abs_dft, 2);
    T1_bpm_dft = 0 ; T1_val_dft = 0; T2_bpm_dft = 0 ; T2_val_dft = 0;

    % fit the tempogram index ranges from 10 ~ 1000 and the requirement of hw
    % 40 / 4 = 10, 250 * 4 = 1000
    [T1_val_dft, T1_bpm_dft] = max(tempogram_avg_dft(min_constraint : max_constraint + 740));
    tempo(1) = T1_bpm_dft + 10 + 40;

    % iterate candidate to chose best T2
    candidate = [1/3 1/2 2 3];
    for i = 1 : length(candidate)
        pred_bpm = tempo(1) * candidate(i);
        if(ceil(pred_bpm) <= min_constraint+5  || ceil(pred_bpm) >= max_constraint + 740)
            continue; end
        if(tempogram_avg_dft(ceil(pred_bpm - 10)) > T2_val_dft)
            T2_bpm_dft = ceil(pred_bpm - 10);
            T2_val_dft = tempogram_avg_dft(T2_bpm_dft);
        end
    end
    tempo(2) = T2_bpm_dft + 10;
    if(T1_bpm_dft > T2_bpm_dft), tempo([1 2])= tempo([2 1]); end


    tempo = ceil(tempo .* multiples);
    tempo(tempo > max_constraint) = max_constraint;
    T1_val_dft = tempogram_avg_dft((tempo(1) - 10));
    % T2_val_dft = tempogram_avg_dft((tempo(2) - 10));


    % Autocorrelation-Tempogram
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % generate abs tempogram and avg tempogram, initial T1 T2
    tempogram_abs_acf = abs(tempogram_acf);
    tempogram_avg_acf = sum(tempogram_abs_acf, 2) / size(tempogram_abs_acf, 2);
    T1_bpm_acf = 0 ; T1_val_acf = 0; T2_bpm_acf = 0 ; T2_val_acf = 0;

    % fit the tempogram index ranges from 10 ~ 1000 and the requirement of hw
    % 40 / 4 = 10, 250 * 4 = 1000
    [T1_val_acf, T1_bpm_acf] = max(tempogram_avg_acf(min_constraint : max_constraint));
    tempo(1) = T1_bpm_acf + 10 + 40;

    % iterate candidate to chose best T2
    candidate = [1/3 1/2 2 3];
    for i = 1 : length(candidate)
        pred_bpm = tempo(1) * candidate(i);
        if(ceil(pred_bpm) <= min_constraint+5 || ceil(pred_bpm) >= max_constraint)
            continue; end
        if(tempogram_avg_acf(ceil(pred_bpm - 10)) > T2_val_acf)
            T2_bpm_acf = ceil(pred_bpm - 10);
            T2_val_acf = tempogram_avg_acf(T2_bpm_acf);
        end
    end
    tempo(2) = T2_bpm_acf + 10;
    if(T1_bpm_acf > T2_bpm_acf), tempo([1 2])= tempo([2 1]); end
    tempo(tempo > max_constraint) = max_constraint;

    tempo = ceil(tempo .* multiples);
    % T1_val_acf = tempogram_avg_acf((tempo(1) - 10));
    T2_val_acf = tempogram_avg_acf((tempo(2) - 10));

    % compute Hybrid Relative Saliency
    saliency = T1_val_dft / ( T1_val_dft + T2_val_acf);
    if(isnan(saliency)), saliency = 0; end
end