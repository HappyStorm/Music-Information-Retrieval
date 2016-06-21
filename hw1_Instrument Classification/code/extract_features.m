function [feature, raw] = extract_features(file, w, h, type)
    % file: file name
    % w: window size (in samples)
    % h: hop size (in samples)
    % type: featurename

    a = miraudio(file, 'Normal');
    f = mirframe(a, 'Length', w, 'sp', 'Hop', h, 'sp');
    S = mirspectrum(f);

    % Clip-Level (need pooling)
    if strcmp(type, 'brightness')
        mirfeature = mirbrightness(S);
    elseif strcmp(type, 'centroid')
        mirfeature = mircentroid(S);
    elseif strcmp(type, 'entropy')
        mirfeature = mirentropy(S);
    elseif strcmp(type, 'kurtosis')
        mirfeature = mirkurtosis(S);
    elseif strcmp(type, 'mfcc_train_20')
        mirfeature = mirmfcc(S, 'Rank', 1:20);
    elseif strcmp(type, 'mfcc_train_1')
        mirfeature = mirmfcc(S, 'Rank');
    elseif strcmp(type, 'mfcc_test')
        mirfeature = mirmfcc(S, 'Rank');
    elseif strcmp(type, 'rolloff')
        mirfeature = mirrolloff(S);
    elseif strcmp(type, 'roughness')
        mirfeature = mirroughness(S);
    elseif strcmp(type, 'skewness')
        mirfeature = mirskewness(S);
    elseif strcmp(type, 'zerocross')
        mirfeature = mirzerocross(f);

    % Frame-Level (no need for pooling)
    elseif strcmp(type, 'attacktime')
        mirfeature = mirattacktime(S);
    elseif strcmp(type, 'decrease')
        mirfeature = mirdecreaseslope(S);
    elseif strcmp(type, 'inharmonicity')
        mirfeature = mirinharmonicity(S);
    elseif strcmp(type, 'irregularity')
        mirfeature = mirregularity(S);
    elseif strcmp(type, 'onset')
        mirfeature = mironsets(S);
    elseif strcmp(type, 'pitch')
        mirfeature = mirpitch(S);
    end

    % raw = mirgetdata(S); % size: 513 x number of frames
    raw = mirgetdata(mirfeature);
    feature = [mean(raw, 2); std(raw, 0, 2)]; % e.g. feature(21) = std(raw(1,:))
end
