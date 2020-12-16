

clear all
close all

w=5*[1 -1];
%b=[-3 -3];
u=[2 -2];

wout=[1 1];
bout=0;

x=[-4:0.1:4];

a1=w(1)*(x-u(1));
h1=1./(1+exp(-a1));

a2=w(2)*(x-u(2));
h2=1./(1+exp(-a2));

aout=wout(1)*h1+wout(2)*h2+bout;
yout=1./(1+exp(-aout));

figure
plot(x,h1,'r');
hold on
grid on
plot(x,h2,'b');
plot(x,yout,'k');
