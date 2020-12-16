function [] = plot_learnt_maps (net)
% Plot learnt maps
% FORMAT [] = plot_learnt_maps (net)

for x=1:5,
    for y=1:5,
        if net.D==2
            R = bnn_fwd (net,[x,y]',net.task_index);
        else
            R = bnn_fwd (net,[x,y,6]',net.task_index);
        end
        
        for h=1:net.H1,
            layer1(h).map(x,y)=R.x1(h);
        end
        for h=1:net.H2,
            layer2(h).map(x,y)=R.x2(h);
        end      
        output_map(x,y)=R.y;        
    end   
end

f=figure;
set(f,'Name','Layer 1');
rH=ceil(sqrt(net.H1));
for h=1:net.H1,
    subplot(rH,rH,h);
    plot_map(layer1(h).map);
    title(sprintf('%s Unit %d',net.layer1,h));
end

f=figure;
set(f,'Name','Layer 2');
rH=ceil(sqrt(net.H2));
for h=1:net.H2,
    subplot(rH,rH,h);
    plot_map(layer2(h).map);
    title(sprintf('%s Unit %d',net.layer2,h));
end

f=figure;
set(f,'Name','Output Unit');
plot_map(output_map);
title('Output Unit');

