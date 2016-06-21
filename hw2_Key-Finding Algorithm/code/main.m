% Cheng-Wei Wu 2016/4/14, 4/15, 4/17
% Please add Chroma-Toolbox to Matlab's path
% Please remember to remove the Auditory-Toolbox from the path setting

%% Default Setting
clear; clc; close all
PATH_AUDIO = './genres';
PATH_GROUNDTRUTH = './gtzan_key/gtzan_key/genres';
Genres = {
    'Blues', 'Classical', 'Country', 'Disco' , 'Hiphop', ... 
    'Jazz' , 'Metal'    , 'Pop'    , 'Reggae', 'Rock'
};

% creat two arrays for iterating audio files and groundtruth(name)
[listOfSongs, listOfLabel] = get_music(PATH_AUDIO, PATH_GROUNDTRUTH);
num_song = 100;

%% Extract Chromagram of the Song, and save it
mirwaitbar(0);
try
    rmpath('./toolbox/AuditoryToolbox');
catch
    fprintf('AuditoryToolbox doesn''t exist!\n');
end
% Ga = [100];
Ga = [1, 10, 100, 1000];
F_CLP = cell(length(Ga), 10, 100);
T_RES = zeros(length(Genres), num_song);

% iterate chromagram
for ga = 1 : length(Ga) % iterate Gamma
    for ge = 1 : length(Genres) % iterate Genre
        for song_id = 1 : num_song % iterate Song
            % disp(sprintf('Genre:%d, Song:%d\n', ge, song_id));
            f_CLP = get_chroma(listOfSongs{(ge-1) * 100 + song_id}, Ga(ga));
            F_CLP{ga, ge, song_id} = f_CLP;
        end
    end
end

% iterate groundtruth
for ge = 1 : length(Genres) % iterate Genre
    for song_id = 1 : num_song % iterate Song
        fin = fopen(listOfLabel{(ge-1) * 100 + song_id});
        grd_pitch = fscanf(fin, '%d');
        fclose(fin);
        T_RES(ge, song_id) = grd_pitch;
    end
end
% save ('hw2_dataset_all_low.mat', 'F_CLP', 'T_RES');  % 882   Hz
save ('hw2_dataset_all_medium.mat', 'F_CLP', 'T_RES'); % 4410  Hz
% save ('hw2_dataset_all_high.mat', 'F_CLP', 'T_RES'); % 22050 Hz

%% Calculate Correction Rate (new)
% Ga = [100];
Ga = [1, 10, 100, 1000];
% load('hw2_dataset_all_low.mat');
load('hw2_dataset_all_medium.mat');
% load('hw2_dataset_all_high.mat');

pred_result_bi = zeros(2, length(Ga), length(Genres));
pred_result_ks = zeros(2, length(Ga), length(Genres));
for ga = 1 : length(Ga) % iterate Gamma
    for ge = 1 : length(Genres) % iterate Genre
        for song_id = 1 : num_song % iterate Song
            sum_chroma = sum(F_CLP{ga, ge, song_id}, 2);
            [~, tonic] = max(sum_chroma);
            
            % tonic's range is (1, 12)
            major_idx = mod(tonic - 1 + 3, 12);
            minor_idx = major_idx + 12; 
            maj_tembi = get_temtonic(major_idx);
            min_tembi = get_temtonic(minor_idx);
            major_R_bi = corrcoef(sum_chroma, maj_tembi);
            minor_R_bi = corrcoef(sum_chroma, min_tembi);
            
            pitch_bi = mod(tonic - 1 + 3, 12);
            if minor_R_bi(1, 2) > major_R_bi(1, 2); pitch_bi = tonic + 12; end
            pitch_ks = get_KSkey(sum_chroma, ge);
            
            % Q1 - Score Calculation
            if pitch_bi == T_RES(ge, song_id); pred_result_bi(1, ga, ge) = pred_result_bi(1, ga, ge) + 1; end
            if pitch_ks == T_RES(ge, song_id); pred_result_ks(1, ga, ge) = pred_result_ks(1, ga, ge) + 1; end
            % Q3 - Score Calculation
            pred_result_bi(2, ga, ge) = pred_result_bi(2, ga, ge) + get_score(pitch_bi, T_RES(ge, song_id));
            pred_result_ks(2, ga, ge) = pred_result_ks(2, ga, ge) + get_score(pitch_ks, T_RES(ge, song_id));
        end
    end
end

%% Calculate Accuracy
accuracy_bi     = cell(2, 1);
total_score_bi  = cell(2, 1);
total_size_bi   = cell(2, 1);
accuracy_ks     = cell(2, 1);
total_score_ks  = cell(2, 1);
total_size_ks   = cell(2, 1);

accuracy_bi{1, 1}     = zeros(length(Ga), length(Genres));
accuracy_bi{2, 1}     = zeros(length(Ga), length(Genres));
total_score_bi{1, 1}  = zeros(length(Ga));
total_score_bi{2, 1}  = zeros(length(Ga));
total_size_bi{1, 1}   = zeros(length(Ga));
total_size_bi{2, 1}   = zeros(length(Ga));
accuracy_ks{1, 1}     = zeros(length(Ga), length(Genres));
accuracy_ks{2, 1}     = zeros(length(Ga), length(Genres));
total_score_ks{1, 1}  = zeros(length(Ga));
total_score_ks{2, 1}  = zeros(length(Ga));
total_size_ks{1, 1}   = zeros(length(Ga));
total_size_ks{2, 1}   = zeros(length(Ga));

for ga = 1 : length(Ga) % iterate Gamma
    for ge = 1 : length(Genres)
        score_bi_q1 = pred_result_bi(1, ga, ge);
        score_bi_q3 = pred_result_bi(2, ga, ge);
        score_ks_q1 = pred_result_ks(1, ga, ge);
        score_ks_q3 = pred_result_ks(2, ga, ge);
        
        set_size = sum(T_RES(ge, :)>=0);
%         if set_size == 0; set_size = 100; end
        
        accuracy_bi{1, 1}(ga, ge) = score_bi_q1 / set_size;
        accuracy_bi{2, 1}(ga, ge) = score_bi_q3 / set_size;
        accuracy_ks{1, 1}(ga, ge) = score_ks_q1 / set_size;
        accuracy_ks{2, 1}(ga, ge) = score_ks_q3 / set_size;

        total_score_bi{1, 1}(ga) = total_score_bi{1, 1}(ga) + score_bi_q1;
        total_score_bi{2, 1}(ga) = total_score_bi{2, 1}(ga) + score_bi_q3;
        total_size_bi{1, 1}(ga) = total_size_bi{1, 1}(ga) + set_size;
        total_size_bi{2, 1}(ga) = total_size_bi{2, 1}(ga) + set_size;
        
        total_score_ks{1, 1}(ga) = total_score_ks{1, 1}(ga) + score_ks_q1;
        total_score_ks{2, 1}(ga) = total_score_ks{2, 1}(ga) + score_ks_q3;
        total_size_ks{1, 1}(ga) = total_size_ks{1, 1}(ga) + set_size;
        total_size_ks{2, 1}(ga) = total_size_ks{2, 1}(ga) + set_size;
    end
end

[sta_bi_q1, sta_bi_q3, sta_ks_q1, sta_ks_q3]...
                = get_statistics(Genres, accuracy_bi, accuracy_ks);
disp_statistics(sta_bi_q1, sta_bi_q3, sta_ks_q1, sta_ks_q3,...
                total_score_bi, total_size_bi, total_score_ks, total_size_ks);
            