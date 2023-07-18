function predict_label = Expand(T, R, T_labels,R_labels)
train_label = T_labels;
train_data = T;
test_label = R_labels;
test_data = R;
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
%% 用格形方法进行参数选择
cmin = -5; cmax = 5;%寻优范围
gmin = -5; gmax = 5;
c_T= -5;
g_T= -15;
para1=['-c ',num2str(2^c_T),' -g ',num2str(2^g_T),' -v 5'];
model_T = svmtrain(train_label, train_data,para1);

%% 此处为前面设置的搜索范围，根据不同的检测速度会有不同的设置
for  c=cmin:cmax
    for g=gmin:gmax
        para1=['-c ',num2str(2^c),' -g ',num2str(2^g),' -v 5'];
        disp([c,g])
        model = svmtrain(train_label, train_data,para1); %此处model值即为交叉校验的平均正确率
        if model>model_T
            model_T=model;
            c_T=c;
            g_T=g;
        else if (model==model_T)&&((c^2+g^2)<(c_T^2+g_T^2))
                c_T=c; 
                g_T=g;
            end
        end

    end
end
%% 利用寻优后的参数再次进行训练，并显示参数
para1=['-c ',num2str(2^c_T),' -g ',num2str(2^g_T),' -b 1'];
model = svmtrain(train_label, train_data,para1);
disp(para1)
model_T;
%% 将该训练集作为测试集导入
[FeatureCnt] = size(R,2);
%% 对待测试的数据用模型参数归一化
for i=1:FeatureCnt
    test_data(:,i)=(A(i).*test_data(:,i)+B(i));
end;
%% 开始测试
para2='-b 1';
[predict_label, accuracy, prob_estimates] = ...
    svmpredict(test_label, test_data, model,para2);

save svmmodel.mat 
end