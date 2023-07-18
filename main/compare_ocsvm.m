clc;
clear;
load result.mat;
testLabell=ones(100,1);
testLabel2=ones(600,1)*(-1); 
testLabel= [testLabell;testLabel2];
unknown_right_number = length(find(testLabel+predict_label_1+predict_label_2==(-3)))
unknown_fault_number = 600 - unknown_right_number
known_fault_number = length(find(testLabel-predict_label_1-predict_label_2== 3))
known_right_number = 100 - known_fault_number
kacc = known_right_number/(known_fault_number+known_right_number)*100%;
uacc = unknown_right_number/(unknown_fault_number+unknown_right_number)*100%;
oacc = (known_right_number+unknown_right_number)/(known_fault_number+known_right_number+unknown_fault_number+unknown_right_number)*100%; 
