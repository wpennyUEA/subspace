function [] = plot_results (F1,F2,F3)

load_str=['load results/',F1];
eval(load_str);
subplot(2,2,1);
plot_task1_by_block(names,map);
title('Task 1');

subplot(2,2,2);
load_str=['load results/',F2];
eval(load_str);
plot_task2_by_block (task1_str,map2);
title('Task 2');

subplot(2,2,4);
load_str=['load results/',F3];
eval(load_str);
plot_task2_by_block (task1_str,map2);
title('Task 2');

