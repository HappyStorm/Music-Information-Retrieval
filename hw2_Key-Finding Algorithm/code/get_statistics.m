function [sta_bi_q1, sta_bi_q3, sta_ks_q1, sta_ks_q3] = get_statistics(Genres, accuracy_bi, accuracy_ks)
    sta_bi_q1 = table(Genres', accuracy_bi{1, 1}(1, :)', accuracy_bi{1, 1}(2, :)',...
                            accuracy_bi{1, 1}(3, :)', accuracy_bi{1, 1}(4, :)');                  
    sta_bi_q1.Properties.VariableNames{'Var1'} = 'Genres';
    sta_bi_q1.Properties.VariableNames{'Var2'} = 'Q1_Binary_Gamma_1';
    sta_bi_q1.Properties.VariableNames{'Var3'} = 'Q1_Binary_Gamma_10';
    sta_bi_q1.Properties.VariableNames{'Var4'} = 'Q1_Binary_Gamma_100';
    sta_bi_q1.Properties.VariableNames{'Var5'} = 'Q1_Binary_Gamma_1000';

    sta_bi_q3 = table(Genres', accuracy_bi{2, 1}(1, :)', accuracy_bi{2, 1}(2, :)',...
                            accuracy_bi{2, 1}(3, :)', accuracy_bi{2, 1}(4, :)');                   
    sta_bi_q3.Properties.VariableNames{'Var1'} = 'Genres';
    sta_bi_q3.Properties.VariableNames{'Var2'} = 'Q3_Binary_Gamma_1';
    sta_bi_q3.Properties.VariableNames{'Var3'} = 'Q3_Binary_Gamma_10';
    sta_bi_q3.Properties.VariableNames{'Var4'} = 'Q3_Binary_Gamma_100';
    sta_bi_q3.Properties.VariableNames{'Var5'} = 'Q3_Binary_Gamma_1000';

    sta_ks_q1 = table(Genres', accuracy_ks{1, 1}(1, :)', accuracy_ks{1, 1}(2, :)',...
                            accuracy_ks{1, 1}(3, :)', accuracy_ks{1, 1}(4, :)');
    sta_ks_q1.Properties.VariableNames{'Var1'} = 'Genres';
    sta_ks_q1.Properties.VariableNames{'Var2'} = 'Q1_KSalgo_Gamma_1';
    sta_ks_q1.Properties.VariableNames{'Var3'} = 'Q1_KSalgo_Gamma_10';
    sta_ks_q1.Properties.VariableNames{'Var4'} = 'Q1_KSalgo_Gamma_100';
    sta_ks_q1.Properties.VariableNames{'Var5'} = 'Q1_KSalgo_Gamma_1000';

    sta_ks_q3 = table(Genres', accuracy_ks{2, 1}(1, :)', accuracy_ks{2, 1}(2, :)',...
                            accuracy_ks{2, 1}(3, :)', accuracy_ks{2, 1}(4, :)');
    sta_ks_q3.Properties.VariableNames{'Var1'} = 'Genres';
    sta_ks_q3.Properties.VariableNames{'Var2'} = 'Q3_KSalgo_Gamma_1';
    sta_ks_q3.Properties.VariableNames{'Var3'} = 'Q3_KSalgo_Gamma_10';
    sta_ks_q3.Properties.VariableNames{'Var4'} = 'Q3_KSalgo_Gamma_100';
    sta_ks_q3.Properties.VariableNames{'Var5'} = 'Q3_KSalgo_Gamma_1000';
end