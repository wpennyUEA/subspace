
clear all
close all

load Results

%% Accuracy per task

idxTask1 =  find(Results(:,3) == 1 & Results(:,6) == 1);
idxTask2 = find(Results(:,3) == 1 & Results(:,6) == 0);
idxTask3 =  find(Results(:,3) == 1 & Results(:,7) == 1);
idxTask4 = find(Results(:,3) == 1 & Results(:,7) == 0);

figure
bar([mean(Results(idxTask1,1)), mean(Results(idxTask2,1)), mean(Results(idxTask3,2)), mean(Results(idxTask4,2))])
hold on
er = errorbar([mean(Results(idxTask1,1)), mean(Results(idxTask2,1)), mean(Results(idxTask3,2)), mean(Results(idxTask4,2))], [std(Results(idxTask1,1))./sqrt(length(idxTask1)), std(Results(idxTask2,1))./sqrt(length(idxTask2)), std(Results(idxTask3,2))./sqrt(length(idxTask3)), std(Results(idxTask4,2))./sqrt(length(idxTask4))],'k');
er.LineStyle = 'none';
title('Accuracy per Rule')
set(gca,'xticklabel', {'Rule1', 'Rule2', 'Rule3', 'Rule4'})
set(gca,'fontsize', 18);



%% Accuracy Same VS Different Subspace in Task 2 and Task 1

idxSame = find(Results(:,3) == 1 & Results(:,4) == 1);
idxDiff = find(Results(:,3) == 1 & Results(:,4) == 0);

figure
subplot(1,2,1)
bar([mean(Results(idxSame,1)), mean(Results(idxDiff,1))])
hold on
er = errorbar([mean(Results(idxSame,1)), mean(Results(idxDiff,1))], [std(Results(idxSame,1))./sqrt(length(Results(idxSame,1))), std(Results(idxDiff,1))./sqrt(length(Results(idxSame,1)))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task1')
set(gca,'xticklabel', {'Same', 'Diff'})

subplot(1,2,2)
bar([mean(Results(idxSame,2)), mean(Results(idxDiff,2))])
hold on
er = errorbar([mean(Results(idxSame,2)), mean(Results(idxDiff,2))], [std(Results(idxSame,2))./sqrt(length(Results(idxSame,2))), std(Results(idxDiff,2))./sqrt(length(Results(idxSame,2)))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task2')
set(gca,'xticklabel', {'Same', 'Diff'})

%sgtitle('Task by Subspace')
set(gca,'fontsize', 18);

%% Accuracy Same VS Different Subspace in Task 2 per block
figure
subplot(1,5,1)
bar([mean(Results(idxSame,13)), mean(Results(idxDiff,13))])
hold on
er = errorbar([mean(Results(idxSame,13)), mean(Results(idxDiff,13))], [std(Results(idxSame,13))./sqrt(length(idxSame)), std(Results(idxDiff,13))./sqrt(length(idxDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 1')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Same', 'Diff'})

subplot(1,5,2)
bar([mean(Results(idxSame,14)), mean(Results(idxDiff,14))])
hold on
er = errorbar([mean(Results(idxSame,14)), mean(Results(idxDiff,14))], [std(Results(idxSame,14))./sqrt(length(idxSame)), std(Results(idxDiff,14))./sqrt(length(idxDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 2')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Same', 'Diff'})

subplot(1,5,3)
bar([mean(Results(idxSame,15)), mean(Results(idxDiff,15))])
hold on
er = errorbar([mean(Results(idxSame,15)), mean(Results(idxDiff,15))], [std(Results(idxSame,15))./sqrt(length(idxSame)), std(Results(idxDiff,15))./sqrt(length(idxDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 3')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Same', 'Diff'})

subplot(1,5,4)
bar([mean(Results(idxSame,16)), mean(Results(idxDiff,16))])
hold on
er = errorbar([mean(Results(idxSame,16)), mean(Results(idxDiff,16))], [std(Results(idxSame,16))./sqrt(length(idxSame)), std(Results(idxDiff,16))./sqrt(length(idxDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 4')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Same', 'Diff'})

subplot(1,5,5)
bar([mean(Results(idxSame,17)), mean(Results(idxDiff,17))])
hold on
er = errorbar([mean(Results(idxSame,17)), mean(Results(idxDiff,17))], [std(Results(idxSame,17))./sqrt(length(idxSame)), std(Results(idxDiff,17))./sqrt(length(idxDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 5')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Same', 'Diff'})

%sgtitle('Task 2 - Same vs Diff Subspace')
set(gca,'fontsize', 18);


%% Good and bad perfomer based on median last block task 1

idxSameGood = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,12) > median(Results(idxSame,12)));
idxSameBad = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,12) <= median(Results(idxSame,12)));

idxDiffGood = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,12) > median(Results(idxDiff,12)));
idxDiffBad = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,12) <= median(Results(idxDiff,12)));

figure
subplot(1,2,1)
bar([mean(Results(idxSameGood, 2)), mean(Results(idxSameBad, 2))])
hold on
er = errorbar([mean(Results(idxSameGood, 2)), mean(Results(idxSameBad, 2))], [std(Results(idxSameGood, 2))./sqrt(length(idxSameGood)), std(Results(idxSameBad, 2))./sqrt(length(idxSameGood))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,2,2)
bar([mean(Results(idxDiffGood, 2)), mean(Results(idxDiffBad, 2))])
hold on
er = errorbar([mean(Results(idxDiffGood, 2)), mean(Results(idxDiffBad, 2))], [std(Results(idxDiffGood, 2))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad, 2))./sqrt(length(idxDiffGood))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Diff Subspace')
ylim([0.5 0.85])
set(gca,'xticklabel', {'Good', 'Bad'})

%sgtitle('Good and Bad performer')
set(gca,'fontsize', 18);

%% Good and bad performer per block based on median last block task 1
% Same
figure
subplot(1,5,1)
bar([mean(Results(idxSameGood,13)), mean(Results(idxSameBad,13))])
hold on
er = errorbar([mean(Results(idxSameGood,13)), mean(Results(idxSameBad,13))], [std(Results(idxSameGood,13))./sqrt(length(idxSameGood)), std(Results(idxSameBad,13))./sqrt(length(idxSameBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 1')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,2)
bar([mean(Results(idxSameGood,14)), mean(Results(idxSameBad,14))])
hold on
er = errorbar([mean(Results(idxSameGood,14)), mean(Results(idxSameBad,14))], [std(Results(idxSameGood,14))./sqrt(length(idxSameGood)), std(Results(idxSameBad,14))./sqrt(length(idxSameBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 2')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,3)
bar([mean(Results(idxSameGood,15)), mean(Results(idxSameBad,15))])
hold on
er = errorbar([mean(Results(idxSameGood,15)), mean(Results(idxSameBad,15))], [std(Results(idxSameGood,15))./sqrt(length(idxSameGood)), std(Results(idxSameBad,15))./sqrt(length(idxSameBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 3')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,4)
bar([mean(Results(idxSameGood,16)), mean(Results(idxSameBad,16))])
hold on
er = errorbar([mean(Results(idxSameGood,16)), mean(Results(idxSameBad,16))], [std(Results(idxSameGood,16))./sqrt(length(idxSameGood)), std(Results(idxSameBad,16))./sqrt(length(idxSameBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 4')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,5)
bar([mean(Results(idxSameGood,17)), mean(Results(idxSameBad,17))])
hold on
er = errorbar([mean(Results(idxSameGood,17)), mean(Results(idxSameBad,17))], [std(Results(idxSameGood,17))./sqrt(length(idxSameGood)), std(Results(idxSameBad,17))./sqrt(length(idxSameBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 5')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

%sgtitle('Task 2 Same Subspace - Good and Bad performer')

% Diff
figure
subplot(1,5,1)
bar([mean(Results(idxDiffGood,13)), mean(Results(idxDiffBad,13))])
hold on
er = errorbar([mean(Results(idxDiffGood,13)), mean(Results(idxDiffBad,13))], [std(Results(idxDiffGood,13))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad,13))./sqrt(length(idxDiffBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 1')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,2)
bar([mean(Results(idxDiffGood,14)), mean(Results(idxDiffBad,14))])
hold on
er = errorbar([mean(Results(idxDiffGood,14)), mean(Results(idxDiffBad,14))], [std(Results(idxDiffGood,14))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad,14))./sqrt(length(idxDiffBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 2')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,3)
bar([mean(Results(idxDiffGood,15)), mean(Results(idxDiffBad,15))])
hold on
er = errorbar([mean(Results(idxDiffGood,15)), mean(Results(idxDiffBad,15))], [std(Results(idxDiffGood,15))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad,15))./sqrt(length(idxDiffBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 3')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,4)
bar([mean(Results(idxDiffGood,16)), mean(Results(idxDiffBad,16))])
hold on
er = errorbar([mean(Results(idxDiffGood,16)), mean(Results(idxDiffBad,16))], [std(Results(idxDiffGood,16))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad,16))./sqrt(length(idxDiffBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Block 4')
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

subplot(1,5,5)
bar([mean(Results(idxDiffGood,17)), mean(Results(idxDiffBad,17))])
hold on
er = errorbar([mean(Results(idxDiffGood,17)), mean(Results(idxDiffBad,17))], [std(Results(idxDiffGood,17))./sqrt(length(idxDiffGood)), std(Results(idxDiffBad,17))./sqrt(length(idxDiffBad))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
ylim([0.5 0.90])
set(gca,'xticklabel', {'Good', 'Bad'})

%sgtitle('Task 2 Diff Subspace - Good and Bad performer')
set(gca,'fontsize', 18);

%% Plot Correlation
h = figure('Color', [1 1 1]);
s1 = plot(Results(idxSame, 1), Results(idxSame, 2), 'k+', Results(idxDiff, 1), Results(idxDiff, 2), 'ro');
set(s1, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)
%%% axis display 
xlabel('Task 1', 'FontSize', 15)
ylabel('Task 2', 'FontSize', 15)
set(gca, 'FontSize', 15, 'YMinorTick','on','XMinorTick','on')
legend('Same Subspace', 'Different Subspace')
title('Overall Correlation')

%% Correlation by Rule
idxSameSub = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,7) == 1);
idxDiffSub = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,7) == 1);

idxSameAdd = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,7) == 0);
idxDiffAdd = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,7) == 0);


h = figure('Color', [1 1 1]);
s1 = plot(Results(idxSameSub, 1), Results(idxSameSub, 2), 'k+', Results(idxDiffSub, 1), Results(idxDiffSub, 2), 'ro');
set(s1, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)
%%% axis display 
xlabel('Task 1', 'FontSize', 15)
ylabel('Task 2', 'FontSize', 15)
set(gca, 'FontSize', 15, 'YMinorTick','on','XMinorTick','on')
legend('Same Subspace', 'Different Subspace')
title('Subtraction Sign Correlation')



%sgtitle('Task1 Task2 For Subtraction subspace')
h = figure('Color', [1 1 1]);
s1 = plot(Results(idxSameAdd, 1), Results(idxSameAdd, 2), 'k+', Results(idxDiffAdd, 1), Results(idxDiffAdd, 2), 'ro');
set(s1, 'MarkerSize', 7, 'LineWidth', 1.5);
%%% regression line
hold on
l = lsline ;
set(l,'LineWidth', 2)
%%% axis display 
xlabel('Task 1', 'FontSize', 15)
ylabel('Task 2', 'FontSize', 15)
set(gca, 'FontSize', 15, 'YMinorTick','on','XMinorTick','on')
legend('Same Subspace', 'Different Subspace')
title('Addition Sign Correlation')


%% 12 secs VS 2 Min
idx12 = find(Results(:,3) == 1 & Results(:,5) == 1);
idx2 = find(Results(:,3) == 1 & Results(:,5) == 0);

figure
subplot(1,2,1)
bar([mean(Results(idx12,1)), mean(Results(idx2,1))])
hold on
er = errorbar([mean(Results(idx12,1)), mean(Results(idx2,1))], [std(Results(idx12,1))./sqrt(length(idx12)), std(Results(idx2,1))./sqrt(length(idx2))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task1')
set(gca,'xticklabel', {'12sec', '2min'})

subplot(1,2,2)
bar([mean(Results(idx12,2)), mean(Results(idx2,2))])
hold on
er = errorbar([mean(Results(idx12,2)), mean(Results(idx2,2))], [std(Results(idx12,2))./sqrt(length(idx12)), std(Results(idx2,2))./sqrt(length(idx2))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task2')
set(gca,'xticklabel', {'12sec', '2min'})

%sgtitle('Task by Time')

%% Time per Task
idxTask1sec =  find(Results(:,3) == 1 & Results(:,6) == 1 & Results(:,5) == 1);
idxTask1min = find(Results(:,3) == 1 & Results(:,6) == 1 & Results(:,5) == 0);

idxTask2sec =  find(Results(:,3) == 1 & Results(:,6) == 0 & Results(:,5) == 1);
idxTask2min = find(Results(:,3) == 1 & Results(:,6) == 0 & Results(:,5) == 0);

idxTask3sec =  find(Results(:,3) == 1 & Results(:,7) == 1 & Results(:,5) == 1);
idxTask3min = find(Results(:,3) == 1 & Results(:,7) == 1 & Results(:,5) == 0);

idxTask4sec =  find(Results(:,3) == 1 & Results(:,7) == 0 & Results(:,5) == 1);
idxTask4min = find(Results(:,3) == 1 & Results(:,7) == 0 & Results(:,5) == 0);

figure
subplot(1,4,1)
bar([mean(Results(idxTask1sec,1)), mean(Results(idxTask1min,1))])
hold on
er = errorbar([mean(Results(idxTask1sec,1)), mean(Results(idxTask1min,1))], [std(Results(idxTask1sec,1))/length(idxTask1sec), std(Results(idxTask1min,1))/length(idxTask1min)],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule1')
set(gca,'xticklabel', {'Sec', 'Min'})


subplot(1,4,2)
bar([mean(Results(idxTask2sec,1)), mean(Results(idxTask2min,1))])
hold on
er = errorbar([mean(Results(idxTask2sec,1)), mean(Results(idxTask2min,1))], [std(Results(idxTask2sec,1))/length(idxTask2sec), std(Results(idxTask2min,1))/length(idxTask2min)],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule2')
set(gca,'xticklabel', {'Sec', 'Min'})

subplot(1,4,3)
bar([mean(Results(idxTask3sec,2)), mean(Results(idxTask3min,2))])
hold on
er = errorbar([mean(Results(idxTask3sec,2)), mean(Results(idxTask3min,2))], [std(Results(idxTask3sec,2))/length(idxTask3sec), std(Results(idxTask3min,2))/length(idxTask3min)],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule3')
set(gca,'xticklabel', {'Sec', 'Min'})

subplot(1,4,4)
bar([mean(Results(idxTask4sec,2)), mean(Results(idxTask4min,2))])
hold on
er = errorbar([mean(Results(idxTask4sec,2)), mean(Results(idxTask4min,2))], [std(Results(idxTask4sec,2))/length(idxTask4sec), std(Results(idxTask4min,2))/length(idxTask4min)],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule4')
set(gca,'xticklabel', {'Sec', 'Min'})

%sgtitle('Rule by Time')
set(gca,'fontsize', 18);

%% Time By Subspace
secSame = find(Results(:,3) == 1 & Results(:,5) == 1 & Results(:,4) == 1);
secDiff = find(Results(:,3) == 1 & Results(:,5) == 1 & Results(:,4) == 0);
minSame = find(Results(:,3) == 1 & Results(:,5) == 0 & Results(:,4) == 1);
minDiff = find(Results(:,3) == 1 & Results(:,5) == 0 & Results(:,4) == 0);

figure
subplot(1,2,1)
bar([mean(Results(secSame,2)), mean(Results(minSame,2))])
hold on 
er = errorbar([mean(Results(secSame,2)), mean(Results(minSame,2))], [std(Results(secSame,2))./sqrt(length(secSame)), std(Results(minSame,2))./sqrt(length(secSame))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace')
set(gca,'xticklabel', {'12sec', '2min'})

subplot(1,2,2)
bar([mean(Results(secDiff,2)), mean(Results(minDiff,2))])
hold on
er = errorbar([mean(Results(secDiff,2)), mean(Results(minDiff,2))], [std(Results(secDiff,2))./sqrt(length(secDiff)), std(Results(minDiff,2))./sqrt(length(secDiff))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Diff Subspace')
set(gca,'xticklabel', {'12sec', '2min'})

%sgtitle('Task2')

%% Time By Subspace By perfomer 

idxSameGoodLong = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,5) == 0 & Results(:,12) > median(Results(minSame,12)));
idxSameBadLong = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,5) == 0 & Results(:,12) <= median(Results(minSame,12)));

idxDiffGoodLong = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,5) == 0 & Results(:,12) > median(Results(minDiff,12)));
idxDiffBadLong = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,5) == 0 & Results(:,12) <= median(Results(minDiff,12)));

idxSameGoodShort = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,5) == 1 & Results(:,12) > median(Results(minSame,12)));
idxSameBadShort = find(Results(:,3) == 1 & Results(:,4) == 1 & Results(:,5) == 1 & Results(:,12) <= median(Results(minSame,12)));

idxDiffGoodShort = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,5) == 1 & Results(:,12) > median(Results(minDiff,12)));
idxDiffBadShort = find(Results(:,3) == 1 & Results(:,4) == 0 & Results(:,5) == 1 & Results(:,12) <= median(Results(minDiff,12)));




subplot(2,2,1)
bar([mean(Results(idxSameGoodLong,2)), mean(Results(idxSameGoodShort,2))])
hold on
er = errorbar([mean(Results(idxSameGoodLong,2)), mean(Results(idxSameGoodShort,2))], [std(Results(idxSameGoodLong,2))/sqrt(length(idxSameGoodLong)), std(Results(idxSameGoodShort,2))/sqrt(length(idxSameGoodShort))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace - Good Perf')
set(gca,'xticklabel', {'2min', '12sec'})

subplot(2,2,2)
bar([mean(Results(idxSameBadLong,2)), mean(Results(idxSameBadShort,2))])
hold on
er = errorbar([mean(Results(idxSameBadLong,2)), mean(Results(idxSameBadShort,2))], [std(Results(idxSameBadLong,2))/sqrt(length(idxSameBadLong)), std(Results(idxSameBadShort,2))/sqrt(length(idxSameBadShort))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace - Bad Perf')
set(gca,'xticklabel', {'2min', '12sec'})

subplot(2,2,3)
bar([mean(Results(idxDiffGoodLong,2)), mean(Results(idxDiffGoodShort,2))])
hold on
er = errorbar([mean(Results(idxDiffGoodLong,2)), mean(Results(idxDiffGoodShort,2))], [std(Results(idxDiffGoodLong,2))/sqrt(length(idxDiffGoodLong)), std(Results(idxDiffGoodShort,2))/sqrt(length(idxDiffGoodShort))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace - Good Perf')
set(gca,'xticklabel', {'2min', '12sec'})

subplot(2,2,4)
bar([mean(Results(idxDiffBadLong,2)), mean(Results(idxDiffBadShort,2))])
hold on
er = errorbar([mean(Results(idxDiffBadLong,2)), mean(Results(idxDiffBadShort,2))], [std(Results(idxDiffBadLong,2))/sqrt(length(idxDiffBadLong)), std(Results(idxDiffBadShort,2))/sqrt(length(idxDiffBadShort))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Same Subspace - Good Perf')
set(gca,'xticklabel', {'2min', '12sec'})

%sgtitle('Task2 - Subspace, Performance, Time')

%% Declarations by rule

Dec_Rule1 = find(Results(:,6) == 1 & Results(:,26) == 1);
Not_Dec_Rule1 = find(Results(:,6) == 1 & Results(:,26) == 0);
Dec_Rule2 = find(Results(:,6) == 0 & Results(:,27) == 1);
Not_Dec_Rule2 = find(Results(:,6) == 0 & Results(:,27) == 0);
Dec_Rule3 = find(Results(:,7) == 1 & Results(:,28) == 1);
Not_Dec_Rule3 = find(Results(:,7) == 1 & Results(:,28) == 0);
Dec_Rule4 = find(Results(:,7) == 0 & Results(:,29) == 1);
Not_Dec_Rule4 = find(Results(:,7) == 0 & Results(:,29) == 0);



subplot(2,2,1)
bar([mean(Results(Dec_Rule1,1)), mean(Results(Not_Dec_Rule1,1))])
hold on
er = errorbar([mean(Results(Dec_Rule1,1)), mean(Results(Not_Dec_Rule1,1))], [std(Results(Dec_Rule1,1))/sqrt(length(Dec_Rule1)), std(Results(Not_Dec_Rule1,1))/sqrt(length(Not_Dec_Rule1))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule 1')
set(gca,'xticklabel', {'Dec', 'NotDec'})

subplot(2,2,2)
bar([mean(Results(Dec_Rule2,1)), mean(Results(Not_Dec_Rule2,1))])
hold on
er = errorbar([mean(Results(Dec_Rule2,1)), mean(Results(Not_Dec_Rule2,1))], [std(Results(Dec_Rule2,1))/sqrt(length(Dec_Rule2)), std(Results(Not_Dec_Rule2,1))/sqrt(length(Not_Dec_Rule2))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule 2')
set(gca,'xticklabel', {'Dec', 'NotDec'})

subplot(2,2,3)
bar([mean(Results(Dec_Rule3,2)), mean(Results(Not_Dec_Rule3,2))])
hold on
er = errorbar([mean(Results(Dec_Rule3,2)), mean(Results(Not_Dec_Rule3,2))], [std(Results(Dec_Rule3,2))/sqrt(length(Dec_Rule3)), std(Results(Not_Dec_Rule3,2))/sqrt(length(Not_Dec_Rule3))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule 3')
set(gca,'xticklabel', {'Dec', 'NotDec'})

subplot(2,2,4)
bar([mean(Results(Dec_Rule4,2)), mean(Results(Not_Dec_Rule4,2))])
hold on
er = errorbar([mean(Results(Dec_Rule4,2)), mean(Results(Not_Dec_Rule4,2))], [std(Results(Dec_Rule4,2))/sqrt(length(Dec_Rule4)), std(Results(Not_Dec_Rule4,2))/sqrt(length(Not_Dec_Rule4))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Rule 3')
set(gca,'xticklabel', {'Dec', 'NotDec'})

%% Declaration on Task 1 --> effect on performance on task 2 AND declaration

% Col 1 = mean accuracy task 1
% Col 2 = mean accuracy task 2
% Col 3 = 1 if at least 1 task is above chance
% Col 4 = 1 if same subspace 0 if not
% Col 5 = 1 if 12 seconds, 0 if 2 minutes (break)
% Col 6 = 1 if Task 1, 0 if 2
% Col 7 = 1 if Task 3, 0 if 4
% Col 8 to 12 = mean accuracy for task 1, block 1 to 5
% Col 13 to 17 = mean accuracy for task 2, block 1 to 5
% Col 18 to 21 = break length task 1
% Col 22 to 25 = break length task 2
% Col 26 to 29 = declaration on task 1 to 4
figure
SameSub_Dec_T1 = find(Results(:,4) == 1 & (Results(:,26) == 1 | Results(:,27) == 1));
SameSub_NDec_T1 = find(Results(:,4) == 1 & (Results(:,26) == 0 & Results(:,27) == 0));

DiffSub_Dec_T1 = find(Results(:,4) == 0 & (Results(:,26) == 1 | Results(:,27) == 1));
DiffSub_NDec_T1 = find(Results(:,4) == 0 & (Results(:,26) == 0 & Results(:,27) == 0));

subplot(2,2,1)
bar([mean(Results(SameSub_Dec_T1,2)), mean(Results(SameSub_NDec_T1,2))])
hold on
er = errorbar([mean(Results(SameSub_Dec_T1,2)), mean(Results(SameSub_NDec_T1,2))], [std(Results(SameSub_Dec_T1,2))/sqrt(length(SameSub_Dec_T1)), std(Results(SameSub_NDec_T1,2))/sqrt(length(SameSub_NDec_T1))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task 2 - Same Subspace')
set(gca,'xticklabel', {'Dec', 'NotDec'})

subplot(2,2,2)
bar([mean(Results(DiffSub_Dec_T1,2)), mean(Results(DiffSub_NDec_T1,2))])
hold on
er = errorbar([mean(Results(DiffSub_Dec_T1,2)), mean(Results(DiffSub_NDec_T1,2))], [std(Results(DiffSub_Dec_T1,2))/sqrt(length(DiffSub_Dec_T1)), std(Results(DiffSub_NDec_T1,2))/sqrt(length(DiffSub_NDec_T1))],'k');
er.LineStyle = 'none';
set(gca,'fontsize', 18);
title('Task 2 - Diff Subspace')
set(gca,'xticklabel', {'Dec', 'NotDec'})