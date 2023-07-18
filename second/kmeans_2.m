function [output] = kmeans_2(data, k_value)
%从样本中，随机选取K个样本作为初始的聚类中心；
data_num = size(data, 1);
temp = randperm(data_num, k_value)';     
center = data(temp, :);

%用于计数迭代次数：
iteration = 0;
% while 1
for i = 1:data_num
    %获得样本集与聚类中心的距离；
%      distance = euclidean_distance(data, center);
distance = sqeuclidean_distance(data, center);
% distance = distEmd(data, center);

    %将距离矩阵的每一行从小到大排序， 获得相应的index值，其实我们只需要index的第一列的值；
    [~, index] = sort(distance, 2, 'ascend');


    %接下来形成新的聚类中心；
    center_new = zeros(k_value, size(data, 2));
    for i = 1:k_value
        data_for_one_class = data(index(:, 1) == i, :);          
        center_new(i,:) = mean(data_for_one_class, 1);    %因为初始的聚类中心为样本集中的元素，所以不会出现某类别的样本个数为0的情况；
    end
   
    %输出迭代次数，给眼睛一个反馈；
    iteration = iteration + 1;
    fprintf('进行迭代次数为：%d\n', iteration);
    
    % 如果这两次的聚类中心不变，则停止迭代，跳出循环；
    if center_new == center
        break;
    end
    
    center = center_new;
end

output = index(:, 1);
  
end
