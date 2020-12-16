function [STS] = simple_regress (y,x)
% Plot simple regression line
% FORMAT [STS] = simple_regress (y,x)
%
% y         dependent variable
% x         independent variable
%
% STS   .yhat   fit
%       .err    errors
%       .beta   regression coefficients
%       .xplot  x coords of best fitting line
%       .yplot  y coords of best fitting line
%
% To plot line of best fit:
% plot(STS.xplot,STS.yplot,'k');


y=y(:); x=x(:);
N=length(y);

X=[x,ones(N,1)];
beta=pinv(X)*y;
yhat=X*beta;

xmin=min(x);
xmax=max(x);
dx=(xmax-xmin)/100;
xplot=[xmin:dx:xmax]';
Np=length(xplot);
Xplot=[xplot,ones(Np,1)];
yplot=Xplot*beta;

STS.yhat=yhat;
STS.err=y-yhat;
STS.beta=beta;
STS.xplot=xplot;
STS.yplot=yplot;

