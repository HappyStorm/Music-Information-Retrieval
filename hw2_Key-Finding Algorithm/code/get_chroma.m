function [f_CLP, sideinfo] = get_chroma(filename, gamma)
    [f_audio, sideinfo] = wav_to_audio('', '', filename);
    shiftFB = estimateTuning(f_audio);

%     paramPitch.winLenSTMSP = 22050; % for high pitches
    paramPitch.winLenSTMSP = 4410;  % for medium pitches
%     paramPitch.winLenSTMSP = 882;   % for low pitches
    paramPitch.shiftFB = shiftFB;
    [f_pitch, sideinfo] = audio_to_pitch_via_FB(f_audio, paramPitch, sideinfo);

    paramCLP.applyLogCompr = 1;
    paramCLP.factorLogCompr = gamma;
    paramCLP.inputFeatureRate = sideinfo.pitch.featureRate;
    [f_CLP, sideinfo] = pitch_to_chroma(f_pitch, paramCLP, sideinfo);
end