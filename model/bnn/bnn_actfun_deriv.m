function [dydx] = bnn_actfun_deriv (x,name)
% Compute activation function derivative
% FORMAT [dydx] = bnn_actfun_deriv (x,name)
%
% x         activation
% name      'linear', 'sigmoid', 'RELU', 'GELU', 'SOFTPLUS', 'COS',
%           'gaussian', 'gabor'
% y         output
% dydx      derivative of output

name = lower(name);
switch name,
    case 'linear',
        dydx = 1;
        
    case 'sigmoid',
        y = 1./(1+exp(-x));
        dydx = y.*(1-y);
        
    case 'relu',
        dydx = (x>0);
        
    case 'gelu',
        %cdf = spm_Ncdf(x,0,1);
        %pdf = spm_Npdf(x,0,1);
        %r2p=1/sqrt(2*pi);
        cdf = 0.5 + erf(x./sqrt(2))/2;
        r2p = 0.3989;
        pdf = r2p*exp(-0.5*x.^2);
        dydx = cdf + x.*pdf;
        
    case 'softplus',
        dydx = 1./(1+exp(-x));
        
    case 'cos',
        dydx = -sin(x);
        
    case 'gaussian',
        y = exp(-x.^2);
        dydx = -2*x.*y;
        
    case 'gabor',
        a = 1/(1.5*pi);
        u = exp(-a*x.^2);
        du = -2*a*u.*x;
        v = cos(x);
        dv = -sin(x);
        dydx = u.*dv+v.*du;
        
    otherwise
        disp('Error: Unknown activation function in bnn_actfun_deriv.m');
end