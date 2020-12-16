function [X] = zmuv (X)
% Make all columns of X have zero mean and unit variance
% FORMAT [X] = zmuv (X)

P=size(X,2);
for p=1:P,
    x=X(:,p);
    m=mean(x);
    s=std(x);
    X(:,p)=(x-m)/s;
end