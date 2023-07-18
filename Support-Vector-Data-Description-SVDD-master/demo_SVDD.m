%{
    SVDD application for positive training data
%}

%%
clear all
clc
addpath(genpath(pwd))

%% load training data and testing data
% load('.\data\demoData.mat')
load('Canon_Ixus70(3)cfa.mat')
global trainData trainLabel
trainData=fea_all(1:384,:);
trainLabel=ones(384,1);
testData1=fea_all(385:end,:);
load('Agfa_DC-504_0cfa.mat')
testData2=fea_all(1:10,:);
testData=[testData1;testData2];
testLabel=ones(174,1);

%% creat an SVDD object
SVDD = Svdd('positiveCost', 0.9,...
            'kernel', Kernel('type', 'gauss', 'width', 16),...
            'option', struct('display', 'on'));
        
%% train and test SVDD model
% train an SVDD model 
model = SVDD.train(trainData, trainLabel);

% test the SVDD model
result = SVDD.test(model,testData, testLabel);

%% Visualization
% plot the curve of testing result
Visualization.plotTestResult(model, result)





