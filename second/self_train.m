%% 按照上步骤得到的预测标签分配data_10中的样本到data1 - 9以及data_known中
load mult_dis.mat
% m =  [1     2     3;
%      2     3     4;
%      3     4     5;
%      4     5     6]
% n =  [ 1     3     5;
%      2     4     6;
%      3     5     7;
%      4     6     8]
% k = [m ;n]
% for i = 1:4
%     if i == 1
%         newm = [m;n(i,:)];
%     else
%         newn = [m;n(i,:)];
%     end
% end   
    
    
    
s = size(data_known,1)+1;   
for i = 1:size(data_10,1)    
    if predict_label_expension(i) == 1
        data_1(a1,:) = data_10(i,:);
        a1 = a1 + 1;
    elseif predict_label_expension(i) == 2
        data_2(a2,:) = data_10(i,:);
        a2 = a2 + 1;
    elseif predict_label_expension(i) == 3
       data_3(a3,:) = data_10(i,:);
        a3 = a3 + 1;
    elseif predict_label_expension(i) == 4
        data_4(a4,:) = data_10(i,:);
        a4 = a4 + 1;
    elseif predict_label_expension(i) == 5
        data_5(a5,:) = data_10(i,:);
        a5 = a5 + 1;
    elseif predict_label_expension(i) == 6
        data_6(a6,:) = data_10(i,:);
        a6 = a6 + 1;
    elseif predict_label_expension(i) == 7
        data_7(a7,:) = data_10(i,:);
        a7 = a7 + 1;
    elseif predict_label_expension(i) == 8
        data_8(a8,:) = data_10(i,:);
        a8 = a8 + 1;
    elseif predict_label_expension(i) == 9
        data_9(a9,:) = data_10(i,:);
        a9 = a9 + 1;
    else 
        data_known(s,:) = data_10(i,:);
        s = s + 1;
    end
end