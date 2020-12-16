function [p,stats] = glm_anova1 (group, Xc)
% GLM implementation of One-Way ANOVA
% FORMAT [p,stats] = glm_anova1 (group, Xc)
%
% group(g).x        variables
% group(g).name     name
% Xc                [N x C] matrix containing confounds to regress-out/control-for
%                   where C is number of confounding variables
%                   N is total number of data points 
%
% p                 p-value
% stats             see glm_test_hypothesis.m plus
%                   .X      design matrix
%                   .y      data vector

G=length(group);

disp(' ');
y=[];gr=[];
X=[];
Nchk=0;
for g=1:G,
    x=group(g).x(:);
    m=mean(x);
    N=length(x);
    Nchk=Nchk+N;
    sem=std(x)/sqrt(N-1);
    disp(sprintf('Mean %s = %1.3f, SEM = %1.3f',group(g).name,m,sem));
    y=[y;x];
    gr=[gr;g*ones(N,1)];
    X=blkdiag(X,ones(N,1)); 
end
if nargin > 1
    % Add confounds if specified
    [N,C] = size(Xc);
    if ~(N==Nchk)
        disp('Error in glm_anova1.m');
        disp(sprintf('Columns in Xc (=%d) not equal to total number of datapoints (=%d)',N,Nchk));
        return
    end
    X = [X, Xc];
    confounds=1;
else
    confounds=0;
end

Con = spm_make_contrasts(G);
c = Con(2).c; % Main effect of group is the 2nd contrast
if confounds
    % Pad contrast matrix with zeros 
    [d,k]=size(c);
    c=[c,zeros(d,C)];
end
stats = glm_test_hypothesis (X,y,c');
p = stats.p;
stats.X = X;
stats.y = y;

disp(sprintf('df=%d p=%g', stats.df(2),p));
disp(' ');

