if alt==1
    try
        load Uppgift43
        disp('LP-filtret är hämtat!')
    catch
        disp('Tyvärr, du har inte sparat något LP-filter än.')
    end
    
    
elseif alt==2
    try
        pzchange(H_LP);
    catch
        pzchange;
    end
    
    
elseif alt==3
    global TRFM
    H_LP = TRFM;
    save Uppgift43 H_LP;
    disp('LP-filtret är sparat!')
    
    
elseif alt==4
    figure(431), pz(H_LP); ohfig
    title('Pol-nollställediagram för H_{LP}(s)')
    figure(432), logspectmod(H_LP,fmax); ohfig
    hold on, plot([0 fmax],[-3 -3],'--k'), plot([0 fmax],[0 0],'--k')
    plot([30 30],[-50 5],'--k'), hold off
    axis([0 fmax -40 5]), yticks([-30 -20 -10 -3 0])
    xax=get(gca,'Xtick'); if isempty(find(xax==30)), set(gca,'xtick',sort([30 xax])),end
    
end
