%% Default Settings
% Cheng-Wei Wu 2016/5/26, 5/27
% Note. I already add the Chroma-Toolbox's path to my Matlab.
% Please remember to remove the Auditory-Toolbox from the path setting.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

PATH_DATA = './data1/BallroomData';
PATH_TRUTH = './data2/BallroomAnnotations';
listOfGroundTruth        = listfile(fullfile(PATH_TRUTH, 'ballroomGroundTruth'));
listOfChaChaCha          = listfile(fullfile(PATH_DATA, 'ChaChaCha'));
listOfJive               = listfile(fullfile(PATH_DATA, 'Jive'));
listOfNada               = listfile(fullfile(PATH_DATA, 'nada'));
listOfQuickstep          = listfile(fullfile(PATH_DATA, 'Quickstep'));
listOfRumbaAmerican      = listfile(fullfile(PATH_DATA, 'Rumba-American'));
listOfRumbaInternational = listfile(fullfile(PATH_DATA, 'Rumba-International'));
listOfRumbaMisc          = listfile(fullfile(PATH_DATA, 'Rumba-Misc'));
listOfSamba              = listfile(fullfile(PATH_DATA, 'Samba'));
listOfTango              = listfile(fullfile(PATH_DATA, 'Tango'));
listOfVienneseWaltz      = listfile(fullfile(PATH_DATA, 'VienneseWaltz'));
listOfWaltz              = listfile(fullfile(PATH_DATA, 'Waltz'));
Genres = {'ChaChaCha' , 'Jive', 'Nada'  , ...
          'Quickstep' , 'Rumba-American', 'Rumba-International',...
          'Rumba-Misc', 'Samba', 'Tango', 'VienneseWaltz', 'Waltz', 'Rumba'};


%% Pre-Process of loading data(filename) and groundtruth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = get_DataAttribute(listOfGroundTruth,        listOfChaChaCha,...
                         listOfJive,               listOfNada,...
                         listOfQuickstep,          listOfRumbaAmerican,...
                         listOfRumbaInternational, listOfRumbaMisc,...
                         listOfSamba,              listOfTango,...
                         listOfVienneseWaltz,      listOfWaltz, Genres);
save ('hw4_data.mat', 'data');


%% Compute Fourier-Tempogram and Autocorrelation-Tempogram of each track
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('hw4_data.mat');
for i = 1 : length(Genres)
    for j = 1 : size(data, 2)
        if isempty(data{i, j}) || (data{i, j}.bpm == -1), break; end
        [data{i, j}.dft, data{i, j}.acf, data{i, j}.T, data{i, j}.BPM] = get_DataTempogram(data{i, j}.name);
    end
end
save ('hw4_data.mat', 'data', '-v7.3');
clearvars -except PATH_DATA PATH_TRUTH Genres data...
                  listOfGroundTruth listOfChaChaCha     listOfJive...
                  listOfNada        listOfQuickstep     listOfRumbaAmerican...
                  listOfRumbaInternational              listOfRumbaMisc...
                  listOfSamba listOfTango listOfVienneseWaltz listOfWaltz


%% Compute Saliency, P-Score and ALOTC-Score(at least one tempo correct)
% Max BPM = 224, Min BPM = 60.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars -except PATH_DATA PATH_TRUTH Genres data...
                  listOfGroundTruth listOfChaChaCha     listOfJive...
                  listOfNada        listOfQuickstep     listOfRumbaAmerican...
                  listOfRumbaInternational              listOfRumbaMisc...
                  listOfSamba listOfTango listOfVienneseWaltz listOfWaltz
load('hw4_data.mat');
multiples = [1 1/2 1/3 1/4 2 3 4];
for k = 1 : length(multiples)
    fprintf('---------------Multiples: %f---------------\n', multiples(k));
    for i = 1 : length(Genres)
        p_score_dft = 0;
        p_score_acf = 0;
        a_score_dft = 0;
        a_score_acf = 0;
        T2dT1_dft = 0;
        T2dT1_acf = 0;
        T1dG_dft = 0;
        T1dG_acf = 0;
        T2dG_dft = 0;
        T2dG_acf = 0;
        for j = 1 : size(data, 2)
            if isempty(data{i, j}) || (data{i, j}.bpm == -1), break; end
            [Tempo_DFT, Saliency_DFT] = get_dft_tempo_saliency(data{i, j}.dft, multiples(k), 40, 990);
            [Tempo_ACF, Saliency_ACF] = get_acf_tempo_saliency(data{i, j}.acf, multiples(k), 40, 250);
            [P_DFT, P_ACF, A_DFT, A_ACF] = compute_pscore_alotcscore(...
                                            Tempo_DFT, Saliency_DFT, ...
                                            Tempo_ACF, Saliency_ACF, ...
                                            [], [], 'Normal', data{i, j}.bpm);
            p_score_dft = p_score_dft + P_DFT;
            p_score_acf = p_score_acf + P_ACF;
            a_score_dft = a_score_dft + A_DFT;
            a_score_acf = a_score_acf + A_ACF;
            T2dT1_dft = T2dT1_dft + Tempo_DFT(2) / Tempo_DFT(1);
            T2dT1_acf = T2dT1_acf + Tempo_ACF(2) / Tempo_ACF(1);
            T1dG_dft = T1dG_dft + Tempo_DFT(1) / data{i, j}.bpm;
            T1dG_acf = T1dG_acf + Tempo_ACF(1) / data{i, j}.bpm;
            T2dG_dft = T2dG_dft + Tempo_DFT(2) / data{i, j}.bpm;
            T2dG_acf = T2dG_acf + Tempo_ACF(2) / data{i, j}.bpm;
        end
        T2dT1_dft = T2dT1_dft / data{i, 1}.numele;
        T2dT1_acf = T2dT1_acf / data{i, 1}.numele;
        T1dG_dft = T1dG_dft / data{i, 1}.numele;
        T1dG_acf = T1dG_acf / data{i, 1}.numele;
        T2dG_dft = T2dG_dft / data{i, 1}.numele;
        T2dG_acf = T2dG_acf / data{i, 1}.numele;
        avg_p_score_dft =  p_score_dft / data{i, 1}.numele;
        avg_p_score_acf =  p_score_acf / data{i, 1}.numele;
        if k ~= 1
            fprintf('%-19s:[DFT] P-Score: %f, Alotc-Score: %3d/%-3d\t[ACF] P-Score: %f, Alotc-Score: %3d/%-3d\n', char(Genres(i)), avg_p_score_dft, a_score_dft, data{i, 1}.numele, avg_p_score_acf, a_score_acf, data{i, 1}.numele);
        else
            fprintf(['%-19s:[DFT] P-Score: %f, Alotc-Score: %3d/%-3d, T2/T1: %f, T1/G: %f, T2/G: %f\t',...
                          '[ACF] P-Score: %f, Alotc-Score: %3d/%-3d, T2/T1: %f, T1/G: %f, T2/G: %f\n'], char(Genres(i)),...
                      avg_p_score_dft, a_score_dft, data{i, 1}.numele, T2dT1_dft, T1dG_dft, T2dG_dft, ...
                      avg_p_score_acf, a_score_acf, data{i, 1}.numele, T2dT1_acf, T1dG_acf, T2dG_acf);
        end
    end
end


%% Hybrid Method
clearvars -except PATH_DATA PATH_TRUTH Genres data...
                  listOfGroundTruth listOfChaChaCha     listOfJive...
                  listOfNada        listOfQuickstep     listOfRumbaAmerican...
                  listOfRumbaInternational              listOfRumbaMisc...
                  listOfSamba listOfTango listOfVienneseWaltz listOfWaltz
load('hw4_data.mat');
fprintf('------------------------Hybrid Method------------------------\n');
for i = 1 : length(Genres)
    p_score = 0;
    a_score = 0;
    for j = 1 : size(data, 2)
        if isempty(data{i, j}) || (data{i, j}.bpm == -1), break; end
        [Tempo_DFT, Saliency_DFT] = get_dft_tempo_saliency(data{i, j}.dft, 1, 40, 250);
        [Tempo_ACF, Saliency_ACF] = get_acf_tempo_saliency(data{i, j}.acf, 1, 40, 250);
        Saliency_HYB = get_hybrid_saliency(data{i, j}.dft, data{i, j}.acf, 1, 40, 250);
        [~, ~, ~, ~, P_HYB, A_HYB] = compute_pscore_alotcscore(   ...
                                        Tempo_DFT, Saliency_DFT,    ...
                                        Tempo_ACF, Saliency_ACF,    ...
                                        [Tempo_DFT(1) Tempo_ACF(2)],...
                                        Saliency_HYB, 'Hybrid', data{i, j}.bpm);
        p_score = p_score + P_HYB;
        a_score = a_score + A_HYB;
    end

    avg_p_score_hyb =  p_score / data{i, 1}.numele;
    fprintf('%-19s:P-Score: %f, Alotc-Score: %3d/%-3d\n', char(Genres(i)), avg_p_score_hyb, a_score, data{i, 1}.numele);
end

%% Testing Area
for j = 1 : size(data, 2)
    if isempty(data{1, j}) || (data{1, j}.bpm == -1), break; end
    [Tempo_DFT, Saliency_DFT] = gen_tempo_saliency(data{1, j}.dft, 4, 40, 250);
    [Tempo_ACF, Saliency_ACF] = gen_tempo_saliency(data{1, j}.acf, 4, 40, 250);
    [P_DFT, P_ACF, A_DFT, A_ACF] = compute_pscore_alotcscore(...
                                    Tempo_DFT, Saliency_DFT, ...
                                    Tempo_ACF, Saliency_ACF, data{1, j}.bpm);

    fprintf('[DFT]\t[T1 T2]: [%3d %3d], GroundTruth: %3d\n', Tempo_DFT(1), Tempo_DFT(2), data{1, j}.bpm);
    fprintf('[ACF]\t[T1 T2]: [%3d %3d], GroundTruth: %3d\n\n', Tempo_ACF(1), Tempo_ACF(2), data{1, j}.bpm);
    p_score_dft = p_score_dft + P_DFT;
    p_score_acf = p_score_acf + P_ACF;
    a_score_dft = a_score_dft + A_DFT;
    a_score_acf = a_score_acf + A_ACF;
end
