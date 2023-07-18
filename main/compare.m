clc;
clear;
% load result.mat;
% %%
% %导入预测结果的标签
% predictedlabel1 = getfield(result_1,'predictedlabel') ;
% predictedlabel2 = getfield(result_2,'predictedlabel') ;
% % predictedlabel3 = getfield(result_3,'predictedlabel') ;
% % predictedlabel4 = getfield(result_4,'predictedlabel') ;
% % predictedlabel5 = getfield(result_5,'predictedlabel') ;
% testlabel = getfield(result_1,'testLabel') ;
%%
% unknown_right_number = length(find((testlabel+predictedlabel1+predictedlabel2)==(-3)));
% unknown_fault_number = 738-unknown_right_number;
% known_fault_number = length(find((testlabel-predictedlabel1-predictedlabel2)==3));
% known_right_number = 82-known_fault_number;
% KACC = known_right_number/(known_fault_number+known_right_number)*100%;
% UACC = unknown_right_number/(unknown_fault_number+unknown_right_number)*100%;
% OACC = (known_right_number+unknown_right_number)/(known_fault_number+known_right_number+unknown_fault_number+unknown_right_number)*100%;        

%%
load svddbefore.mat
predictedlabel_bf = getfield(result,'predictedlabel') ;
testlabel_bf = getfield(result,'testLabel') ;
% for i = 1 : length(testlabel_bf)
%  if (testlabel_bf(i)+predictedlabel_bf(i))==(2)
%      data_known(i,:) = testData(i,:);
%  else 
%      data_unknown(i,:) = testData(i,:);
%  end
% end
% data_known(all(data_known==0,2),:)=[];
% data_unknown(all(data_unknown==0,2),:)=[];
unknown_right_number_bf = length(find((testlabel_bf+predictedlabel_bf)==(-2)));
unknown_fault_number_bf = 738-unknown_right_number_bf;
known_right_number_bf = length(find((testlabel_bf+predictedlabel_bf)==2));
known_fault_number_bf = 82-known_right_number_bf;
KACC_bf = known_right_number_bf/(known_fault_number_bf+known_right_number_bf)*100%;
UACC_bf = unknown_right_number_bf/(unknown_fault_number_bf+unknown_right_number_bf)*100%;
OACC_bf = (known_right_number_bf+unknown_right_number_bf)/(known_fault_number_bf+known_right_number_bf+unknown_fault_number_bf+unknown_right_number_bf)*100%;        