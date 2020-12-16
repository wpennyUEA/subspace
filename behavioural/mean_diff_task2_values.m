clear all

[t1,t2,same,diff,name] = get_data_same_diff();

disp('Task 2 Means:');
for n=1:3,
    
    disp('---------------------------------');
    disp(sprintf('Task 1 = %s',name{n}));
    
    ms = mean(t2(same{n}.ind));
    md = mean(t2(diff{n}.ind));
    disp(sprintf('Task 2, Same = %1.3f, Diff = %1.3f, Delta = %1.3f',ms,md,ms-md));
    
end