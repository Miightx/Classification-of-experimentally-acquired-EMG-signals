clear all

data_filename = 'Exp_data\seq3.mat';
datas = load(data_filename);
figure(1)

for k = 1:6
    plot(transpose(datas.Data{1,k}))
    hold on
end

indexes = [];
labels = [];
xlims = xlim;
[xl,yl] = ginput(1);
while xl < xlims(2) && xl > xlims(1)
    label = input("Enter the class of movement : ");
    xline(xl);
    text(xl, 1000, int2str(label));
    indexes = [indexes, xl];
    labels = [labels label];
    [xl,yl] = ginput(1);
end


save('Exp_data\index_testing3.mat', 'labels', 'indexes');
