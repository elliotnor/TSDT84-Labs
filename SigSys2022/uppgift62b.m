if alt==1
    try 
        load Uppgift62b, 
            disp(' ')
        disp('Systemfunktionen H_B[z] är hämtad!')
    catch 
        disp('Du har inte sparat systemfunktionen än.')
    end
    

elseif alt==2
    try
        pzchange(H_B);
    catch
        pzchange('z');
    end
    
    
elseif alt==3
    global TRFM
    H_B = TRFM;
    save Uppgift62b H_B;
    disp(' ')
    disp('Din systemfunktion H_B[z] är sparad!')
    
end
