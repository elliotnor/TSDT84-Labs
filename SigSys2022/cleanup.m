%CLEANUP Minneskompaktering.
%
%    
%    Beskrivning:
%    cleanup använder Matlabkommandot pack för att kompaktera minnet, men 
%    håller dessutom reda på de globala variabler som används av Kretslab.
%    
%    See also:
%    STARTUP
%    

QQQqqq=[KlabL pm1 pm2 pm3 pm4 FSMAX];
clear KlabL pm1 pm2 pm3 pm4 FSMAX
pack
global KlabL pm1 pm2 pm3 pm4 FSMAX
KlabL=QQQqqq(1);
pm1=QQQqqq(2);
pm2=QQQqqq(3);
pm3=QQQqqq(4);
pm4=QQQqqq(5);
FSMAX=QQQqqq(6);
clear QQQqqq
