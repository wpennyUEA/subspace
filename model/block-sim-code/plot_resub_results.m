

% Restarts=3
% Task 1 = Sub1, Task 2 = Sub2, r=0.706 (p=0.000)
% Task 1 = Sub1, Task 2 = Add2, r=-0.538 (p=0.000)
% Task 1 = Add1, Task 2 = Sub2, r=-0.632 (p=0.000)
% Task 1 = Add1, Task 2 = Add2, r=0.692 (p=0.000)
N=40;
ra=0.706;rb=-0.538;
[p, z] = corr_rtest(ra, rb, N, N)

N=40;
ra=0.692;rb=-0.632;
[p, z] = corr_rtest(ra, rb, N, N)

% Restarts=8
% Task 1 = Sub1, Task 2 = Sub2, r=0.417 (p=0.007)
% Task 1 = Sub1, Task 2 = Add2, r=-0.084 (p=0.605)
% Task 1 = Add1, Task 2 = Sub2, r=-0.807 (p=0.000)
% Task 1 = Add1, Task 2 = Add2, r=0.892 (p=0.000)
% N=40;
% ra=0.417;rb=-0.084;
% [p, z] = corr_rtest(ra, rb, N, N)
% 
% N=40;
% ra=0.892;rb=-0.807;
% [p, z] = corr_rtest(ra, rb, N, N)

% Restarts=3
F1='task1-12-14-17-51';
F2='task2-after-Sub1-task1-12-14-17-51';
F3='task2-after-Add1-task1-12-14-17-51';

% Restarts=8
% F1='task1-12-13-14-59';
% F2='task2-after-Sub1-task1-12-13-14-59';
% F3='task2-after-Add1-task1-12-13-14-59';

load_str=['load results/',F1];
eval(load_str);

figure

% SUB 1
subplot(2,1,2);
load_str=['load results/',F2];
eval(load_str);
mov_avg = kron(eye(5),[0.5 0.5]);
same_mean=[mov_avg*map(1).me';mov_avg*map2(1).me'];
same_sem=[mov_avg*map(1).seme';mov_avg*map2(1).seme'];
errorbar([1:10],same_mean,same_sem,'b-');
hold on
same_mean=[mov_avg*map(1).me';mov_avg*map2(2).me'];
same_sem=[mov_avg*map(1).seme';mov_avg*map2(2).seme'];
errorbar([1:10]+0.2,same_mean,same_sem,'r-');
grid on
xlabel('Block');
ylabel('Correct');
xlim([0.5 10.5]);
ylim([0.4 0.8]);
legend('Same','Diff');
title('Sub');

same=mean(map2(1).pcexp')';
diff=mean(map2(2).pcexp')';
my_ttest2(same,diff,{'Same','Diff'});

% ADD 1
subplot(2,1,1);
load_str=['load results/',F3];
eval(load_str);
mov_avg = kron(eye(5),[0.5 0.5]);
same_mean=[mov_avg*map(2).me';mov_avg*map2(2).me'];
same_sem=[mov_avg*map(2).seme';mov_avg*map2(2).seme'];
errorbar([1:10],same_mean,same_sem,'b-');
hold on
same_mean=[mov_avg*map(2).me';mov_avg*map2(1).me'];
same_sem=[mov_avg*map(2).seme';mov_avg*map2(1).seme'];
errorbar([1:10]+0.2,same_mean,same_sem,'r-');
grid on
%xlabel('Block');
ylabel('Correct');
xlim([0.5 10.5]);
ylim([0.4 0.8]);
legend('Same','Diff');
title('Add');

% Remove 1st block 
%i=3;

i=1;
same=mean(map2(2).pcexp(:,i:10)')';
diff=mean(map2(1).pcexp(:,i:10)')';
my_ttest2(same,diff,{'Same','Diff'});
