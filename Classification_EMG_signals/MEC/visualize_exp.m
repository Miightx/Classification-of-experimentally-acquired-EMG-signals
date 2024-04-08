clear all
% dat_filename = 'data\s4t1data.daq';
% data = daqread(dat_filename);
% index_filename = 'data\s4t1index.mat';
% index = load(index_filename);

[training_data,training_motion,training_index] = load_data_exp('Exp_data\seq1_eth', 'Exp_data\index_testing1');

training_motion = training_motion + 1;

for  k = 1:6
    training_data(:,k) = (training_data(:,k) - mean(training_data(:,k))) / (max(training_data(:,k)) - min(training_data(:,k))) * 2; 
end

%training_data = zscore(training_data);

figure()

for k = 1:6
    subplot(2,4,k)
    plot(training_data(:,k))
    for i = 1:length(training_index)
        xline(training_index(i))
        text(training_index(i),0.6, int2str(training_motion(i)))
    end
end
 
feature = getrmsfeat(training_data, 256, 128);
tfeat = extract_feature(training_data, 256, 128);   

classes = getclass(training_data, training_motion,training_index,256,128);

[tfeat, classes] = remove_transitions(tfeat, classes);

[testing_data,testing_motion,testing_index] = load_data_exp('Exp_data\seq3_eth', 'Exp_data\index_testing3');
testing_motion = testing_motion + 1;

for  k = 1:6
    testing_data(:,k) = (testing_data(:,k) - mean(testing_data(:,k))) / (max(testing_data(:,k)) - min(testing_data(:,k))) * 2; 
end
%testing_data = zscore(testing_data);

figure()

for k = 1:6
    subplot(2,4,k)
    plot(testing_data(:,k))
    for i = 1:length(testing_index)
        xline(testing_index(i))
        text(testing_index(i),0.6, int2str(testing_motion(i)))
    end
end


feature_testing = extract_feature(testing_data,256,32);
class_testing = getclass(testing_data,testing_motion,testing_index,256,32);



[error_training,error_testing,classification_training,classification_testing]...
    = ldaclassify(tfeat,feature_testing,classes,class_testing);
% Nfeat = 10; % number of features to reduce to
%[feature_training,feature_testing] = pca_feature_reduction(feature_training,Nfeat,feature_testing);
%[feature_training,feature_testing] = ulda_feature_reduction(feature_training,Nfeat,class_training,feature_testing);

% % no post-processing
% [error_training,error_testing,classification_training,classification_testing]...
%     = ldaclassify(feature_training,feature_testing,class_training,class_testing);

% majority vote smoothing
classification_testing_maj = majority_vote(classification_testing,8,0);
error_testing_maj = sum(classification_testing_maj ~= class_testing)/length(class_testing)*100;

% remove transitions from computation of classification accuracy
[classification_testing_nt,class_testing_nt] = remove_transitions(classification_testing,class_testing);
error_testing_nt = sum(classification_testing_nt ~= class_testing_nt)/length(class_testing_nt)*100;

% majority vote smooth and remove transitions from computation of classification accuracy
[classification_testing_maj_nt,class_testing_nt] = remove_transitions(classification_testing_maj,class_testing);
error_testing_maj_nt = sum(classification_testing_maj_nt ~= class_testing_nt)/length(class_testing_nt)*100;
%%
figure()
subplot(2,2,1)
classification_timeplot(class_testing,classification_testing);
title(['Error = ' num2str(error_testing) '%'])
subplot(2,2,2)
classification_timeplot(class_testing,classification_testing_maj);
title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
subplot(2,2,3)
classification_timeplot(class_testing_nt,classification_testing_nt);
title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
subplot(2,2,4)
classification_timeplot(class_testing_nt,classification_testing_maj_nt);
title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
%%
figure()
subplot(2,2,1)
confusion_matrix = confmat(class_testing,classification_testing);
plotconfmat(confusion_matrix(2:10,2:10));
title(['Error = ' num2str(error_testing) '%'])
subplot(2,2,2)
confusion_matrix = confmat(class_testing,classification_testing_maj);
plotconfmat(confusion_matrix(2:10,2:10));
title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
subplot(2,2,3)
confusion_matrix = confmat(class_testing_nt,classification_testing_nt);
plotconfmat(confusion_matrix(2:10,2:10));
title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
subplot(2,2,4)
confusion_matrix = confmat(class_testing_nt,classification_testing_maj_nt);
plotconfmat(confusion_matrix(2:10,2:10));
title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
%%
figure()
subplot(2,2,1)
confusion_matrix = confmat(class_testing,classification_testing);
plotconfmat(confusion_matrix);
title(['Error = ' num2str(error_testing) '%'])
subplot(2,2,2)
confusion_matrix = confmat(class_testing,classification_testing_maj);
plotconfmat(confusion_matrix);
title(['Majority Vote Error = ' num2str(error_testing_maj) '%'])
subplot(2,2,3)
confusion_matrix = confmat(class_testing_nt,classification_testing_nt);
plotconfmat(confusion_matrix);
title(['No Transitions Error = ' num2str(error_testing_nt) '%'])
subplot(2,2,4)
confusion_matrix = confmat(class_testing_nt,classification_testing_maj_nt);
plotconfmat(confusion_matrix);
title(['Majority Vote/No Transitions Error = ' num2str(error_testing_maj_nt) '%'])
