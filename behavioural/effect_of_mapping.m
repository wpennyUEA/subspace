
clear all
close all

load Results

% Extract average accuracies for the four mappings
idxTask1 =  find(Results(:,3) == 1 & Results(:,6) == 1);
idxTask2 = find(Results(:,3) == 1 & Results(:,6) == 0);
idxTask3 =  find(Results(:,3) == 1 & Results(:,7) == 1);
idxTask4 = find(Results(:,3) == 1 & Results(:,7) == 0);

Rule1 = Results(idxTask1,1);
Rule2 = Results(idxTask2,1);
Rule3 = Results(idxTask3,2);
Rule4 = Results(idxTask4,2);

rN = sqrt(length(idxTask1));

map_names = {'Sub1', 'Add1', 'Sub2', 'Add2'};
rule_means = [mean(Rule1), mean(Rule2), mean(Rule3), mean(Rule4)];
rule_sems = [std(Rule1)/rN, std(Rule2)/rN, std(Rule1)/rN, std(Rule1)/rN];

figure
bar(rule_means);
hold on
er = errorbar(rule_means, rule_sems,'k');
er.LineStyle = 'none';
ylabel('Accuracy')
set(gca,'xticklabel', map_names)
set(gca,'fontsize', 18);
grid on
ylim([0.5,0.8]);

labels={'Nonlinear','Linear'};
my_ttest2 ([Rule1;Rule2],[Rule3;Rule4],labels);

labels={'Add','Sub'};
my_ttest2 ([Rule2;Rule4],[Rule1;Rule3],labels);
