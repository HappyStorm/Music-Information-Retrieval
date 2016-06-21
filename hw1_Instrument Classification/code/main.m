% Cheng-Wei Wu 2016/3/24
% Please add MIR-Toolbox, SVM and Auditory Toolbox to Matlab's path

%% default settings
clear; clc; close all;
addpath('../toolbox/MIRToolbox');
addpath('../toolbox/AuditoryToolbox');
addpath('../toolbox/libsvm-3.21/matlab');
PATH_AUDIO = '../audio';
PATH_FEAT = '../feature';

listOfSongsGuitar = listfile(fullfile(PATH_AUDIO,'guitar'))';
listOfSongsViolin = listfile(fullfile(PATH_AUDIO,'violin'))';
listOfSongsPiano = listfile(fullfile(PATH_AUDIO,'piano'))';
listOfSongsVoice = listfile(fullfile(PATH_AUDIO,'voice'))';
listOfSongsTest = listfile(fullfile(PATH_AUDIO,'test'))';
listOfSongsTrain = [listOfSongsGuitar; listOfSongsViolin; listOfSongsPiano; listOfSongsVoice];

%% try to load a file and then plot it
% [a, fs] = wavread(listOfSongsGuitar{1});
% timeInSec = (1:length(a)) / fs;
% plot(timeInSec, a)
% xlabel('time (sec)')

%% try to extract MFCC features for the song
% normalize with respect to RMS energy
a = miraudio(listOfSongsPiano{69}, 'Normal');

% window length 1024 samples, hop size 512 samples
w = 1024;
h = 512;
fa = mirframe(a, 'Length', w, 'sp', 'Hop', h, 'sp');

% compute the spectrogram
Sa = mirspectrum(fa, 'dB', 'Res', 0.1)

% while S is an object, x is the values inside 
mfcc = mirmfcc(Sa,'Rank', 1:20);
mfcc = mirgetdata(mfcc);
feature = [mean(mfcc, 2); std(mfcc ,0, 2)]; % e.g. feature(21) = std(mfcc(1,:))
figure, stem(feature);
% close all

%% try to extract MFCC features for the song

% normalize with respect to RMS energy
b = miraudio(listOfSongsViolin{83}, 'Normal');

% window length 1024 samples, hop size 512 samples
w = 1024;
h = 512;
fb = mirframe(b, 'Length', w, 'sp', 'Hop', h, 'sp');

% compute the spectrogram
Sb = mirspectrum(fb, 'dB', 'Res', 0.1)

% while S is an object, x is the values inside 
x = mirgetdata(Sb); % size: 513 x number of frames
mfcc = mirmfcc(Sb,'Rank', 1:20);
mfcc = mirgetdata(mfcc);
feature = [mean(mfcc, 2); std(mfcc, 0, 2)]; % e.g. feature(21) = std(mfcc(1,:))
figure, stem(feature);
% close all

%% extract MFCC features (original sample code)
clc;
w = 1024;
h = 512;
X = [];

for i = 1 : 800
    disp(i)
    fn = listOfSongsTrain{i};
    x = extractMFCC(fn, w, h);
    % we can either save the extracted features as files
%     [pathstr, fn, ext] = fileparts(fn);
%     if i<=200
%         fn = fullfile(PATH_FEAT,'guitar',[fn '.csv']);
%     elseif i<=400
%         fn = fullfile(PATH_FEAT,'violin',[fn '.csv']);
%     elseif i<=600
%         fn = fullfile(PATH_FEAT,'piano',[fn '.csv']);
%     else
%         fn = fullfile(PATH_FEAT,'voice',[fn '.csv']);
%     end
%     csvwrite(fn, x);
    
    % or we simply use a big matrix to keep them
    X = [X; x'];
end
% save X X    % save it if you want

% extract the features for the test set by the way
% make sure you use the same features for the training and test sets
Xtest = [];
for i = 1 : 200    
    disp(i)
    fn = listOfSongsTest{i};
    x = extractMFCC(fn, w, h);
    Xtest = [Xtest; x'];
end
% save Xtest Xtest  

% set the groundtruth
% 1: guitar 
% 2: violin
% 3: piano
% 4: voice
Y = [ones(200, 1); 2*ones(200, 1); 3*ones(200, 1); 4*ones(200, 1)];
% save Y Y 

% clear some variables to keep the work space neat
clearvars -except X Y Xtest listOfSongsTrain listOfSongsTest

%% extract Features
clc;
w = 1024;
h = 512;
X = [];

for i = 1 : 800
    disp(i)
    fn = listOfSongsTrain{i};
    mfcc = extract_features(fn, w, h, 'mfcc_train_20');
%     bright = extract_features(fn, w, h, 'brightness');
%     zcross = extract_features(fn, w, h, 'zerocross');
%     entro = extract_features(fn, w, h, 'entropy');
%     roll = extract_features(fn, w, h, 'rolloff');
%     rough = extract_features(fn, w, h, 'roughness');
%     cent = extract_features(fn, w, h, 'centroid');
%     ir = extract_features(fn, w, h, 'irregularity');
%     kt = extract_features(fn, w, h, 'kurtosis');
%     sk = extract_features(fn, w, h, 'skewness');

%     X = [X; mfcc' roll' zcross' entro' bright' kt'];
%     X = [X; mfcc' roll' zcross' entro' bright'];
%     X = [X; mfcc' roll' zcross' entro'];
%     X = [X; mfcc' roll' entro'];
%     X = [X; mfcc' roll'];
%     X = [X; bright'];
%     X = [X; zcross'];
%     X = [X; roll'];
%     X = [X; cent'];
%     X = [X; entro'];
    X = [X; mfcc'];
%     X = [X; rough'];
%     X = [X; ir'];
%     X = [X; kt'];
%     X = [X; sk'];
end
% save X X    % save it if you want

% extract the features for the test set by the way
% make sure you use the same features for the training and test sets
Xtest = [];
for i = 1 : 200    
    disp(i)
    fn = listOfSongsTest{i};
    mfcc = extract_features(fn, w, h, 'mfcc_train_20');
%     bright = extract_features(fn, w, h, 'brightness');
%     zcross = extract_features(fn, w, h, 'zerocross');
%     entro = extract_features(fn, w, h, 'entropy');
%     roll = extract_features(fn, w, h, 'rolloff');
%     rough = extract_features(fn, w, h, 'roughness');
%     cent = extract_features(fn, w, h, 'centroid');
%     ir = extract_features(fn, w, h, 'irregularity');
%     kt = extract_features(fn, w, h, 'kurtosis');
%     sk = extract_features(fn, w, h, 'skewness');
   
%     Xtest = [Xtest; mfcc' roll' zcross' entro' bright' kt'];
%     Xtest = [Xtest; mfcc' roll' zcross' entro' bright'];
%     Xtest = [Xtest; mfcc' roll' zcross' entro'];
%     Xtest = [Xtest; mfcc' roll' entro'];
%     Xtest = [Xtest; mfcc' roll'];
%     Xtest = [Xtest; bright'];
%     Xtest = [Xtest; zcross'];
%     Xtest = [Xtest; roll'];
%     Xtest = [Xtest; cent'];
%     Xtest = [Xtest; entro'];
    Xtest = [Xtest; mfcc'];
%     Xtest = [Xtest; rough'];
%     Xtest = [Xtest; ir'];
%     Xtest = [Xtest; kt'];
%     Xtest = [Xtest; sk'];
end
% save Xtest Xtest


% set the groundtruth
% 1: guitar 
% 2: violin
% 3: piano
% 4: voice
Y = [ones(200, 1); 2*ones(200, 1); 3*ones(200, 1); 4*ones(200, 1)];
% save Y Y 

% clear some variables to keep the work space neat
clearvars -except X Y Xtest listOfSongsTrain listOfSongsTest;

%% split the data into training and validation (note: this is not cross validation)
clc;
% accSum = 0;
% Testing = 1;
% bestAccuraccy = 0;
% while bestAccuraccy < 92

nValidation = floor(size(X, 1) / 5); % use 20% of the data for validation
% nValidation = floor(size(X, 1) / 8); % use 12.5% of the data for validation
% nValidation = floor(size(X, 1) / 4); % use 25% of the data for validation

nTrain = size(X, 1) - nValidation;
nTest = size(Xtest, 1);

rp = randperm(800); % generate a random permutation
indexValidation = rp(1 : nValidation);
indexTrain = rp(nValidation + 1 : end);

Xvalidation = X(indexValidation, :);
Yvalidation = Y(indexValidation, :);
Xtrain = X(indexTrain, :);
Ytrain = Y(indexTrain, :);

%% feature normalization

% the values for normalization are computed from the training set
    featMean = mean(Xtrain);
    featSTD = std(Xtrain);

    % then apply to the training, validation, and test sets
    Xtrain = (Xtrain - repmat(featMean, nTrain, 1)) ./ (repmat(featSTD, nTrain, 1) + eps);
    Xvalidation = (Xvalidation - repmat(featMean, nValidation, 1)) ./ (repmat(featSTD, nValidation, 1) + eps);
    
% if Testing==1
%     disp(times)
    Xtest = (Xtest - repmat(featMean, nTest, 1)) ./ (repmat(featSTD, nTest, 1) + eps);
% end

% %% train the classifier
% svmtrain
% svmpredict

Cs = [0.1 1 10 100 1000 10000]; % possible range of the parameter C
g0 = 1/size(X, 2);
Gs = [g0 g0/10 g0/100 g0/1000 g0/10000]; % possible range of the parameter gamma

% default
bestAccuraccy = 0.25;
bestModel = {};
bestC = nan;
bestG = nan;

for c=1:length(Cs)
    for g=1:length(Gs)
        
%         model = svmtrain(Ytrain, Xtrain, sprintf('-t 2 -c %f -g %f', Cs(c), Gs(g)));
        model = svmtrain(Ytrain, Xtrain, sprintf('-t 2 -c %f -g %f -q', Cs(c), Gs(g))); % quiet mode
        % actually, you can also use svmtrain(...,'-v 5') to implement 5-fold 
        % cross validation, but we are not using that in this code
        
        % Yvaliation is the groundtruth
        % Ypred is the prediction result
        [Ypred, accuracy, ~] = svmpredict(Yvalidation, Xvalidation, model, '-q');
%         [Ypred, accuracy, ~] = svmpredict(Yvalidation, Xvalidation, model);

        accuracy = accuracy(1); % the first one correponds to classification accuracy
                                % accuracy = sum(Ypred==Yvalidation)/length(Yvalidation)
%         disp(sprintf('c=%f g=%f accuracy=%f', Cs(c), Gs(g), accuracy))

        if accuracy > bestAccuraccy
            bestAccuraccy = accuracy;
            bestModel = model;
            bestC = Cs(c);
            bestG = Gs(g);
        end
    end
end
%     disp(sprintf('c=%f g=%f accuracy=%f', Cs(c), Gs(g), bestAccuraccy));

%     accSum = accSum + bestAccuraccy;
%     disp(sprintf('c=%f g=%f \t # %2d Accuracy=%f', bestC, bestG, times, bestAccuraccy));
%     disp(sprintf('c=%f g=%f \t # %2d Accuracy=%f', bestC, bestG, Testing, bestAccuraccy));
%     Testing = Testing + 1;
% end
% disp(sprintf('Mean Accuracy=%f\n\n', accSum/25));

% from Ypred and Yvalidation you can create the confusion tlabe
[Ypred, accuracy, ~] = svmpredict(Yvalidation, Xvalidation, bestModel);
ConfusionTable = zeros(4, 4);
for i = 1:size(Ypred, 1)
    ConfusionTable(Yvalidation(i), Ypred(i)) = ConfusionTable(Yvalidation(i), Ypred(i)) + 1;
end

%% apply the classifier to the test data, and save the result as a csv file
% we don't know the answer, so use all zeros for the testing_label_vector
YtestPred = svmpredict(zeros(nTest,1), Xtest, bestModel, '-q');
csvwrite('YtestPred_MyAns_93.125.csv', YtestPred);

