function []= plot_task2_by_block (task1_str,map2)

B=length(map2(1).me);

for i=1:length(map2),
    errorbar([1:B]+0.05*(i-1),map2(i).me,map2(i).seme);
    hold on
    grid on
    xlabel('Block');
    ylabel('Average Expected Reward');
    comb_str{i}=[task1_str,'-',map2(i).name];
end
legend(comb_str);
xlim([0.9 B+0.5]);
set(gca,'XTick',[1:B]);