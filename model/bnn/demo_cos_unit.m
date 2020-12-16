

%net2.W2 = [1.2332, -1.9954, -5.2693, 0.6213]';
%net2.b2 = [-0.1178, -1.4141,-2.8586, 0.5870]';

figure
for i=1:4,
    x = [-2:0.1:7];
    a = net2.W2(i)*x + net2.b2(i);
    y = cos(a);
    
    
    subplot(2,2,i);
    plot(x,y);
    grid on
    title(sprintf('Unit %d',i));
end
