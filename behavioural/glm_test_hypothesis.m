function [glm] = glm_test_hypothesis (X,y,c,V)
% Hypothesis testing for General Linear Models
% FORMAT [glm] = glm_test_hypothesis (X,y,c,V)
%
% X         [N x k] design matrix
% y         [N x 1] data vector
% c         [k x d] Contrast vector or matrix defining the null hypothesis: c'*beta=0
%           d=1 defines one dimensional contrasts ie. simple hypothesis
%           d>1 defines multidimensional contrasts ie. compound hypotheses
% V         Variance component Structure (default is empty)
%
% glm       Output Data structure with fields:
%           .F         F-value
%           .p         Two-sided p-value
%           .beta      [k x 1] vector of regression coefficients
%           .effect    Estimated effect (ie. c'*beta)
%           .df        degrees of freedom

if nargin < 4
    % Variance component structure
    V=[];
end

[T,df,beta,xX,xCon] = spm_ancova(X,V,y,c);

% Two-sided p-value
[k,d] = size(c);
if d == 1, F=T^2; else F=T; end
p=1-spm_Fcdf(F,df(1),df(2));

% This, of course, gives same result
% p=2*(1-spm_tcdf(T,df(2)))

glm.F = F;
glm.p = p;
glm.beta = beta;
glm.effect = c'*beta;
glm.df = df;

