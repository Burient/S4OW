% RPCL, rival penalized competitive learning���Ľ����Kmeans
% ����http://www.cs.hmc.edu/~asampson/ap/ap.git��ֲ������������RPCLԭ�Ľ������޸�
 
clear;
close all;
 
iter_num = 10; % ����������
%load 'stimuli.txt';
%data = stimuli; clear stimuli;
%load 'dita.txt';
%data=dita; clear dita;
% load 'data.txt';
load fisheriris 
data = meas;
sample_num = size(data, 1);
sample_dimension = size(data, 2);
 
learning_rate = 0.1;
K=20; %��������
cluster_wins = zeros(K,1);
clusters = zeros(K, sample_dimension);
minVal = min(data); % ��ά�ȼ�����Сֵ
maxVal = max(data); % ��ά�ȼ������ֵ
% ��ʼ�����ġ�����DLZhu�Ľ��飬Ҫ�����������������ɴ��ġ�
for i=1:K
   %clusters(i,:) = [rand(), rand()]; % [0,1]x[0,1]ƽ���ϵ�ɢ��
   clusters(i, :) = minVal + (maxVal - minVal) * rand();
%    clusters(i,:) = mypkg.genOutRand(minVal, maxVal);
   cluster_wins(i) = 0;
end
% clusters = [
%     [0.58900736, 0.8727472];
%     [0.42491971, 0.31954921];
%     [0.90917136, 0.70537815];
%     [0.1836478,  0.2356091];
%     [0.53538985, 0.35172357];
%     [0.01189786,  0.98610582]
% ];
 
figure;
scatter(data(:,1), data(:,2));
hold on;
scatter(clusters(:,1), clusters(:,2), 'red', 'filled');
title('ԭʼ����:��Ȧ����ʼ���ģ����');
 
c = zeros(sample_num, 1); % ÿ�����������������ı��
 
cluster_colors = [
    [0 0 1]; % blue
    [1 0 0]; % red
    [0 1 0]; % green
    [1 0 1]; % magenta
    [0 1 1]; % cyan
    [1 1 0]; % yellow
    ];
 
for iter=1:iter_num
    progress = iter / iter_num;
    indexes = randperm(sample_num); % ����˳���һ���������
    for h=1:sample_num
        i=indexes(h);
       
        % ����clusters���ҵ���data(j,:)������Ǹ�(winner)���Լ��ڶ�����(rival)
        gg = zeros(K,1);
        for j=1:K
            tt = norm(clusters(j,:) - data(i,:));
            gg(j) = tt * cluster_wins(j);
        end
       
        % �ҳ�winner���ģ�����gg(`)ֵ��С
        winner_idx = 1;
        min_val = gg(1);
        for j=1:K
            if (gg(j)<min_val)
                min_val = gg(j);
                winner_idx = j;
            end
        end
        % winner = clusters(winner_idx,:);
       
        % �ҳ�winner���ģ�����gg(`)ֵ�ڶ�С
        rival_idx = 1;
        min_val = gg(1)+gg(2);  %ȡǰ��Ԫ�صĺͣ���Ϊ�˱���gg(1)����winner
        for j=1:K
            if (j==winner_idx)
                continue;
            end
            if (gg(j)<min_val)
                min_val = gg(j);
                rival_idx = j;
            end
        end
        % rival = clusters(rival_idx,:);
       
        cluster_wins(winner_idx) = cluster_wins(winner_idx) + 1;
        c(i) = winner_idx;
       
        % ����winner��learn
        winner_learning_rate = learning_rate;
        clusters(winner_idx,:) = clusters(winner_idx,:) + winner_learning_rate*(data(i,:)-clusters(winner_idx,:));
        
       
        % ����rival, de-learn
        % learn(rival, stimulus, -0.8 * self.learning_rate)
        rival_learning_rate = -0.8 * learning_rate;
        clusters(rival_idx,:) = clusters(rival_idx,:) + rival_learning_rate*(data(i,:)-clusters(rival_idx,:));
       
    end
   
    %if(rem(iter,10)~=0)
    %    continue;
    %end
    huck = figure;
    %for j=1:sample_num
    %    hold on;
    %    % plot(data(j,1), data(j,2), 'b--x', 'Color', cluster_colors(c(j),:), 'LineWidth', 2);
    %    plot([data(j,1), clusters(c(j),1)], [data(j,2), clusters(c(j),2)], 'Color', 'blue', 'Marker', 'o', 'MarkerFaceColor', cluster_colors(c(j),:), 'MarkerSize', 3);
    %end
    scatter(data(:,1), data(:,2));
    hold on;
    scatter(clusters(:,1), clusters(:,2), 'filled'); % ʵ��Բ�㣬��ʾ���ĳ�ʼλ��
    title(['��', num2str(iter), '�ε���']);
    waitfor(huck);
end
 
disp('==========================');
final_c = unique(c);
final_clusters = clusters(final_c,:);
disp(final_clusters);
 
 
disp('Done.');
 
 