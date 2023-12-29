if H_AB | ABS_AB | h_AB
    try 
        load Uppgift62a
        load Uppgift62b
        
if H_AB 
    figure(621)
    pz(H_A)
    title('H_A[z]')
    ohfig
    
    figure(622)
    pz(H_B)
    title('H_B[z]')
    ohfig
end


if ABS_AB
    figure(623)
%    logspect(H_A,H_B)
    subplot(2,1,1)
    logspectmod(H_A)
    TIT_hand=get(gca,'title');
    TIT=get(TIT_hand,'string');
    set(TIT_hand,'string',['|H_A[\theta]|_{dB} :  ' TIT])
    
    subplot(2,1,2)
    logspectmod(H_B)
    TIT_hand=get(gca,'title');
    TIT=get(TIT_hand,'string');
    set(TIT_hand,'string',['|H_B[\theta]|_{dB} :  ' TIT])
    ohfig
end


if h_AB
    hA=iztr(H_A);
    hB=iztr(H_B);
    figure(624)
    signal(hA,hB,15)
    subplot(2,1,1)
    title('h_A[n]')
    axis([-5 15 0 0.5])
    subplot(2,1,2)
    title('h_B[n]')
    axis([-5 15 0 0.5])
    ohfig
end        
        
        
    catch
        disp('Du har inte sparat båda systemfunktionerna än.')
    end
end


