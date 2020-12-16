clear all

[t1,t2,same,diff,name,data] = get_data_same_diff();

h=figure;

for n=2:length(name),
    
    subplot(2,1,n-1);
    
    s=data(same{n}.ind,:);
    plot(s','b');
    grid on
    hold on
    
    d=data(diff{n}.ind,:);
    plot(d','r');
    
    %legend('Same','Diff');
    title(name{n});
    %ylim([0.5, 0.9]);
    
    ylabel('Correct');
    xlabel('Block');
end
