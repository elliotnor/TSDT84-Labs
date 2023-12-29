if alt==1
    try 
        load Uppgift62a, 
            disp(' ')
        disp('Systemfunktionen H_A[z] är hämtad!')
    catch 
        disp('Du har inte sparat systemfunktionen än.')
    end
    

elseif alt==2
    try
        pzchange(H_A);
    catch
        pzchange('z');
    end
    
    
elseif alt==3
    global TRFM
    H_A = TRFM;
    save Uppgift62a H_A;
    disp(' ')
    disp('Din systemfunktion H_A[z] är sparad!')
    
end
