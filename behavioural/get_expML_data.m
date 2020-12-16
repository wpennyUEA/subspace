function [D,Y] = get_expML_data (sbj, tsk, maxRT, minRT)
% Format empirical data for analysis
% FORMAT [D,Y] = get_expML_data (sbj, tsk, maxRT, minRT)
% The function taskes as input subjs number, tasks number and RTs max and
% min threshold. Result D will be a structure where:
%- D.resp is 1 if participant responded to the trial (0 otherwise)
%- D.r is the feedback the participant received, 1 correct, 0 incorrect or
% no response
%- D.RT is reaction time
%- D.u is combinations number
%- D.trlN trial number
%- D.outcome is outcome
%- D.coordinates are the the coordinates in space
%- D.break is the length in seconds of the break
%- Y is participant response

%nicho_path='C:\Users\bzv17fbu\laptop\uea\lockdown\other\nicholas-menghi\';
%nicho_path='C:\Users\bzv17fbu\laptop\uea\people\nicholas-menghi\';
%nicho_path='C:\Users\bzv17fbu\uea\people\nicholas-menghi\';
%data_path='transfer-learning\data-explanation-and-functions';

nicho_path='C:\Users\bzv17fbu\laptop\uea\lockdown\other\subspace\';
data_path='behavioural-data\data-explanation-and-functions';

load([nicho_path,data_path,'/sbj/sbj',num2str(sbj),'/sbj',num2str(sbj),'-Task',num2str(tsk),'.mat'])

k=1;
for i=1:5,
    for j=1:5,
        left_sides(k)=i;
        right_sides(k)=j;
        k=k+1;
    end
end

T=length(Results);
for t=1:T
    D.u(t)=Results(t,2); % Stimulus index
    D.trlN(t) = Results(t,1);
    if Results(t,6)==2 || Results(t,4)>maxRT || Results(t,4)<minRT
        D.resp(t)=0;
        D.r(t)=0;
    else
        D.resp(t)=1;
        D.r(t)=Results(t,6);
    end
    Y(t) = Results(t,5)==1;
    D.RT(t)=Results(t,4); % Reaction time
    D.outcome(t) = Results(t,3);
    
    
    D.coordinates(1,t) = left_sides(D.u(t));
    D.coordinates(2,t) = right_sides(D.u(t));
end

% Ensure column (not row) vectors are used
D.outcome = D.outcome(:);
D.resp=D.resp(:);
D.u=D.u(:);
D.r=D.r(:);
D.RT=D.RT(:);
D.break = Endbreak;
Y=Y(:);
