clc;
clear;
load fea5CFA.mat
traindata = fea;
[N D] = size(fea);
randvector = randperm(N);
Testdata1 = traindata(randvector(1:82),(2:end));
Data = traindata(randvector(83:end),(2:end));
k_value = 2; 
[M] = kmeans(Data, k_value);
for i = 1:length(M)
    a = M(i,1);
    if a == 1
    data_1(i,:) = fea(i,:);
    else
    data_2(i,:) = fea(i,:);
%     elseif a==3
%     data_3(i,:) = fea_all(i,:);   
%     else
%     data_4(i,:) = fea_all(i,:);  
%     elseif a==5
%     data_5(i,:) = fea_all(i,:);  
%     else
%     data_6(i,:) = fea_all(i,:);  
% %     elseif a == 7
%     data_7(i,:) = fea_all(i,:);  
%     elseif a == 8
%     data_8(i,:) = fea_all(i,:);  
%     elseif a == 9
%     data_9(i,:) = fea_all(i,:);  
%     else
%     data_10(i,:) = fea_all(i,:);  
    end
end
data_1(all(data_1==0,2),:)=[];
data_2(all(data_2==0,2),:)=[];
% data_3(all(data_3==0,2),:)=[];
% data_4(all(data_4==0,2),:)=[];
% data_5(all(data_5==0,2),:)=[];
% data_6(all(data_6==0,2),:)=[];
% data_7(all(data_7==0,2),:)=[];
% data_8(all(data_8==0,2),:)=[];
% data_9(all(data_9==0,2),:)=[];
% data_10(all(data_10==0,2),:)=[];

%将聚类后的两组数据及对应标签分别进行svdd,并测试，输出预测结果
% predict_label_1 = ocsvm(data_1,Testdata1);
% predict_label_2 = ocsvm(data_2,Testdata1);
% predict_label_3 = ocsvm(data_3,Testdata1);
% predict_label_4 = ocsvm(data_4,Testdata1);
[modela_1,result_1] = svdd(data_1,Testdata1);
[modela_2,result_2] = svdd(data_2,Testdata1);

% [modela_5,result_5] = svdd(data_5,Testdata1);
% [modela_6,result_6] = svdd(data_6,Testdata1);
% [modela_7,result_7] = svdd(data_7,Testdata1);
% [modela_8,result_8] = svdd(data_8,Testdata1);
% [modela_9,result_9] = svdd(data_9,Testdata1);
% [modela_10,result_10] = svdd(data_10,Testdata1);

save result.mat;



 

