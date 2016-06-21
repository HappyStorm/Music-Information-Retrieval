function [score] = get_score(pred_pitch, true_pitch)
    score = 0;
    pff_pos = mod(true_pitch + 7, 24);
    pff_neg = mod(true_pitch - 7, 24);
    if true_pitch > 11
        pmm = true_pitch - 12;
        if true_pitch > 20
            rmm = true_pitch + 3 - 24;
        else
            rmm = true_pitch + 3 - 12;
        end
    else
       pmm = true_pitch + 12;
       if true_pitch < 3
           rmm = true_pitch - 3 + 24;
       else
           rmm = true_pitch - 3 + 12;
       end
    end
        
    if pred_pitch == true_pitch
        score = 1;
    elseif pred_pitch == pff_pos || pred_pitch == pff_neg
        score = 0.5;
    elseif pred_pitch == rmm
        score = 0.3;
    elseif pred_pitch == pmm
        score = 0.2;
    end
    
    if true_pitch == -1, score = 0; end
end