function [model,result] = svdd(data_1,Testdata1)
trainData = data_1(:,(2:end));
trainLabel = ones(size(trainData,1),1);
testData1 = Testdata1;
load 'fea10CFA.mat'
testData2=fea((1:82),(2:end));
load('fea1CFA.mat')
testData3=fea((1:82),(2:end));
load('fea3CFA.mat' )
testData4=fea((1:82),(2:end));
load fea4CFA.mat
testData5=fea((1:82),(2:end));
load fea2CFA.mat
testData6=fea((1:82),(2:end));
load fea6CFA.mat
testData7=fea((1:82),(2:end));
load fea7CFA.mat
testData8=fea((1:82),(2:end));
load fea8CFA.mat
testData9=fea((1:82),(2:end));
load fea9CFA.mat
testData10=fea((1:82),(2:end));
% load Kodak_M1063(5).mat
% testData2=fea_all(1:100,:);
% load('Olympus_mju_1050SW(5).mat')
% testData3=fea_all(1:100,:);
% load('Praktica_DCZ5_9(5).mat')
% testData4=fea_all(1:100,:);
% load('Panasonic_DMC-FZ50(3).mat')
% testData5=fea_all(1:100,:);
% load Casio_EX-Z150(5).mat
% testData6=fea_all(1:100,:);
% load Nikon_CoolPixS710(5).mat
% testData7=fea_all(1:100,:);
% load Ricoh_GX100(5).mat
% testData8=fea_all(1:100,:);
% load Nikon_D200(2).mat
% testData9=fea_all(1:100,:);
% load Sony_DSC-T77(4).mat
% testData10=fea_all(1:100,:);
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
testLabel1=ones(82,1);
testLabel2=ones(738,1)*(-1); 
testLabel= [testLabel1;testLabel2];

%% creat an SVDD object                 
SVDD = Svdd('positiveCost', 0.7,...
            'negativeCost', 0.9,...
            'kernel', Kernel('type', 'gauss', 'width', 1.9));
        
%% train and test SVDD model
% train an SVDD model 
model = SVDD.train(trainData, trainLabel);

% test SVDD model
result = SVDD.test(model,testData,testLabel);

%% Visualization
% plot the curve of testing result
Visualization.plotTestResult(model, result)
% plot the ROC curve
% Visualization.plotROC(testLabel, result.distance);
% plot the decision boundary
% Visualization.plotDecisionBoundary(SVDD, model, trainData, trainLabel);