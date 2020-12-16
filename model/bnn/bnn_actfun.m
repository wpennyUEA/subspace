function [y] = bnn_actfun (x,name)
% Compute activation function 
% FORMAT [y] = bnn_actfun (x,name)
%
% x         activation
% name      'linear', 'sigmoid', 'RELU', 'GELU', 'SOFTPLUS', 'COS',
%           'gaussian', 'gabor'
%
% y         output

name = lower(name);
switch name,
    case 'linear',
        y = x;
        
    case 'sigmoid',
        y = 1./(1+exp(-x));
        
    case 'relu',
        y = (x>0).*x;
        
    case 'gelu',
        %cdf = spm_Ncdf(x,0,1);
        cdf = 0.5 + erf(x./sqrt(2))/2;
        y = x.*cdf;
        
    case 'softplus',
        y = log(1+exp(x));
        
    case 'cos',
        y= cos(x);
        
    case 'gaussian',
        y= exp(-x.^2);
        
    case 'gabor',
        a = 1/(1.5*pi);
        y = exp(-a*x.^2).*cos(x);
        
    otherwise
        disp('Error: Unknown activation function in bnn_actfun.m');
end