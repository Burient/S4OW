function predict_label = Expand(T, R, T_labels,R_labels)
train_label = T_labels;
train_data = T;
test_label = R_labels;
test_data = R;
%% ��ÿ��������һ��
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
%% �ø��η������в���ѡ��
cmin = -5; cmax = 5;%Ѱ�ŷ�Χ
gmin = -5; gmax = 5;
c_T= -5;
g_T= -15;
para1=['-c ',num2str(2^c_T),' -g ',num2str(2^g_T),' -v 5'];
model_T = svmtrain(train_label, train_data,para1);

%% �˴�Ϊǰ�����õ�������Χ�����ݲ�ͬ�ļ���ٶȻ��в�ͬ������
for  c=cmin:cmax
    for g=gmin:gmax
        para1=['-c ',num2str(2^c),' -g ',num2str(2^g),' -v 5'];
        disp([c,g])
        model = svmtrain(train_label, train_data,para1); %�˴�modelֵ��Ϊ����У���ƽ����ȷ��
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
%% ����Ѱ�ź�Ĳ����ٴν���ѵ��������ʾ����
para1=['-c ',num2str(2^c_T),' -g ',num2str(2^g_T),' -b 1'];
model = svmtrain(train_label, train_data,para1);
disp(para1)
model_T;
%% ����ѵ������Ϊ���Լ�����
[FeatureCnt] = size(R,2);
%% �Դ����Ե�������ģ�Ͳ�����һ��
for i=1:FeatureCnt
    test_data(:,i)=(A(i).*test_data(:,i)+B(i));
end;
%% ��ʼ����
para2='-b 1';
[predict_label, accuracy, prob_estimates] = ...
    svmpredict(test_label, test_data, model,para2);

save svmmodel.mat 
end