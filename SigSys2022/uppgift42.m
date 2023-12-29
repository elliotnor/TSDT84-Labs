if alt==1
    try
        load Uppgift42
        disp('HP-filtret är hämtat!')
    catch
        disp('Tyvärr, du har inte sparat något HP-filter än.')
    end
    
    

elseif alt==2
    try
        pzchange(H_HP);
    catch
        pzchange;
    end
    
    
    
elseif alt==3
    global TRFM
    H_HP = TRFM;
    save Uppgift42 H_HP;
    disp('HP-filtret är sparat!')
    
    
    
elseif alt==4
    figure(421), pz(H_HP); ohfig
    title('Pol-nollställediagram för H_{HP}(s)')
    figure(422), logspectmod(H_HP,fmax); ohfig
    hold on, plot([0 fmax],[-3 -3],'--k'), plot([0 fmax],[0 0],'--k')
    plot([30 30],[-50 5],'--k'), hold off
    axis([0 fmax -40 5]), yticks([-30 -20 -10 -3 0])
    xax=get(gca,'Xtick'); if isempty(find(xax==30)), set(gca,'xtick',sort([30 xax])),end
    
end
