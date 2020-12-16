clear all
close all

totsbj = 80;
Results = zeros(totsbj,17);

for sbj = 1:80
    
    if mod(sbj,2) == 1 && sbj <= 40
        [D1,Y1] = get_expML_data (sbj,1 , 2.5, 0.2);
        D1.r(logical(D1.resp==0)) = [];
        D1.trlN(logical(D1.resp==0)) = [];
        D1.RT(logical(D1.resp==0)) = [];
        
        [D2,Y2] = get_expML_data (sbj,3 , 2.5, 0.);
        D2.r(logical(D2.resp==0)) = [];
        D2.trlN(logical(D2.resp==0)) = [];
        D2.RT(logical(D2.resp==0)) = [];
        
        threshold1 = binoinv(0.95,length(D1.r),0.5)/length(D1.r);
        threshold2 = binoinv(0.95,length(D2.r),0.5)/length(D2.r);

        
        Results(sbj,1:4) = [mean(D1.r), mean(D2.r), 0, 1];
        Results(sbj,6) = 1;
        
        if threshold1 > mean(D1.r) && threshold2 > mean(D2.r)
            Results(sbj,3) = 0;
        else
            Results(sbj,3) = 1;
        end
        
    elseif mod(sbj,2) == 0 && sbj > 40
        [D1,Y1] = get_expML_data (sbj,2 , 2.5, 0.2);
        D1.r(logical(D1.resp==0)) = [];
        D1.trlN(logical(D1.resp==0)) = [];
        D1.RT(logical(D1.resp==0)) = [];
        
        [D2,Y2] = get_expML_data (sbj,4 , 2.5, 0.1);
        D2.r(logical(D2.resp==0)) = [];
        D2.trlN(logical(D2.resp==0)) = [];
        D2.RT(logical(D2.resp==0)) = [];
        
        threshold1 = binoinv(0.95,length(D1.r),0.5)/length(D1.r);
        threshold2 = binoinv(0.95,length(D2.r),0.5)/length(D2.r);
        
        Results(sbj,1:4) = [mean(D1.r), mean(D2.r), 0, 1];
        
        if threshold1 > mean(D1.r) && threshold2 > mean(D2.r)
            Results(sbj,3) = 0;
        else
            Results(sbj,3) = 1;
        end
        
    elseif mod(sbj,2) == 0 && sbj <= 40
        [D1,Y1] = get_expML_data (sbj,2 , 2.5, 0.2);
        D1.r(logical(D1.resp==0)) = [];
        D1.trlN(logical(D1.resp==0)) = [];
        D1.RT(logical(D1.resp==0)) = [];
        
        [D2,Y2] = get_expML_data (sbj,3 , 2.5, 0.1);
        D2.r(logical(D2.resp==0)) = [];
        D2.trlN(logical(D2.resp==0)) = [];
        D2.RT(logical(D2.resp==0)) = [];
        
        threshold1 = binoinv(0.95,length(D1.r),0.5)/length(D1.r);
        threshold2 = binoinv(0.95,length(D2.r),0.5)/length(D2.r);
        
        Results(sbj,1:4) = [mean(D1.r), mean(D2.r), 0, 0];
        
        if threshold1 > mean(D1.r) && threshold2 > mean(D2.r)
            Results(sbj,3) = 0;
        else
            Results(sbj,3) = 1;
        end
        
    elseif mod(sbj,2) == 1 && sbj > 40
        [D1,Y1] = get_expML_data (sbj,1 , 2.5, 0.2);
        D1.r(logical(D1.resp==0)) = [];
        D1.trlN(logical(D1.resp==0)) = [];
        D1.RT(logical(D1.resp==0)) = [];
        
        [D2,Y2] = get_expML_data (sbj,4 , 2.5, 0.1);
        D2.r(logical(D2.resp==0)) = [];
        D2.trlN(logical(D2.resp==0)) = [];
        D2.RT(logical(D2.resp==0)) = [];
        
        threshold1 = binoinv(0.95,length(D1.r),0.5)/length(D1.r);
        threshold2 = binoinv(0.95,length(D2.r),0.5)/length(D2.r);
        
        Results(sbj,1:4) = [mean(D1.r), mean(D2.r), 0, 0];
        Results(sbj,6) = 1;
        
        if threshold1 > mean(D1.r) && threshold2 > mean(D2.r)
            Results(sbj,3) = 0;
        else
            Results(sbj,3) = 1;
        end
    else
        error('wrong task?')
    end
    
    %% Mean accuracy per block
    Temp1 = find(D1.trlN <= 50);
    Temp2 = find(D1.trlN > 50 & D1.trlN <= 100);
    Temp3 = find(D1.trlN > 100 & D1.trlN <= 150);
    Temp4 = find(D1.trlN > 150 & D1.trlN <= 200);
    Temp5 = find(D1.trlN > 200);
    
    Results(sbj,8) = mean(D1.r(Temp1));
    Results(sbj,9) = mean(D1.r(Temp2));
    Results(sbj,10) = mean(D1.r(Temp3));
    Results(sbj,11) = mean(D1.r(Temp4));
    Results(sbj,12) = mean(D1.r(Temp5));
    
    Temp1 = find(D2.trlN <= 50);
    Temp2 = find(D2.trlN > 50 & D2.trlN <= 100);
    Temp3 = find(D2.trlN > 100 & D2.trlN <= 150);
    Temp4 = find(D2.trlN > 150 & D2.trlN <= 200);
    Temp5 = find(D2.trlN > 200);
    
    Results(sbj,13) = mean(D2.r(Temp1));
    Results(sbj,14) = mean(D2.r(Temp2));
    Results(sbj,15) = mean(D2.r(Temp3));
    Results(sbj,16) = mean(D2.r(Temp4));
    Results(sbj,17) = mean(D2.r(Temp5));
    
    Results(sbj,18:21) = D1.break;
    Results(sbj,22:25) = D2.break;
    
end

Results([1:20, 41:60],5) = 1;
Results(1:40, 7) = 1;

dec_array = get_dec_table();

Results(:,26:29) = dec_array;

%% Results Matrix
% Col 1 = mean accuracy task 1
% Col 2 = mean accuracy task 2
% Col 3 = 1 if at least 1 task is above chance
% Col 4 = 1 if same subspace 0 if not
% Col 5 = 1 if 12 seconds, 0 if 2 minutes (break)
% Col 6 = 1 if Task 1, 0 if 2
% Col 7 = 1 if Task 3, 0 if 4
% Col 8 to 12 = mean accuracy for task 1, block 1 to 5
% Col 13 to 17 = mean accuracy for task 2, block 1 to 5
% Col 18 to 21 = break length task 1
% Col 22 to 25 = break length task 2
% Col 26 to 29 = declaration on task 1 to 4


save Results Results