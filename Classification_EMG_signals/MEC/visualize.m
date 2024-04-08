clear all
dat_filename = 'data\s4t1data.daq';
data = daqread(dat_filename);
index_filename = 'data\s4t1index.mat';
index = load(index_filename);

[training_data,training_motion,training_index] = load_data('s4t1');


for k = 1:6
    subplot(2,4,k)
    plot(training_data(:,k))
    ylim([-1 1])
    for i = 1:length(training_index)
        xline(training_index(i))
        text(training_index(i),0.6, int2str(training_motion(i)))
    end
end

feature = getrmsfeat(training_data, 256, 128);
tfeat = extract_feature(training_data, 256, 128); 

classes = getclass(training_data, training_motion,training_index,256,128);

[tfeat, classes] = remove_transitions(tfeat, classes);

[testing_data,testing_motion,testing_index] = load_data('s4t3');

feature_testing = extract_feature(testing_data,256,32);
class_testing = getclass(testing_data,testing_motion,testing_index,256,32);



[error_training,error_testing,classification_training,classification_testing]...
    = ldaclassify(tfeat,feature_testing,classes,class_testing);
figure(2)

classification_testing_maj = majority_vote(classification_testing,8,0);

[classification_testing_maj_nt,class_testing_nt] = remove_transitions(classification_testing_maj,class_testing);

c = confmat(class_testing_nt, classification_testing_maj_nt);

classification_timeplot(class_testing_nt,classification_testing_maj_nt)

error_testing_maj_nt = sum(classification_testing_maj_nt ~= class_testing_nt)/length(class_testing_nt)*100;


