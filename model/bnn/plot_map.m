function [] = plot_map (map)
% Plot Reward Probability Map
% FORMAT [] = plot_map (map)

imagesc(map);
colormap(gray);
set(gca,'XTick',[1:5]);
set(gca,'YTick',[1:5]);
axis xy
xlabel('u_2');
ylabel('u_1');
colorbar;