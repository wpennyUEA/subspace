function [mx,my] = my_ttest2 (x,y,labels)
% Two-Sample T-test
% FORMAT [mx,my] = my_ttest2 (x,y,labels)

mx=mean(x);
my=mean(y);
disp(' ');
disp(sprintf('Mean %s = %1.3f',labels{1},mx));
disp(sprintf('Mean %s = %1.3f',labels{2},my));

[h,p,ci,stats]=ttest2(x,y);

disp(sprintf('t=%1.3f, df=%d, p=%g', stats.tstat,stats.df,p));
disp(' ');