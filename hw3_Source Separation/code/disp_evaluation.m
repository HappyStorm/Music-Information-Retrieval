function [] = disp_evaluation(MixFiles, ClaSDRs, ClaSIRs, ClaSARs, VioSDRs, VioSIRs, VioSARs)
    Mixtable = table(MixFiles', ClaSDRs(1, :)', VioSDRs(1, :)',...
                                ClaSIRs(1, :)', VioSIRs(1, :)',...
                                ClaSARs(1, :)', VioSARs(1, :)');
    Mixtable.Properties.VariableNames{'Var1'} = 'MixFileName';
    Mixtable.Properties.VariableNames{'Var2'} = 'SDR_ClaEst_Cla';
    Mixtable.Properties.VariableNames{'Var3'} = 'SDR_VioEst_Vio';
    Mixtable.Properties.VariableNames{'Var4'} = 'SIR_ClaEst_Vio';
    Mixtable.Properties.VariableNames{'Var5'} = 'SIR_VioEst_Cla';
    Mixtable.Properties.VariableNames{'Var6'} = 'SAR_ClaEst_Cla';
    Mixtable.Properties.VariableNames{'Var7'} = 'SAR_VioEst_Vio';
    disp(Mixtable);
end