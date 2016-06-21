function [KS_key] = get_KSkey(sum_chroma, genre)
    if genre==1 || genre==7
%         % Major and Major
%         KS_templates = [
%             6.35,    0, 3.48, 2.33, 4.38,    0,    0, 5.19,    0, 3.66,    0,    0
%             6.35,    0,    0, 4.38,    0, 4.09, 2.52, 5.19,    0,    0, 2.29,    0
%         ];
        % Minor and Minor
        KS_templates = [
                6.35,    0, 3.52, 5.38, 2.60,    0,    0, 4.75,    0, 2.69,    0,    0
                6.35,    0,    0, 2.60,    0, 3.53, 2.54, 4.75,    0,    0, 3.34,    0
        ];
%         % Major and Minor
%         KS_templates = [
%                 6.35,    0, 3.48, 2.33, 4.38,    0,    0, 5.19,    0, 3.66,    0,    0
%                 6.35,    0,    0, 2.60,    0, 3.53, 2.54, 4.75,    0,    0, 3.34,    0
%         ];
    else
        KS_templates = [
            6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88
            6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17
        ]; 
    end
    
    % index of chroma array: [1 2  3 4  5 6 7  8 9  10 11 12]
    % corresponding note:    [C C# D D# E F F# G G# A  A# B ]
    major_ks = KS_templates(1, :);
    minor_ks = KS_templates(2, :);
    
    key = zeros(1, 24);
    for shift = 0:(12-1)
        x = circshift(sum_chroma, [-shift, 0]);
        major_R = corrcoef(x, major_ks);
        minor_R = corrcoef(x, minor_ks);
        key(shift + 1) = major_R(1, 2);
        key(shift + 1 + 12) = minor_R(1, 2);
    end
    
    [~, key_id] = max(key);
    if key_id >= 12; KS_key = mod(key_id - 1 + 3, 12) + 12;
    else KS_key = mod(key_id - 1 + 3, 12); end
end