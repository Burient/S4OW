clear all ;
close all ;
clc ;
path_SVM = [cd '\libsvm-3.20\windows\'] ;
addpath(path_SVM) ;
addpath('Filter');
addpath('Functions');
load Nikon_D200(2).mat
traindata = fea_all;
[N D] = size(fea_all);
randvector = randperm(N);
testData1 = traindata(randvector(1:100),:);
trainData = traindata(randvector(101:end),:);
trainLabel = ones(size(trainData,1),1);
load 'Agfa_DC-504_0.mat' 
testData2=fea_all(1:100,:);
load('Sony_DSC-W170(2).mat')
testData3=fea_all(1:100,:);
load('Agfa_DC-830i_0.mat')
testData4=fea_all(1:100,:);
load('Sony_DSC-H50(2).mat')
testData5=fea_all(1:100,:);
load Nikon_D70(2).mat
testData6=fea_all(1:100,:);
load Agfa_DC-733s_0.mat
testData7=fea_all(1:100,:);
testData=[testData1;testData2;testData3;testData4;testData5;testData6;testData7];
testLabell=ones(100,1);
testLabel2=ones(600,1)*(-1); 
testLabel= [testLabell;testLabel2];

train_label = trainLabel;
train_data = trainData;
test_label = testLabel;
test_data = testData;
% train_1 = fea_all;
% X_1 = train_1;
% train_group1 = ones(size(X_1,1),1); 
% accuracyS = [] ;
% totalEpoch =20 ;
% tic;
% [N D] = size(X_1);
% 
% % load Agfa_DC-504_0.mat
% % Y_1 = fea_all;
% % train_group2 = ones(273,1)*2; 
% % [W K] = size(Y_1);
% for indexOfEpoch = 1:1:totalEpoch     %循环20次
%     % 随机抽取样本
%     randvector = randperm(N);
%     X_trn = X_1(randvector(1:384),:);
%     Y_trn = train_group1(randvector(1:384));
% %     randvector_1 = randperm(N);
%     X_tst = X_1(randvector(385:end),:);
%     Y_tst = train_group1(randvector(385:end));
%     train_data =X_trn;
%     train_label = Y_trn;
%     test_data =X_tst;
%     test_label =Y_tst ;
 %% 对每组特征归一化
FeatureCnt = size(train_data,2);
A=zeros(FeatureCnt,1);
B=zeros(FeatureCnt,1);
for i=1:FeatureCnt  
    temp=train_data(:,i); 
    Max=max(temp);
    Min=min(temp);
    A(i)=1/(Max-Min);
    B(i)=Min/(Min-Max);
    train_data(:,i)=A(i).*train_data(:,i)+B(i);
end;

%参数寻优
[c,g] = meshgrid(-10:0.2:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 1;
bestg = 0.1;
bestacc = 0;
for i = 1:m
    for j = n:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j)),' -s 2', ' -n 0.5'];
        cg(i,j) = svmtrain(train_label,train_data,cmd);     
         if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end        
        if abs( cg(i,j)-bestacc )<=eps && bestc > 2^c(i,j) 
            bestacc = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -n 0.5',' -s 2'];
model = svmtrain(train_label,train_data,cmd);
disp(cmd)
model 


%% 读入待测图像特征
[FeatureCnt] = size(test_data ,2);
%% 对待测试的数据用模型参数归一化
for i=1:FeatureCnt
    test_data(:,i)=(A(i).*test_data(:,i)+B(i));
end;
%% 开始测试
para2='-b 0';
[predict_label, accuracy, prob_estimates] = ...
    svmpredict(test_label, test_data, model,para2);
% end
save ocsvmbf_result.mat




