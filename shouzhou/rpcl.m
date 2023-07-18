% RPCL, rival penalized competitive learning，改进版的Kmeans
% 根据http://www.cs.hmc.edu/~asampson/ap/ap.git移植而来，并根据RPCL原文进行了修改
 
clear;
close all;
 
iter_num = 10; % 最多迭代次数
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
K=20; %簇心数量
cluster_wins = zeros(K,1);
clusters = zeros(K, sample_dimension);
minVal = min(data); % 各维度计算最小值
maxVal = max(data); % 各维度计算最大值
% 初始化簇心。根据DLZhu的建议，要在数据区域外面生成簇心。
for i=1:K
   %clusters(i,:) = [rand(), rand()]; % [0,1]x[0,1]平面上的散点
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
title('原始数据:蓝圈；初始簇心：红点');
 
c = zeros(sample_num, 1); % 每个样本数据所属簇心编号
 
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
    indexes = randperm(sample_num); % 样本顺序的一个随机排序
    for h=1:sample_num
        i=indexes(h);
       
        % 遍历clusters，找到和data(j,:)最近的那个(winner)，以及第二近的(rival)
        gg = zeros(K,1);
        for j=1:K
            tt = norm(clusters(j,:) - data(i,:));
            gg(j) = tt * cluster_wins(j);
        end
       
        % 找出winner簇心，它的gg(`)值最小
        winner_idx = 1;
        min_val = gg(1);
        for j=1:K
            if (gg(j)<min_val)
                min_val = gg(j);
                winner_idx = j;
            end
        end
        % winner = clusters(winner_idx,:);
       
        % 找出winner簇心，它的gg(`)值第二小
        rival_idx = 1;
        min_val = gg(1)+gg(2);  %取前两元素的和，是为了避免gg(1)就是winner
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
       
        % 对于winner，learn
        winner_learning_rate = learning_rate;
        clusters(winner_idx,:) = clusters(winner_idx,:) + winner_learning_rate*(data(i,:)-clusters(winner_idx,:));
        
       
        % 对于rival, de-learn
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
    scatter(clusters(:,1), clusters(:,2), 'filled'); % 实心圆点，表示簇心初始位置
    title(['第', num2str(iter), '次迭代']);
    waitfor(huck);
end
 
disp('==========================');
final_c = unique(c);
final_clusters = clusters(final_c,:);
disp(final_clusters);
 
 
disp('Done.');
 
 