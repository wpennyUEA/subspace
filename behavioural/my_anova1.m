function [p,stats] = my_anova1 (group)
% One-Way ANOVA
% FORMAT [p,stats] = my_anova1 (group)
%
% group(g).x        variables
% group(g).name     name
%
% p                 p-value
% stats             see anova1.m

G=length(group);

disp(' ');
y=[];gr=[];
for g=1:G,
    x=group(g).x(:);
    m=mean(x);
    N=length(x);
    sem=std(x)/sqrt(N-1);
    disp(sprintf('Mean %s = %1.3f, SEM = %1.3f',group(g).name,m,sem));
    y=[y;x];
    gr=[gr;g*ones(N,1)];
end
disp(' ');

[p,tmp,stats]=anova1(y,gr);

disp(sprintf('df=%d, p=%g', stats.df,p));
disp(' ');

