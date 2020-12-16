

clear all
close all

w=3*[1 -1];

wout=[1 1];
bout=-4;

reverse=1;
if reverse
    wout=-wout;bout=-bout;
end

x=[-4:0.1:4];

a1=w(1)*x;
h1=(a1>0).*a1;

a2=w(2)*x;
h2=(a2>0).*a2;

aout=wout(1)*h1+wout(2)*h2+bout;
yout=1./(1+exp(-aout));

figure
plot(x,h1,'r');
hold on
grid on
plot(x,h2,'b');
plot(x,yout,'k');
