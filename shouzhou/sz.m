clc;
clear;
load fisheriris

data = meas;
%��ԭʼ���ݽ��й�һ������
data=mapminmax(meas,0,1);
%n����������pΪ����ά����kΪ������
[n,p]=size(data);

K=8;D=zeros(K,2);
for k=2:K
    
[lable,c,sumd,d]=kmeans(data,k,'dist','sqeuclidean');
% data��n��pԭʼ��������
% lable��n��1��������������ǩ��
% c��k��p������k���������ĵ�λ��
% sumd��k��1������������е���������ĵ����֮��
% d��n��k������ÿ������������ĵľ���
sse1 = sum(sumd.^2);
D(k,1) = k;
D(k,2) = sse1;
end

plot(D(2:end,1),D(2:end,2))
hold on;
plot(D(2:end,1),D(2:end,2),'or');

title('��ͬKֵ����ƫ��ͼ') 
xlabel('������(Kֵ)') 
ylabel('�������ƽ����') 

