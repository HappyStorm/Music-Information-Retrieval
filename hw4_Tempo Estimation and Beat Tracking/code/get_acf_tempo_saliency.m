function [tempo, saliency] = get_acf_tempo_saliency(tempogram, multiples,...
                                            min_constraint, max_constraint)
    % generate abs tempogram and avg tempogram, initial T1 T2
    tempogram_abs = abs(tempogram);
    tempogram_avg = sum(tempogram_abs, 2) / size(tempogram_abs, 2);
    T1_bpm = 0 ; T1_val = 0; T2_bpm = 0 ; T2_val = 0;

    % fit the tempogram index ranges from 10 ~ 1000 and the requirement of hw
    % 40 / 4 = 10, 250 * 4 = 1000
    [T1_val, T1_bpm] = max(tempogram_avg(min_constraint : max_constraint));
    tempo(1) = T1_bpm + 10 + 40;

    % iterate candidate to chose best T2
    candidate = [1/3 1/2 2 3];
    for i = 1 : length(candidate)
        pred_bpm = tempo(1) * candidate(i);
        if(ceil(pred_bpm) <= min_constraint+5 || ceil(pred_bpm) >= max_constraint)
            continue; end
        if(tempogram_avg(ceil(pred_bpm - 10)) > T2_val)
            T2_bpm = ceil(pred_bpm - 10);
            T2_val = tempogram_avg(T2_bpm);
        end
    end
    tempo(2) = T2_bpm + 10;
    if(T1_bpm > T2_bpm), tempo([1 2])= tempo([2 1]); end
    tempo(tempo > max_constraint) = max_constraint;

    tempo = ceil(tempo .* multiples);
    T1_val = tempogram_avg((tempo(1) - 10));
    T2_val = tempogram_avg((tempo(2) - 10));

    % compute Relative Saliency
    saliency = T1_val / ( T1_val + T2_val);
    if(isnan(saliency)), saliency = 0; end
end
