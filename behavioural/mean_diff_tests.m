clear all

[t1,t2,same,diff,name] = get_data_same_diff();
task_diff = t2-t1;

for n=1:length(name),
    
    disp('---------------------------------');
    disp(name{n});
    
    disp('Same Subspace, Are Means Different?');
    my_ttest_paired(t2(same{n}.ind),t1(same{n}.ind),{'Task2','Task1'});
    
    disp('Diff Subspace, Are Means Different?');
    my_ttest_paired(t2(diff{n}.ind),t1(diff{n}.ind),{'Task2','Task1'});
    
    disp('Interaction (task * subspace):');
    my_ttest2 (task_diff(same{n}.ind),task_diff(diff{n}.ind),{'Same','Diff'});
    
end


