function [sta_mir_q1, sta_mir_q3] = get_mir(Genres, accuracy_mir)
    sta_mir_q1 = table(Genres', accuracy_mir{1, 1}(1, :)');                  
    sta_mir_q1.Properties.VariableNames{'Var1'} = 'Genres';
    sta_mir_q1.Properties.VariableNames{'Var2'} = 'Q1_Mir';

    sta_mir_q3 = table(Genres', accuracy_mir{2, 1}(1, :)');                   
    sta_mir_q3.Properties.VariableNames{'Var1'} = 'Genres';
    sta_mir_q3.Properties.VariableNames{'Var2'} = 'Q3_Mir';
end