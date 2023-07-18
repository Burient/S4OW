%{
    SVDD application for positive training data
%}

%%
clear all
clc
addpath(genpath(pwd))

%% load training data and testing data
% load('.\data\demoData.mat')
%testdata含手动打的标签，后续训练记得要除去此标签列
load fea9CFA.mat
traindata = fea;
[N D] = size(fea);
randvector = randperm(N);
testData1 = traindata(randvector(1:82),(2:end));
testdata1 = [zeros(82,1),testData1];
trainData = traindata(randvector(83:end),(2:end));
trainLabel = ones(size(trainData,1),1);
load 'fea1CFA.mat'
testData2=fea((1:82),(2:end));
testdata2 = [ones(82,1)*(-1),testData2];
load('fea10CFA.mat')
testData3=fea((1:82),(2:end));
testdata3 = [ones(82,1)*(-2),testData3];
load('fea3CFA.mat' )
testData4=fea((1:82),(2:end));
testdata4 = [ones(82,1)*(-3),testData4];
load fea2CFA.mat
testData5=fea((1:82),(2:end));
testdata5 = [ones(82,1)*(-4),testData5];
load fea4CFA.mat
testData6=fea((1:82),(2:end));
testdata6 = [ones(82,1)*(-5),testData6];
load fea6CFA.mat
testData7=fea((1:82),(2:end));
testdata7 = [ones(82,1)*(-6),testData7];
load fea7CFA.mat
testData8=fea((1:82),(2:end));
testdata8 = [ones(82,1)*(-7),testData8];
load fea5CFA.mat
testData9=fea((1:82),(2:end));
testdata9 = [ones(82,1)*(-8),testData9];
load fea8CFA.mat
testData10=fea((1:82),(2:end));
testdata10 = [ones(82,1)*(-9),testData10];
% load Samsung_L74wide(3).mat
% testData11=fea_all(1:100,:);
% load Samsung_NV15(3).mat
% testData12=fea_all(1:100,:);
% load Pentax_OptioA40(4).mat
% testData13=fea_all(1:100,:);
% load FujiFilm_FinePixJ50(3).mat
% testData14=fea_all(1:100,:);
% load Rollei_RCP-7325XS(3).mat
% testData15=fea_all(1:100,:);
% load Canon_Ixus70(3).mat
% testData16=fea_all(1:100,:);
% load Sony_DSC-H50(2).mat
% testData17=fea_all(1:100,:);
% load Sony_DSC-W170(2).mat
% testData18=fea_all(1:100,:);
% load Agfa_Sensor530s_0.mat
% testData19=fea_all(1:100,:);
% load Nikon_D70(2).mat
% testData20=fea_all(1:100,:);
% load Nikon_D70s(2).mat
% testData21=fea_all(1:100,:);
% load Agfa_DC-733s_0.mat
% testData22=fea_all(1:100,:);
% load Canon_Ixus55_0.mat
% testData23=fea_all(1:100,:);
% load Pentax_OptioW60_0.mat
% testData24=fea_all(1:100,:);
% load Canon_PowerShotA640_0.mat
% testData25=fea_all(1:100,:);
% load Agfa_Sensor505-x_0.mat
% testData26=fea_all(1:100,:);
% load Agfa_DC-830i_0.mat
% testData27=fea_all(1:100,:);
% testData=[testData1;testData2;testData3;testData4;testData5;testData6;testData7;testData8;...
%     testData9;testData10;testData11;testData12;testData13;testData14;...
%     testData15;testData16;testData17;testData18;testData19;testData20;...
%     testData21;testData22;testData23;testData24;testData25;testData26;testData27];
testData=[testData1;testData2;testData3;testData4;testData5;testData6;testData7;testData8;...
    testData9;testData10];
testdata=[testdata1;testdata2;testdata3;testdata4;testdata5;testdata6;testdata7;testdata8;...
    testdata9;testdata10];%for the second part of svm
testLabel1=ones(82,1);
testLabel2=ones(738,1)*(-1); 
testLabel= [testLabel1;testLabel2];

%% creat an SVDD object 16改成了1
SVDD = Svdd('positiveCost', 0.9,...
            'kernel', Kernel('type', 'gauss', 'width',1.2),...
            'option', struct('display', 'on'));
        
%% train and test SVDD model
% train an SVDD model 
model = SVDD.train(trainData, trainLabel);

% test the SVDD model
result = SVDD.test(model,testData, testLabel);

%% Visualization
% plot the curve of testing result
Visualization.plotTestResult(model, result)

save svddbefore.mat