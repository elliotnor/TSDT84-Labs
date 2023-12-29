function pzchange(H);
% PZCHANGE Grafiskt verktyg verktyg för skapande av transformer
%     PZCHANGE      - motsvarar pzchange('s')
%     PZCHANGE(H)   - pzchange startas med laplace- eller z-transformen H
%     PZCHANGE('s') eller PZCHANGE S - pzchange startas med laplacetransformen H(s)=1
%     PZCHANGE('z') eller PZCHANGE Z - pzchange startas med z-transformen H[z]=1
%     PZCHANGE('p') eller PZCHANGE P - PZCHANGE startas med den i pzchange senast använda transformen 
%                       (= den globala variabeln TRFM - läs mer om den nedan)
%    
%     Med PZCHANGE kan man skapa och/eller modifiera en laplace- eller z-transform
%     genom att placera ut poler och nollställen med hjälp av musen.
%     Transformens pol-nollställediagram samt motsvarande amplitudkaraktäristik (-spektrum)
%     och faskaraktäristik (-spektrum) visas i samma figurfönster.
%     Det finns flera  utritningsvarianter, som t.ex. linjär skala och dB-skala, 
%     och man kan själv ändra gränserna för frekvensområdet. 
%     I pol-nollställediagrammet ritas poler som 'X' och nollställen 
%     som 'O'. Den aktuella polen/nollstället är alltid rödfärgad.
%    
%     En aktuell pol/nollställe kan påverkas på olika sätt - exempelvis flytta den 
%     till valfri position m.h.a. musen, flytta till reella axeln, imaginära axeln 
%     eller enhetscirkeln (det sistnämnda gäller endast z-transformer), tag bort den
%     eller ändra multiplicitet. Den aktuella polen/nollstället visas (i rektangulär 
%     eller polär form) under pol-nollställediagrammet. Polens/nollställets position 
%     kan även ändras direkt i dessa redigerbara fält.
%     Man kan då även skriva in en position som t.ex. 'sqrt(2)'.
%     De flesta händelser kan väljas från någon lämplig meny.
%    
%     Musknappar:
%            Vänster: Lägg till pol/nollställe i muspekarens position
%            Mitten:  Toggla mellan pol- och nollställe'mode'
%            Höger:   Välj, som aktuell pol eller nollställe, den pol/nollställe som 
%                     är närmast muspekarens position
%    
%     Om du har en mus med färre än tre knappar, så kan du få fram tre knappar på skärmen
%     som har motsvarande musknappsfunktioner.
%     Gör lämpligt val under menyn 'Information'.
%    
%     Välj 'Quit' i menyn för att avsluta pzchange. Den aktuella laplace- eller z-transformen 
%     erhålls då i 'workspace' som den globala variabeln TRFM.
%     (Notera att när pzchange används kan man alltid få tillgång till aktuell
%     transform som den globala variabeln TRFM (skriv 'global TRFM') ).
% 
%     See also: in, trfcn, output, pz, spect, logspect

% (c) Lasse Alfredsson, januari 1995-december 2020

% OBS!! PZCHANGE needs the following functions: PZMENU, PZSPPLOT, PZACTION and GINPUT2

global TRFM THEFIG MENUFLG	% TRFM is the name of the transform that will be 
global REDX REDO TEXT1 NORMMODE1 NORMMODE2	% created/changed. THEFIG is the corrent figure.
				% MENUFLG is set whenever a menu choice is made
global MOUSEMODE		% MOUSEMODE is set to 0 if the mouse buttons are used (default)
				 % If pushbuttons are chosen => MOUSEMODE=1,2, or 3
global lw 		 % Linewidth
global PSZ		 % Marker sizes for zeros(PSZ(1)  )
				 % an zeros ( PSZ(2) )
global EXTRAdata % Används för att hantera pol- och nollställepositioner, 
                 % aktuell t pol/nollställemode m.m. Totalt 7 parametrar


if     nargin<1,  H=[6 0 1;0 0 1]; t_type=0; disp('Laplacetransform!')
elseif nargin==1, 
  if     H=='s', H=[6  0 1;0 0 1];
  elseif H=='z', H=[10 0 1;0 0 1]; 
  elseif H=='p', H=TRFM; 
  end
  if     vtype(H)==6,  t_type=0; disp('Laplacetransform!') 
  elseif vtype(H)==10, t_type=1; disp('z-transform!')
  else error('Fel insignal: Varken laplacetransform eller z-transform!')
  end
end

TRFM=H;
QUITPGM=0;
REDX='xr';
REDO='or';
MOUSEMODE=0;
lw=2;
PSZ=[10 14];
%Create a window:

THEFIG=figure('Position',[20 100 1600 900],'Name','PZCHANGE'); %Aktuell fönsterstorlek 16x19
%THEFIG=figure('Position',[20 100 1100 650],'Name','PZCHANGE');
%THEFIG=figure('Position',[10 40 1000 768],'Name','PZCHANGE');  % Gammal figurfönsterstorlek

%Menu settings:

men1 = uimenu('label','Info ');
       uimenu(men1,'label','Musknappar:');
       uimenu(men1,'label','      Vänster - Lägg till pol/nollställe vid markörpositionen (pekartypen anger om det är pol eller nollställe som läggs till)');
       uimenu(men1,'label','      Mitten - Toggla mellan pol-läge och nollställe-läge');
       uimenu(men1,'label','      Höger - Välj/aktivera polen/nollstället närmast markören');
       uimenu(men1,'label','Pekartyp:');
       uimenu(men1,'label','        "+" => pol-läge (lägg till och manipulera poler)');
       uimenu(men1,'label','        "O" => nollställe-läge (lägg till och manipulera nollställen)');
       uimenu(men1,'label','           ');
    
       uimenu(men1,'label','Om du inte har en mus med tre knappar eller bara kan använda en musknapp, så kan i stället tre motsvarande "knappar"') ;
       uimenu(men1,'label','visas till vänster om pol-nollställediagrammet, som motsvarar musknapparna: KLICKA DÅ HÄR!','callback','pzmenu(''Mouse'')');

% sub1 = uimenu(men1,'label',['Om du inte har en mus med tre knappar =>  Visa tre "knappar"        ' ; ...
%                            'till vänster om pol-nollställediagrammet, som motsvarar musknapparna'], ...
%                            'callback','pzmenu(''Mouse'')');

% Följande menyval är knappast aktuellt längre ? borttagen nov 2020
% uimenu(sub1,'label','Visa tre "knappar" till vänster om pol-nollställediagrammet, som motsvarar musknapparna', ...
%              'callback','pzmenu(''Mouse'')');
%       sub2 = uimenu(men1,'label','Om du har en monokrom skärm =>');
%       uimenu(sub2,'label','Rita vitt i stället för rött','callback','pzmenu(''B&W'')');

menq = uimenu('label','Avsluta ');
       uimenu(menq,'label','Avsluta pzchange. Transformen finns i den globala variabeln TRFM.', ...
	      'callback','pzquit');

men2 = uimenu('label','Ta bort ','Interruptible','on');
       uimenu(men2,'label','Tag bort aktuell pol/nollställe', ...
              'callback','pzmenu(''D'',''pres'')');
       uimenu(men2,'label','Tag bort alla poler eller nollställen (beroende på pol/nollställeläge) inom en rektangel, som du markerar','Interruptible','on', ...
	      'Callback','pzmenu(''D'',''box'')');
       uimenu(men2,'label','Tag bort alla poler och nollställen', ...
              'callback','pzmenu(''D'',''all'')');
men3 = uimenu('label','Multiplicitet ');
       uimenu(men3,'label','0','callback','pzmenu(''D'',''pres'')');
       uimenu(men3,'label','1','callback','pzmenu(''M'',''1'')');
       uimenu(men3,'label','2','callback','pzmenu(''M'',''2'')');
       uimenu(men3,'label','3','callback','pzmenu(''M'',''3'')');
       uimenu(men3,'label','4','callback','pzmenu(''M'',''4'')');
       uimenu(men3,'label','5','callback','pzmenu(''M'',''5'')');
       uimenu(men3,'label','6','callback','pzmenu(''M'',''6'')');
       uimenu(men3,'label','7','callback','pzmenu(''M'',''7'')');
       uimenu(men3,'label','8','callback','pzmenu(''M'',''8'')');
       uimenu(men3,'label','9','callback','pzmenu(''M'',''9'')');
sub3 = uimenu(men3,'label','Justera');
       uimenu(sub3,'label','+1','callback','pzmenu(''M'',''currm+1'')');
       uimenu(sub3,'label','+2','callback','pzmenu(''M'',''currm+2'')');
       uimenu(sub3,'label','+4','callback','pzmenu(''M'',''currm+4'')');
       uimenu(sub3,'label','-1','callback','pzmenu(''M'',''max(currm-1,0)'')');
       uimenu(sub3,'label','-2','callback','pzmenu(''M'',''max(currm-2,0)'')');
       uimenu(sub3,'label','-4','callback','pzmenu(''M'',''max(currm-4,0)'')');
       uimenu(sub3,'label','*2','callback','pzmenu(''M'',''2*currm'')');
       uimenu(sub3,'label','/2','callback','pzmenu(''M'',''ceil(currm/2)'')');
men5 = uimenu('label','Flytta ');
       uimenu(men5,'label','Flytta till ny position', ...
              'callback','pzmenu(''Move'',''z'')');
       uimenu(men5,'label','Flytta till reella axeln','callback','pzmenu(''Move'',''re'')');
       uimenu(men5,'label','Flytta till imaginära axeln', ...
              'callback','pzmenu(''Move'',''im'')');
if t_type	% z-transform
       uimenu(men5,'label','Flytta till enhetscirkeln', ...
              'callback','pzmenu(''Move'',''unit'')');
end
men6 = uimenu('label','Koordinater ');
       uimenu(men6,'label','Rektangulära koordinater','callback','pzmenu(''C'',''rect'')');
       uimenu(men6,'label','Polära koordinater','callback','pzmenu(''C'',''polar'')');
men7 = uimenu('label','Axelgradering ');
       uimenu(men7,'label','Automatisk axelgradering av pol-nollställediagrammet','callback','pzspplot(''P&Z'',''Fulpl'')');
       uimenu(men7,'label','Automatisk axelgradering av amplitud-och fasgraferna','callback','pzspplot(''Spe'',''Fulpl'')');
%       Följande är BORTTAGEN 2020-11-12, behövs inte längre, eftersom man kan zooma själv i graferna sedan ett tag!! 
%       uimenu(men7,'label','Zoom PZ plot','callback','pzmenu(''Z'')')
men8 = uimenu('label','Amplitudgrafen ');
       uimenu(men8,'label','Linjär amplitudskala','callback','pzmenu(''Magn'',1)');
       uimenu(men8,'label','Decibelskala: -100 to +20 dB', ...
              'callback','pzmenu(''Magn'',2)');
       uimenu(men8,'label','Decibelskala: -5 to +5 dB ','callback','pzmenu(''Magn'',3)');
men9 = uimenu('label','Normera ');
       NORMMODE1=0; NORMMODE2=men9;
%       uimenu(men9,'label','Normalize mode is OFF (click to toggle!)', ...
       uimenu(men9,'label','Amplitudnormering AV (klicka för att toggla!)', ...
              'callback','pzmenu(''N'',1)');
men0 = uimenu('label','Poler/Nollst. ');
%       uimenu(men0,'label','Skriv ut figuren','callback','print');  & Onödig - borttagen 20201112
       uimenu(men0,'label','Skriv polernas och nollställenas positioner i kommandofönstret', ...
              'callback','pzmenu(''PoZeplot'')');
mena = uimenu('label','3D-plot ');
       uimenu(mena,'label','Rita en 3D-graf av transformen', ...
              'callback','pzmenu(''3Dplot'');')

   menb = uimenu('label','Pol-nollst.vektorer ');
       uimenu(menb,'label','Rita pol-nollställevektorer och motsvarande värden i amplitud- och fasgraferna', ...
              'callback','global THEFIG, set(THEFIG,''WindowButtonDownFcn'',''''); pzmenu(''SpectVect'');')
       uimenu(menb,'label','Tag bort pol-nollställevektorerna', ...
              'callback','global WSLIDER REGTIT, if ~isempty(WSLIDER), delete(WSLIDER),pzspplot(''P&Z'',''PZmen''),pzspplot(''Spe'',''Scale'',1),set(THEFIG,''WindowButtonDownFcn'',''pzaction''), delete(REGTIT), end')

   menc = uimenu('label','Tidsfkn ');
    if t_type	% z-transform
           uimenu(menc,'label','Rita inverstransformen', ...
              'callback','pzmenu(''Sigplot'');')
    else     % Laplacetransform
           uimenu(menc,'label','Rita inverstransformen (Krav: Fler poler än nollställen)', ...
              'callback','pzmenu(''Sigplot'');')
    end

%       uimenu('label','           ');



% Definition of axes for pz, magnitude, and phase:

if t_type==0, % laplace
	pz_hand=axes('position',[.1 .15 .42 .8]);
	axis('normal');
	grid;
	adjust=0;
else         % z-transform
	pz_hand=axes('position',[.1 .15 .42 .8]);
	axis('square');
	grid;
	adjust=.04;
end

set(THEFIG,'WindowButtonDownFcn','pzaction');

m_hand=axes('position',[.62 .6  .32 .32]);
grid
p_hand=axes('position',[.62 .15 .32 .32]);
grid


% Definition of the EDIT uicontrols for the axis settings:

width=0.03;
length=0.04;
s_min=uicontrol('Style','edit','Units','normalized','Position',[0.08 .08+adjust length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''P&Z'',''Scale'')', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
s_max=uicontrol('Style','edit','Units','normalized','Position',[.5 .08+adjust length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''P&Z'',''Scale'')', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
o_min=uicontrol('Style','edit','Units','normalized','Position',[.03 .14+adjust length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''P&Z'',''Scale'')', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
o_max=uicontrol('Style','edit','Units','normalized','Position',[.03 .93-adjust length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''P&Z'',''Scale'')', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
f_min=uicontrol('Style','edit','Units','normalized','Position',[0.6 .08 length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''Spe'',''Scale'',1)', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
f_max=uicontrol('Style','edit','Units','normalized','Position',[0.92 .08 length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''Spe'',''Scale'',1)', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
m_min=uicontrol('Style','edit','Units','normalized','Position',[0.55 .59 length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''Spe'',''Scale'',0)', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
m_max=uicontrol('Style','edit','Units','normalized','Position',[0.55 .9 length width],...
      'fontsize',12,'String','0','CallBack','pzspplot(''Spe'',''Scale'',0)', ...
      'foreground','black','background',0.7*[1 1 1],'horizontal','left');
	

%Text for presenting the present pole/zero:

TEXT1=uicontrol('style','text','units','normalized','position',[.2 .025 .12 .03], ...
                'fontsize',12,'string','Aktuell pol/nollställe:','horizontal','left', ...
                'foreground','red','background',get(gcf,'color'));
text_re=uicontrol('style','text','units','normalized','position',[.32 .04 .062 .03], ...
                  'fontsize',12,'string','Realdel:','horizontal','left', ...
                  'foreground','red','background',get(gcf,'color'));
text_im=uicontrol('style','text','units','normalized','position',[.32 .01 .062 .03], ...
                  'fontsize',12,'string','Imaginärdel:','horizontal','left', ...
                  'foreground','red','background',get(gcf,'color'));


% Presentation of the present pole/zero position:

pres_x=uicontrol('Style','edit','Units','normalized','Position',[0.39 .04 2*length width],...
        'fontsize',12,'String','','CallBack','pzmenu(''Move'',''xy'')', ...
      'foreground','black','background',0.7*[1 1 1],'UserData',inf,'horizontal','left');
pres_y=uicontrol('Style','edit','Units','normalized','Position',[0.39 .01 2*length width],...
        'fontsize',12,'String','','CallBack','pzmenu(''Move'',''xy'')', ...
      'foreground','black','background',0.7*[1 1 1],'UserData',inf,'horizontal','left');

% The K constant (tillägg augusti 2004):

% Tidigare positioner för 4x3-fönster (ändrat till 16x9-fönster nov 2020): 
% [.15 .957-t_type*.1 .02 .03] för Kstring och [0.18 .96-t_type*.1 2*length width]för Kvalue

Kstring=uicontrol('style','text','units','normalized','position',[.15 .957-t_type*0 .02 .03], ...
                'fontsize',12,'string','K = ','horizontal','left', ...
                'foreground','black','background',get(gcf,'color'));
Kvalue=uicontrol('Style','edit','Units','normalized','Position',[0.18 .96-t_type*0 1.4*length width],...
        'fontsize',12,'String','','CallBack','pzmenu(''NewK'')', ...
      'foreground','black','background',0.7*[1 1 1],'UserData',inf,'horizontal','left');


%The window 'UserData' will contain the sufficient data needed:

pres_pmode=inf;		% present pointer mode
prev_pmode=inf;		% present pointer mode
xp=inf; 		% previous x-coordinate
yp=inf; 		% previous y-coordinate
x=inf;  			% present x-coordinate   (OBS: Används inte här!?  Anm. dec 2014)
y=inf;  			% present y-coordinate   (OBS: Används inte här!?  Anm. dec 2014)
pointermode=1; 		% 0 => zero mode,  1 => pole mode
magn_type=1;		% magnitude axis set to linear

% Följande textobjekt EXTRA används bara för dess userdata-attributs skull:
% Där lagras[pointermode magn_type t_type pres_pmode prev_pmode xp yp]
% eftersom Matlab fr.o.m. R2014 inte kan blanda handtag med andra variabler (dessa)
% NEJ!!!  Använd i stället den globala variabeln EXTRAdata => enklare!

% EXTRA=uicontrol('style','text','units','normalized','position',[.01 .01 .01 .01], ...
%                 'string','XXXX','userdata', ...
%                  [pointermode magn_type t_type pres_pmode prev_pmode xp yp]);

EXTRAdata = [pointermode magn_type t_type pres_pmode prev_pmode xp yp];

% EXTRA=text(100,100,' ','visible','off','userdata', ...
%    [pointermode magn_type t_type pres_pmode prev_pmode xp yp]);

% pointermode    (1)   f.d. (16) Indicates zero (0) or pole (1) mode
% magn_type      (2)   f.d. (17) Indicates type of magnitude plot  1:linear   2:full dB   3: -5 to +5 dB
% t_type         (3)   f.d. (18) Indicates the transform type: 0 => laplace, 1 => z
% pres_pmode     (4)   f.d. (19) Indicates if present is a pole (1) or zero (0)
% prev_pmode     (5)   f.d. (20) Indicates if previous is a pole (1) or zero (0)
% xp             (6)   f.d. (21) The real part of the previous pole/zero
% yp             (7)   f.d. (22) The imaginary part of the previous pole/zero


userdata = [ ...
pz_hand m_hand p_hand ...   % (1-3) Handles to pz, magn, and phase axes.
s_min s_max o_min o_max ... % (4-7) Handles to 
f_min f_max ...             % (8-9) current axis 
m_min m_max ...             % (10-11) settings.
text_re text_im ...         % (12-13) Handles to text 'Realdel:'/'Imaginärdel:' or 'Avstånd:'/'Vinkel:'
pres_x pres_y ...           % (14-15) Handles to present position (x,y)
Kvalue ];                   % (16) OBS Tidigare (23): Handle to the level constant K
        
% TIDIGARE, t.o.m. nov. 2014, så var userdata-variabeln följande i pos 16-23:
% ---------------------------------------------------------------------------
% pointermode ...   % (16) Indicates zero (0) or pole (1) mode
% magn_type ...     % (17) Indicates type of magnitude plot  1:linear   2:full dB   3: -5 to +5 dB
% t_type ... 		% (18) Indicates the transform type: 0 => laplace, 1 => z
% pres_pmode ...	% (19) Indicates if present is a pole (1) or zero (0)
% prev_pmode ...	% (20) Indicates if previous is a pole (1) or zero (0)
% xp ...     		% (21) The real part of the previous pole/zero
% yp ...    		% (22) The imaginary part of the previous pole/zero
% Kvalue ];         % (23) Handle to the level constant K


set(THEFIG,'UserData',userdata);
pzspplot('PZS','Fulpl');	    % Full plot of the Poles and Zeros and of spectrum

set(THEFIG,'pointer','crosshair');  % Pole mode

