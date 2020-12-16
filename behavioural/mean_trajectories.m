clear all
close all

[t1,t2,same,diff,name,data] = get_data_same_diff();

h=figure;

for n=1:length(name),
    
    subplot(3,1,n);
    
    m=mean(data(same{n}.ind,:));
    s=std(data(same{n}.ind,:));
    N=length(same{n}.ind);
    sem=s/sqrt(N);
    
    errorbar([1:10],m,sem);
    grid on
    hold on
    
    m=mean(data(diff{n}.ind,:));
    s=std(data(diff{n}.ind,:));
    N=length(diff{n}.ind);
    sem=s/sqrt(N);
    
    errorbar([1:10],m,sem,'r');
    legend('Same','Diff');
    title(name{n});
    ylim([0.5, 0.9]);
    
    ylabel('Correct');
end
xlabel('Block');

disp('Subspace by block interaction');
disp('Test for interaction: block(task2) * same/diff. Fig 7 of paper already !');
disp('But stats only significant for one-sided tests.');

disp(' ');
disp('Try this ... its A3.6 but without task factor (1 or 2)');
disp('Sign by Subspace by block interaction ..');
disp('Test for interaction: Sign (add/sub) * same/diff * block(task2)');

