function [listOfSongs, listOfLabel] = get_music(PATH_AUDIO, PATH_GROUNDTRUTH)
    listOfSongsBlues        = listfile(fullfile(PATH_AUDIO,'blues'))';
    listOfSongsClassical    = listfile(fullfile(PATH_AUDIO,'classical'))';
    listOfSongsCountry      = listfile(fullfile(PATH_AUDIO,'country'))';
    listOfSongsDisco        = listfile(fullfile(PATH_AUDIO,'disco'))';
    listOfSongsHiphop       = listfile(fullfile(PATH_AUDIO,'hiphop'))';
    listOfSongsJazz         = listfile(fullfile(PATH_AUDIO,'jazz'))';
    listOfSongsMetal        = listfile(fullfile(PATH_AUDIO,'metal'))';
    listOfSongsPop          = listfile(fullfile(PATH_AUDIO,'pop'))';
    listOfSongsReggae       = listfile(fullfile(PATH_AUDIO,'reggae'))';
    listOfSongsRock         = listfile(fullfile(PATH_AUDIO,'Rock'))';

    listOfLabelBlues        = listfile(fullfile(PATH_GROUNDTRUTH,'blues'))';
    listOfLabelClassical    = listfile(fullfile(PATH_GROUNDTRUTH,'classical'))';
    listOfLabelCountry      = listfile(fullfile(PATH_GROUNDTRUTH,'country'))';
    listOfLabelDisco        = listfile(fullfile(PATH_GROUNDTRUTH,'disco'))';
    listOfLabelHiphop       = listfile(fullfile(PATH_GROUNDTRUTH,'hiphop'))';
    listOfLabelJazz         = listfile(fullfile(PATH_GROUNDTRUTH,'jazz'))';
    listOfLabelMetal        = listfile(fullfile(PATH_GROUNDTRUTH,'metal'))';
    listOfLabelPop          = listfile(fullfile(PATH_GROUNDTRUTH,'pop'))';
    listOfLabelReggae       = listfile(fullfile(PATH_GROUNDTRUTH,'reggae'))';
    listOfLabelRock         = listfile(fullfile(PATH_GROUNDTRUTH,'Rock'))';

    listOfSongs = [listOfSongsBlues; listOfSongsClassical; listOfSongsCountry; ...
                   listOfSongsDisco; listOfSongsHiphop;    listOfSongsJazz; ...
                   listOfSongsMetal; listOfSongsPop;       listOfSongsReggae; ...
                   listOfSongsRock];
    listOfLabel = [listOfLabelBlues; listOfLabelClassical; listOfLabelCountry; ...
                   listOfLabelDisco; listOfLabelHiphop;    listOfLabelJazz; ...
                   listOfLabelMetal; listOfLabelPop;       listOfLabelReggae; ...
                   listOfLabelRock];
end