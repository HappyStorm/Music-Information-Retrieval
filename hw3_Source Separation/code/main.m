% Cheng-Wei Wu 2016/5/2, 5/3, 5/4, 5/5, 5/6, 5/7, 5/8, 5/9
% Please add Chroma-Toolbox to Matlab's path
% Please remember to remove the Auditory-Toolbox from the path setting

%% Default Setting
clear; close all
PATH_HOME = './';
PATH_AUDIO = './audio';
PATH_TRAIN = './audio/train';
PATH_TEST_ANS = './pred';
PATH_VALID = './pred_valid';
listOfValidPred = listfile(fullfile(PATH_HOME, 'pred_valid'));
listOfTest = listfile(fullfile(PATH_AUDIO, 'test'));
listOfValid = listfile(fullfile(PATH_AUDIO, 'validation'));
listOfTrainVio = listfile(fullfile(PATH_TRAIN, 'vio'));
listOfTrainCla = listfile(fullfile(PATH_TRAIN, 'cla'));
try
    rmpath('./toolbox/AuditoryToolbox');
catch
    fprintf('AuditoryToolbox doesn''t exist!\n');
end
clc;

%% B1: BSS Evaluation
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
% {1}: 01_cla.wav  b
% {2}: 01_mix.wav  c
% {3}: 01_vio.wav  a
a = audioread(listOfValid{3});
b = audioread(listOfValid{1});
c = audioread(listOfValid{2});
n = randn(length(a), 1); % normally distributed pseudorandom numbers

SDR = bss_eval_sources([c'; c']/2, [a'; b']);
fprintf('SDR(c/2, a)\t= %f\n', SDR(1,1));
fprintf('SDR(c/2, b)\t= %f\n\n', SDR(2,1));

SDR = bss_eval_sources([a'; b'], [a'; b']);
fprintf('SDR(a, a)\t= %f\n', SDR(1,1));
fprintf('SDR(b, b)\t= %f\n\n', SDR(2,1));

SDR = bss_eval_sources([b'; a'], [a'; b']);
fprintf('SDR(b, a)\t= %f\n', SDR(1,1));
fprintf('SDR(a, b)\t= %f\n\n', SDR(2,1));

SDR = bss_eval_sources([2*a'; 2*b'], [a'; b']);
fprintf('SDR(2*a, a)\t= %f\n', SDR(1,1));
fprintf('SDR(2*b, b)\t= %f\n\n', SDR(2,1));

SDR = bss_eval_sources((a+0.01*n)', a');
fprintf('SDR((a+0.01*n), a)\t= %f\n\n', SDR(1,1));

SDR = bss_eval_sources((a+0.1*n)', a');
fprintf('SDR((a+0.1*n), a)\t= %f\n\n', SDR(1,1));

SDR = bss_eval_sources((a+n)', a');
fprintf('SDR((a+n), a)\t= %f\n\n', SDR(1,1));

SDR = bss_eval_sources((a+0.01*b)', a');
fprintf('SDR((a+0.01*b), a)\t= %f\n\n', SDR(1,1));

SDR = bss_eval_sources((a+0.1*b)', a');
fprintf('SDR((a+0.1*b), a)\t= %f\n\n', SDR(1,1));

SDR = bss_eval_sources((a+b)', a');
fprintf('SDR((a+b), a)\t= %f\n\n', SDR(1,1));

%% B2: Inverse STFT
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred

[vio_64, vio_64_fs] = audioread(listOfTrainVio{10});
[vio_88, vio_88_fs] = audioread(listOfTrainVio{34}); % vio 88
[cla_64, cla_64_fs] = audioread(listOfTrainCla{15}); % cla 64

w = 1024;
h = 256;
nfft = w;
thres = 1200; % 1200 Hz
[s, f, t] = stft(vio_64, w, h, nfft, vio_64_fs);
s_hp = s;
s_lp = s;
for col = 1 : size(s, 2)
    for i = 1 : length(f)
        if f(i) < thres; s_hp(i, col) = 0; end
        if f(i) > thres; s_lp(i, col) = 0; end
    end
end
[s_vio_64_hp, t_hp] = istft(s_hp, h, nfft, vio_64_fs);
[s_vio_64_lp, t_lp] = istft(s_lp, h, nfft, vio_64_fs);
audiowrite('vio_64_hp.wav', s_vio_64_hp, vio_64_fs);
audiowrite('vio_64_lp.wav', s_vio_64_lp, vio_64_fs);

vio_64_hp = audioread('vio_64_hp.wav');
vio_64_lp = audioread('vio_64_lp.wav');
vio_64 = vio_64(1:length(vio_64_lp), 1);
SDR = bss_eval_sources(vio_64_lp', vio_64');

[s1, f1, t1] = stft(vio_64, w, h, nfft, vio_64_fs);
[s2, f2, t2] = stft(vio_64_lp, w, h, nfft, vio_64_fs);
[s3, f3, t3] = stft(vio_64_hp, w, h, nfft, vio_64_fs);

figure
subplot(2,3,1), imagesc(t1, f1, log10(abs(s1)))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64.wav - STFT Spectrum')

subplot(2,3,2), imagesc(t2, f2, log10(abs(s2)))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64\_lp.wav - STFT Spectrum')

subplot(2,3,3), imagesc(t3, f3, log10(abs(s3)))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64\_hp.wav - STFT Spectrum')

subplot(2,3,4), imagesc(t1, f1, mirgetdata(mirspectrum(mirframe(miraudio(listOfTrainVio{10}) , 'Length', w,'sp', 'Hop', h, 'sp'), 'dB')))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64.wav - STFT Spectrum')

subplot(2,3,5), imagesc(t2, f2, mirgetdata(mirspectrum(mirframe(miraudio('vio_64_hp.wav'), 'Length', w,'sp', 'Hop', h, 'sp'), 'dB')))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64\_lp.wav - STFT Spectrum')

subplot(2,3,6), imagesc(t3, f3, mirgetdata(mirspectrum(mirframe(miraudio('vio_64_lp.wav'), 'Length', w,'sp', 'Hop', h, 'sp'), 'dB')))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_64\_hp.wav - STFT Spectrum')

[s, f, t] = stft(vio_88, w, h, nfft, vio_88_fs);
figure
imagesc(t, f, log10(abs(s)))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Vio\_88.wav - STFT Spectrum')

[s, f, t] = stft(cla_64, w, h, nfft, cla_64_fs);
figure
imagesc(t, f, log10(abs(s)))
set(gca, 'YDir', 'Normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('Cla\_64.wav - STFT Spectrum')

%% B3: NMF
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
w = 1024;
h = 256;
nfft = w;
K = 3; % number of basis vectors
MAXITER = 200; % total number of iterations to run

[vio64, vio64_fs] = audioread(listOfTrainVio{10});
[vio64_s, vio64_f, vio64_t] = stft(vio64, w, h, nfft, vio64_fs);
vio64_V = abs(vio64_s);
[vio64_W_EU, vio64_H_EU] = nmf_all(1, vio64_V, K, MAXITER, 2, true);
% [vio64_W_EU, vio64_H_EU] = nmf_all(2, vio64_V, K, 1e-7, 1000, 5000);
% vio64_EU = get_remix(vio64_s, h, vio64_W_EU, vio64_H_EU, K);
% plot_reorigin(vio64_W_EU, vio64_H_EU, vio64_s);
% plot_basic(vio64_W_EU, K, vio64_fs, nfft);
% plot_layer(vio64_W_EU, vio64_H_EU, K);
% plot_mask(vio64_W_EU, vio64_H_EU, K);
plot_template(listOfTrainVio{10}, vio64_s, vio64_fs, vio64_V, vio64_W_EU, vio64_H_EU, K, h);
% figure
% subplot(1,3,1), imagesc(t1, f1, log10(abs(s1)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_64\_t1.wav - STFT Spectrum')
% 
% subplot(1,3,2), imagesc(t2, f2, log10(abs(s2)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_64\_t2.wav - STFT Spectrum')
% 
% subplot(1,3,3), imagesc(t3, f3, log10(abs(s3)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_64\_t3.wav - STFT Spectrum')


[vio88, vio88_fs] = audioread(listOfTrainVio{34});
[vio88_s, vio88_f, vio88_t] = stft(vio88, w, h, nfft, vio88_fs);
vio88_V = abs(vio88_s);
[vio88_W_EU, vio88_H_EU] = nmf_all(1, vio88_V, K, MAXITER, 2, true);
% [vio88_W_EU, vio88_H_EU] = nmf_all(2, vio88_V, K, 1e-7, 1000, 5000); 
% vio88_EU = get_remix(vio88_s, h, vio88_W_EU, vio88_H_EU, K);
% plot_reorigin(vio88_W_EU, vio88_H_EU, vio88_s);
% plot_basic(vio88_W_EU, K, vio88_fs, nfft);
% plot_layer(vio88_W_EU, vio88_H_EU, K);
% plot_mask(vio88_W_EU, vio88_H_EU, K);
% [s_vio_88_t1, t1] = istft(vio88_W_EU(:, 1), h, nfft, vio88_fs);
% [s_vio_88_t2, t2] = istft(vio88_W_EU(:, 2), h, nfft, vio88_fs);
% [s_vio_88_t3, t3] = istft(vio88_W_EU(:, 3), h, nfft, vio88_fs);
% [s1, f1, t1] = stft(s_vio_88_t1, w, h, nfft, vio88_fs);
% [s2, f2, t2] = stft(s_vio_88_t2, w, h, nfft, vio88_fs);
% [s3, f3, t3] = stft(s_vio_88_t3, w, h, nfft, vio88_fs);
plot_template(listOfTrainVio{34}, vio88_s, vio88_fs, vio88_V, vio88_W_EU, vio88_H_EU, K, h);
% figure
% subplot(1,3,1), imagesc(t1, f1, log10(abs(s1)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_88\_t1.wav - STFT Spectrum')
% 
% subplot(1,3,2), imagesc(t2, f2, log10(abs(s2)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_88\_t2.wav - STFT Spectrum')
% 
% subplot(1,3,3), imagesc(t3, f3, log10(abs(s3)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Vio\_88\_t3.wav - STFT Spectrum')


[cla64, cla64_fs] = audioread(listOfTrainCla{15});
[cla64_s, cla64_f, cla64_t] = stft(cla64, w, h, nfft, cla64_fs);
cla64_V = abs(cla64_s);
[cla64_W_EU, cla64_H_EU] = nmf_all(1, cla64_V, K, MAXITER, 2, true);
% [cla64_W_EU, cla64_H_EU] = nmf_all(2, cla64_V, K, 1e-7, 1000, 5000);
% cla64_EU = get_remix(cla64_s, h, cla64_W_EU, cla64_H_EU, K);
% plot_reorigin(cla64_W_EU, cla64_H_EU, cla64_s);
% plot_basic(cla64_W_EU, K, cla64_fs, nfft);
% plot_layer(cla64_W_EU, cla64_H_EU, K);
% plot_mask(cla64_W_EU, cla64_H_EU, K);
% [s_cla_64_t1, t1] = istft(cla64_W_EU(:, 1), h, nfft, cla64_fs);
% [s_cla_64_t2, t2] = istft(cla64_W_EU(:, 2), h, nfft, cla64_fs);
% [s_cla_64_t3, t3] = istft(cla64_W_EU(:, 3), h, nfft, cla64_fs);
% [s1, f1, t1] = stft(s_cla_64_t1, w, h, nfft, cla64_fs);
% [s2, f2, t2] = stft(s_cla_64_t2, w, h, nfft, cla64_fs);
% [s3, f3, t3] = stft(s_cla_64_t3, w, h, nfft, cla64_fs);
plot_template(listOfTrainCla{15}, cla64_s, cla64_fs, cla64_V, cla64_W_EU, cla64_H_EU, K, h);
% figure
% subplot(1,3,1), imagesc(t1, f1, log10(abs(s1)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Cla\_64\_t1.wav - STFT Spectrum')
% 
% subplot(1,3,2), imagesc(t2, f2, log10(abs(s2)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Cla\_64\_t2.wav - STFT Spectrum')
% 
% subplot(1,3,3), imagesc(t3, f3, log10(abs(s3)))
% set(gca, 'YDir', 'Normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('Cla\_64\_t3.wav - STFT Spectrum')

%% R1: Source Separation: vio->vio
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
w = 1024;
h = 256;
nfft = w;
K = 3; % number of basis vectors
MAXITER = 200; % total number of iterations to run
W_vio_dic = [];
for i=1 : length(listOfTrainVio)
    [vio, fs] = audioread(listOfTrainVio{i});
    [s, ~, ~] = stft(vio, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 2, true);
    W_vio_dic = [W_vio_dic W];
end
plot_dic(W_vio_dic, true);

[valid_vio01, fs] = audioread(listOfValid{3});
[s, ~, ~] = stft(valid_vio01, w, h, nfft, fs);
V = abs(s);
[W_vio, H_vio] = nmf_all(1, V, K, MAXITER, 2, false, W_vio_dic);
plot_active(H_vio, true);

phi = angle(s);
% Mask = zeros(size(V));
% for k = 1 : floor(size(W_vio, 2) / 2)
%     
%     A = W_vio(:, k) * H_vio(k, :);
%     B = W_vio(:, size(W_vio, 2)-k) * H_vio(size(W_vio, 2)-k, :);
%     for i = 1 : size(A, 1)
%         for j = 1 : size(A, 2)
%     %        if A(i, j) > B(i, j), Mask(i, j) = 1;
%     %        else Mask(i, j) = 0; end
% %            Mask(i, j) = A(i, j) / (A(i, j) + B(i, j));
%            Mask(i, j) = Mask(i, j) + (A(i, j) / (A(i, j) + B(i, j)));
%         end
%     end
% end
% Mask = Mask / floor(size(W_vio, 2) / 2);
% % Mask = W_vio(:, 1) * H_vio(1, :) ./ (W_vio*H_vio);
% XmagHat = V.*Mask;
XmagHat = W_vio * H_vio;
xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
% xhat = denoiseEm(xhat);
audiowrite('01_vio_re.wav', xhat, fs);

%% R2: Source Separation: vio->cla
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
w = 1024;
h = 256;
nfft = w;
K = 3; % number of basis vectors
MAXITER = 200; % total number of iterations to run
W_vio_dic = [];
for i=1 : length(listOfTrainVio)
    [vio, fs] = audioread(listOfTrainVio{i});
    [s, ~, ~] = stft(vio, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 2, true);
    W_vio_dic = [W_vio_dic W];
end
% plot_dic(W_vio_dic, false);

[valid_cla01, fs] = audioread(listOfValid{1});
[s, ~, ~] = stft(valid_cla01, w, h, nfft, fs);
V = abs(s);
[W_vio, H_vio] = nmf_all(1, V, K, MAXITER, 2, false, W_vio_dic);
plot_active(H_vio, true);

phi = angle(s);
XmagHat = W_vio * H_vio;
xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
audiowrite('01_cla_re.wav', xhat, fs);

%% R3: Source Separation: Validation
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
w = 1024;
h = 256;
nfft = w;
K = 15; % number of templates (basis vectors)
MAXITER = 400; % maximum number of iterations to run

% train violin dictionary
W_vio_dic = [];
for i=1 : length(listOfTrainVio)
    [vio, fs] = audioread(listOfTrainVio{i});
    [s, ~, ~] = stft(vio, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 1, true);
%     [W, H] = nmf_all(2, V, K, 1e-4, 1000, 5000);
    W_vio_dic = [W_vio_dic W];
end

% train clarinet dictionary
W_cla_dic = [];
for i=1 : length(listOfTrainCla)
    [cla, fs] = audioread(listOfTrainCla{i});
    [s, ~, ~] = stft(cla, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 1, true);
%     [W, H] = nmf_all(2, V, K, 1e-4, 1000, 5000);
    W_cla_dic = [W_cla_dic W];
end


% validation
for i = 1 : length(listOfValid)
    if isempty(strfind(listOfValid{i}, '_mix.wav')), continue; end
    
    [test, fs] = audioread(listOfValid{i});
    [s, ~, ~] = stft(test, w, h, nfft, fs);
    V = abs(s);
    [W_vio, H_vio] = nmf_all(1, V, K, MAXITER, 1, false, W_vio_dic);
    [W_cla, H_cla] = nmf_all(1, V, K, MAXITER, 1, false, W_cla_dic);

    phi = angle(s);
    
    XmagHat = W_vio * H_vio;
    xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
    [~, fn, ~] = fileparts(listOfValid{i});
    fn = strrep(fn, '_mix', '_vio_est');
    ans_file = fullfile(PATH_VALID, [fn '.wav']);
    audiowrite(ans_file, xhat, fs);

    XmagHat = W_cla * H_cla;
    xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
    [~, fn, ~] = fileparts(listOfValid{i});
    fn = strrep(fn, '_mix', '_cla_est');
    ans_file = fullfile(PATH_VALID, [fn '.wav']);
    audiowrite(ans_file, xhat, fs);
end

% function [SDR, SIR, SAR, perm] = bss_eval_sources(se, s)
MixFiles = cell(1, 1);
ClaSDRs = [];
ClaSIRs = [];
ClaSARs = [];
VioSDRs = [];
VioSIRs = [];
VioSARs = [];
Filect = 1;
j = 1;
for i = 2 : 3 : length(listOfValid) % iter truth, i-1 = cla, i+1 = vio
    [~, fn, ~] = fileparts(listOfValid{i});
    MixFiles{1, Filect} = fullfile([fn '.wav']);
    Filect = Filect + 1;
    
    % cla, cla_est
    cla = audioread(listOfValid{i-1});
    cla_est = audioread(listOfValidPred{j});
    cla = cla(1:length(cla_est), 1);
    
    % vio, vio_est
    vio = audioread(listOfValid{i+1});
    vio_est = audioread(listOfValidPred{j+1});
    vio = vio(1:length(vio_est), 1);
    j = j + 2;
    
    [sdr, sir, sar, ~] = bss_eval_sources([cla_est'; vio_est'], [cla'; vio']);
    ClaSDRs = [ClaSDRs sdr(1, 1)];
    ClaSIRs = [ClaSIRs sir(1, 1)];
    ClaSARs = [ClaSARs sar(1, 1)];

    VioSDRs = [VioSDRs sdr(2, 1)];
    VioSIRs = [VioSIRs sir(2, 1)];
    VioSARs = [VioSARs sar(2, 1)];

end
disp_evaluation(MixFiles, ClaSDRs, ClaSIRs, ClaSARs, VioSDRs, VioSIRs, VioSARs);

%% R4: Source Separation: Test
clearvars -except PATH_AUDIO PATH_TRAIN PATH_TEST_ANS PATH_VALID PATH_HOME...
                  listOfTest listOfValid listOfTrainVio listOfTrainCla listOfValidPred
w = 1024;
h = 256;
nfft = w;
K = 15; % number of templates (basis vectors)
MAXITER = 400; % maximum number of iterations to run
% [cla64_W_EU, cla64_H_EU] = nmf_all(2, cla64_V, K, 1e-7, 1000, 5000);
% train violin dictionary
W_vio_dic = [];
for i=1 : length(listOfTrainVio)
    [vio, fs] = audioread(listOfTrainVio{i});
    [s, ~, ~] = stft(vio, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 2, true);
%     [W, H] = nmf_all(2, V, K, 1e-4, 1000, 5000);
    W_vio_dic = [W_vio_dic W];
end

% train clarinet dictionary
W_cla_dic = [];
for i=1 : length(listOfTrainCla)
    [cla, fs] = audioread(listOfTrainCla{i});
    [s, ~, ~] = stft(cla, w, h, nfft, fs);
    V = abs(s);
    [W, H] = nmf_all(1, V, K, MAXITER, 2, true);
%     [W, H] = nmf_all(2, V, K, 1e-4, 1000, 5000);
    W_cla_dic = [W_cla_dic W];
end

% testing
for i=1 : length(listOfTest)
    [test, fs] = audioread(listOfTest{i});
    [s, ~, ~] = stft(test, w, h, nfft, fs);
    V = abs(s);
    [W_vio, H_vio] = nmf_all(1, V, K, MAXITER, 2, false, W_vio_dic);
    [W_cla, H_cla] = nmf_all(1, V, K, MAXITER, 2, false, W_cla_dic);

    phi = angle(s);

    XmagHat = W_vio * H_vio;
    xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
    [~, fn, ~] = fileparts(listOfTest{i});
    fn = strrep(fn, '_mix', '_vio_est');
    ans_file = fullfile(PATH_TEST_ANS, [fn '.wav']);
    audiowrite(ans_file, xhat, fs);

    XmagHat = W_cla * H_cla;
    xhat = real(invmyspectrogram(XmagHat .* exp(1i * phi), h))';
    [~, fn, ~] = fileparts(listOfTest{i});
    fn = strrep(fn, '_mix', '_cla_est');
    ans_file = fullfile(PATH_TEST_ANS, [fn '.wav']);
    audiowrite(ans_file, xhat, fs);
end
