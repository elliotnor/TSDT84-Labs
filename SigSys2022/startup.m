%STARTUP Initiering av Kretslab.
%    
%    Beskrivning:
%    Startupfilen körs automatiskt när man startar Matlab och om Kretslab 
%    ligger först i Matlabs sökväg. Den definierar ett antal globala variabler 
%    som används av Kretslab. Om man skulle råka ta bort eller definiera om 
%    dessa variabler (t.ex. om man råkar använda pack) kan initieringen göras om 
%    utan att starta om Matlab genom att skriva startup.
%
%    Kretslabs globala variabler är  pm1, pm2, pm3, pm4, KlabL och FSMAX:
%       * Variablerna pm1, pm2, pm3 och pm4 kan användas av DIG i
%         kretslabfunktioner där en önskad variabel förekommer i ett
%         textuttryck. 
%         Exempel: pm1=0.2; pm2=14; x=in('pm1*sin(2*pi*pm2*t)','t');
%       * KlabL och FSMAX skall/får normalt INTE ändras av användaren.
%         KlabL anger längden på Kretslabs signalvektorer (65536) och
%         FSMAX är den högsta sampelfrekvens (6400 Hz) som används av 
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
disp('KRETSLAB ÄR INITIERAD!')
disp('(Ett antal globala variabler är definierade)')
disp(' ')
disp('För den intresserade (men behövs ej för att lösa uppgifterna):')
disp('Om du skriver ''kretslab'' i kommandofönstret så öppnas ett')
disp('hjälpfönster där tollboxens funktioner är beskrivna.')
disp(' ')


