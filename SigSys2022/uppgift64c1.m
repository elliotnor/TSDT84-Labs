[B, A] = cheby1(2, 3, 2*pi*[941 1209], 's');
HBPs = in(B, A, 's');

try
    load MinaTheta
    [B, A] = cheby1(2, 3, 2*[thetaP1 thetaP2]);
    HBPz = in(B, A, 'z');
    disp('Systemfunktionerna är skapade!')
    disp(' ')
    
catch
   disp("Du måste spara de normerade gränsfrekvenserna");
   disp("ovan för att H[z] ska kunna skapas.");
   disp(' ')
end



        