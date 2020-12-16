clear all
close all

[t1,t2,same,diff,name,data] = get_data_same_diff();

h=figure;

for n=2:length(name),
    
    subplot(2,1,n-1);
    
    s=data(same{n}.ind,:);
    
    for b=1:5,
        [R,P,RLO,RUP]=corrcoef(s(:,5),s(:,5+b));
        r(b)=R(1,2);p(b)=P(1,2);
        rl(b)=RLO(1,2);rh(b)=RUP(1,2);
    end
    
    errorbar([1:5],r,abs(r-rl),abs(rh-r));
    grid on
    hold on
    
    
    
    d=data(diff{n}.ind,:);
    for b=1:5,
        [R,P,RLO,RUP]=corrcoef(d(:,5),d(:,5+b));
        r(b)=R(1,2);p(b)=P(1,2);
        rl(b)=RLO(1,2);rh(b)=RUP(1,2);
    end
    
    errorbar([1:5]+0.1,r,abs(r-rl),abs(rh-r));
    
    %plot(r,'r');
    
    legend('Same','Diff');
    title(name{n});
    %ylim([0.5, 0.9]);
    xlim([0.8,5.2]);
    
    ylabel('Correlation');
    
    set(gca,'XTick',[1:5]);
end

xlabel('Block');