%STARTUP Initiering av Kretslab.
%    
%    Beskrivning:
%    Startupfilen k�rs automatiskt n�r man startar Matlab och om Kretslab 
%    ligger f�rst i Matlabs s�kv�g. Den definierar ett antal globala variabler 
%    som anv�nds av Kretslab. Om man skulle r�ka ta bort eller definiera om 
%    dessa variabler (t.ex. om man r�kar anv�nda pack) kan initieringen g�ras om 
%    utan att starta om Matlab genom att skriva startup.
%
%    Kretslabs globala variabler �r  pm1, pm2, pm3, pm4, KlabL och FSMAX:
%       * Variablerna pm1, pm2, pm3 och pm4 kan anv�ndas av DIG i
%         kretslabfunktioner d�r en �nskad variabel f�rekommer i ett
%         textuttryck. 
%         Exempel: pm1=0.2; pm2=14; x=in('pm1*sin(2*pi*pm2*t)','t');
%       * KlabL och FSMAX skall/f�r normalt INTE �ndras av anv�ndaren.
%         KlabL anger l�ngden p� Kretslabs signalvektorer (65536) och
%         FSMAX �r den h�gsta sampelfrekvens (6400 Hz) som anv�nds av 
%         de flesta Kretslabfunktioner, exempelvis funktionen in.
%    
%    See also:
%    CLEANUP
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
pm1=0;
pm2=0;
pm3=0;
pm4=0;
KlabL=65536;    % Signal and spectrum vector length (65536)
FSMAX=6400;     % Maximum sample frequency for representing time continuous signals using the in function (earlier: 400  now: 6400)

disp(' ')
disp('KRETSLAB �R INITIERAD!')
disp('(Ett antal globala variabler �r definierade)')
disp(' ')
disp('F�r den intresserade (men beh�vs ej f�r att l�sa uppgifterna):')
disp('Om du skriver ''kretslab'' i kommandof�nstret s� �ppnas ett')
disp('hj�lpf�nster d�r tollboxens funktioner �r beskrivna.')
disp(' ')


