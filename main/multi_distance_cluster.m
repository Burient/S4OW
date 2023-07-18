clc;
clear;
load svddbefore.mat
%%
% %此代码段使用了判别标签后的样本集合，正确率较高
% predictedlabel_bf = getfield(result,'predictedlabel') ;
% testlabel_bf = getfield(result,'testLabel') ;
% for i = 1 : length(testlabel_bf)
%  if (testlabel_bf(i)+predictedlabel_bf(i))==(2)
%      data_known(i,:) = testdata(i,:);
%  else 
%      data_unknown(i,:) =  testdata(i,:);
%  end
% end
% data_known(all(data_known==0,2),:)=[];
% 
% data_unknown(all(data_unknown==0,2),:)=[];
%% 此代码段直接使用before.m的判断结果为训练样本集合
predictedlabel_bf = getfield(result,'predictedlabel') ;
testlabel_bf = getfield(result,'testLabel') ;
for i = 1 : length(testlabel_bf)
 if predictedlabel_bf(i)== 1
     data_known(i,:) = testdata(i,:);
 else 
     data_unknown(i,:) =  testdata(i,:);
 end
end
data_known(all(data_known==0,2),:)=[];
data_unknown(all(data_unknown==0,2),:)=[];
%%

k_value = 9; 
[M1] = kmeans_1(data_unknown, k_value);
[M2] = kmeans_2(data_unknown, k_value);
% [M3] = kmeans_3(data_unknown, k_value);
% M = [M1].^2 + [M2].^2;
M = [M1].*10 + [M2];
B = tabulate(M(:));%统计M中的数据
b=sortrows(B,-2);%按照count降序排列
value_A=b(:,1);
% count_A=B(:,2);
% percent_A=B(:,3);
a1=1;a2=1;a3=1;a4=1;a5=1;a6=1;a7=1;a8=1;a9=1;%分别为前9类的频数个数
f= 1;%置信度低的可疑图像的总数
for j = 1 : length(M)
    if M(j,1) == b(1,1)
        data_1(a1,:) = data_unknown(j,:);
        a1 = a1 + 1;
    elseif M(j,1) == b(2,1) 
        data_2(a2,:) = data_unknown(j,:);
        a2 = a2 + 1;
    elseif M(j,1) == b(3,1) 
        data_3(a3,:) = data_unknown(j,:);
        a3 = a3 + 1;
    elseif M(j,1) == b(4,1) 
        data_4(a4,:) = data_unknown(j,:);
        a4 = a4 + 1;
    elseif M(j,1) == b(5,1) 
        data_5(a5,:) = data_unknown(j,:);
        a5 = a5 + 1;
    elseif M(j,1) == b(6,1) 
        data_6(a6,:) = data_unknown(j,:);
        a6 = a6 + 1;
    elseif M(j,1) == b(7,1) 
        data_7(a7,:) = data_unknown(j,:);
        a7 = a7 + 1;
    elseif M(j,1) == b(8,1) 
        data_8(a8,:) = data_unknown(j,:);
        a8 = a8 + 1;
    elseif M(j,1) == b(9,1) 
        data_9(a9,:) = data_unknown(j,:);
        a9 = a9 + 1;
    else
        data_10(f,:) = data_unknown(j,:);
        f = f + 1;
    end
end
P = [data_1(:,(2:end));data_2(:,(2:end));data_3(:,(2:end));data_4(:,(2:end));
    data_5(:,(2:end));data_6(:,(2:end));data_7(:,(2:end));data_8(:,(2:end));data_9(:,(2:end))];
P_labels = [-data_1(:,1);-data_2(:,1);-data_3(:,1);-data_4(:,1);-data_5(:,1);-data_6(:,1);-data_7(:,1);-data_8(:,1);-data_9(:,1)];
T = [P; data_known(:,(2:end))];
T_labels_earth = [P_labels;-data_known(:,1)];%真实标签

%% 制作用于后面svm中训练集的标签
T_labels = [ones(a1-1,1); 2*ones(a2-1,1); 3*ones(a3-1,1); 4*ones(a4-1,1); 5*ones(a5-1,1); 6*ones(a6-1,1);
    7*ones(a7-1,1); 8*ones(a8-1,1); 9*ones(a9-1,1); 0*ones(size(data_known,1),1)];
R = data_10(:,(2:end));
R_labels = -data_10(:,1);
predict_label_expension = Expand(T, R, T_labels,R_labels);
save mult_dis.mat;