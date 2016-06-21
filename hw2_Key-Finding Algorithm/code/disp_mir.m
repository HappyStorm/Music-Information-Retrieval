function [] = disp_mir(sta_mir_q1, sta_mir_q3, total_score_mir, total_size_mir)
    disp(sta_mir_q1);
    disp(sta_mir_q3);

    fprintf('Mir Overall Accuracy (Q1):\n');
    fprintf('\t%.3f %%\n\n', total_score_mir{1, 1} / total_size_mir{1, 1} * 100);

    fprintf('Mir Overall Accuracy (Q3):\n');
    fprintf('\t%.3f %%\n\n', total_score_mir{2, 1} / total_size_mir{2, 1} * 100);
end