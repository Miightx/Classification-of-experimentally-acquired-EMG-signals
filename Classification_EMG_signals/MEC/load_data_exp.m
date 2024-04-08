% 10-02-08 AC Added code to downsampled the myoelectric signals from 3000
%             Hz to 1000 Hz
% 09-10-06 AC Added filter to remove motion artifact and high frequency
%             noise
% 09-10-06 AC Added code to remove resting state from the start and end of
%             the files
function [data,motion,start_index] = load_data(data_filename, index_filename)

datas = load(data_filename);

data = [];

for k = 1:6
    data = [data datas.Data{1,k}];
end

% resample from 3000 Hz to 1000 Hz
[b,a] = butter(3,[10 400]/1500); % filter between 10 and 400 Hz
data = filtfilt(b,a,data);
data = resample(data,1000,3000);

load(index_filename);

start_index = transpose(indexes);
motion = transpose(labels);


% resample from 3000 Hz to 1000 Hz
start_index = round(start_index/3);
start_index(1) = 1;

% clip the resting data from the start and end of the files
Nstart_index = length(start_index);
data = data(start_index(2):start_index(Nstart_index),:);
data = data - repmat(mean(data,1),size(data,1),1);
start_index = start_index(2:(Nstart_index-1)) - start_index(2) + 1;
motion = motion(2:(Nstart_index-1));
