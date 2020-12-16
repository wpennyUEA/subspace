function [] = corr_results (F1,F2,F3)

load_str=['load results/',F1];
eval(load_str);
for i=1:2,
    acc1(i,:)=mean(map(i).pcexp');
end

load_str=['load results/',F2];
eval(load_str);
for j=1:2,
    task1(1).task2_acc(j,:)=mean(map2(j).pcexp');
end

load_str=['load results/',F3];
eval(load_str);
for j=1:2,
    task1(2).task2_acc(j,:)=mean(map2(j).pcexp');
end

disp('Correlations in mean accuracies');
for i=1:2,
    x = acc1(i,:);
    xn=map(i).name;
    for j=1:2,
        y = task1(i).task2_acc(j,:);
        yn=map2(j).name;
        [r,pval]=corr(x',y');
        disp(sprintf('Task 1 = %s, Task 2 = %s, r=%1.3f (p=%1.3f)',xn,yn,r,pval));
    end
end