function [md,p,stats] = my_ttest_paired (x,y,labels)
% Paired Samples T-test
% FORMAT [md,p,stats] = my_ttest_paired (x,y,labels)

md=mean(x-y);
disp(' ');
disp(sprintf('Mean %s minus %s = %1.3f',labels{1},labels{2},md));

[h,p,ci,stats]=ttest(x,y);

disp(sprintf('t=%1.3f, df=%d, p=%g', stats.tstat,stats.df,p));
disp(' ');