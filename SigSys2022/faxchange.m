function faxchange(f)
% faxchange
% Ändrar frekvensaxlarna för spect och logspect

% Lasse Alfredsson, augusti 2004


UD=get(gcf,'userdata'); % userdata = [ax1_hand ax2_hand fmin_hand fmax_hand]

f_current=get(UD(1),'xlim'); 
if f    % fmax ändras
    fmax_new=str2num(get(UD(4),'string'));
    f_new=[f_current(1) fmax_new];
    set(UD(3),'string',num2str(f_current(1)))
else    % fmin ändras
    fmin_new=str2num(get(UD(3),'string'));
    f_new=[fmin_new f_current(2)];
    set(UD(4),'string',num2str(f_current(2)))
end

set(UD(1),'xlim',f_new)  
set(UD(2),'xlim',f_new)
