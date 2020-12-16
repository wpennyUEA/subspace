function [] = plot_task1_by_block(names,map)

B=length(map(1).me);

for i=1:length(names),
    errorbar([1:B]+0.05*(i-1),map(i).me,map(i).seme);
    hold on
    grid on
    xlabel('Block');
    ylabel('Average Expected Reward');
end
legend(names);
xlim([0.9 B+0.5]);
set(gca,'XTick',[1:B]);