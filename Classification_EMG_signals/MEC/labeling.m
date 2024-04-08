clear all

dat_filename = 'data\s4t1data.daq';
data = daqread(dat_filename);

figure;

for k = 1:6
    plot(transpose(data(:, k)))
    hold on
end

indexes = [];
labels = [];
xlims = xlim;

[xl, ~] = ginput(1);

while xl < xlims(2) && xl > xlims(1)
    label = input('Enter the class of movement: ');
    xline(xl);
    text(xl, max(data(:)), int2str(label));
    indexes = [indexes; xl];
    labels = [labels; label];
    [xl, ~] = ginput(1);
end

% Create motion and start_index vectors
motion = labels;
start_index = indexes;

% Save the labeled data
save('data\s4t1data_lab.mat', 'motion', 'start_index');
