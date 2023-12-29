if exist('HBPs') & exist('HBPz') % Både H(s) och H[z] är skapade

if pzHsz==1      % Starta pzchange med H(s)
    pzchange(HBPs);
elseif pzHsz==2 % Starta pzchange med H[z]
    pzchange(HBPz);
end

else
    disp("Du har inte skapat H(s) och H[z] än!");
    disp(' ')
end