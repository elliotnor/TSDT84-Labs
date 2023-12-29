function pzchange(H);
% PZCHANGE Grafiskt verktyg verktyg f�r skapande av transformer
%     PZCHANGE      - motsvarar pzchange('s')
%     PZCHANGE(H)   - pzchange startas med laplace- eller z-transformen H
%     PZCHANGE('s') eller PZCHANGE S - pzchange startas med laplacetransformen H(s)=1
%     PZCHANGE('z') eller PZCHANGE Z - pzchange startas med z-transformen H[z]=1
%     PZCHANGE('p') eller PZCHANGE P - PZCHANGE startas med den i pzchange senast anv�nda transformen 
%                       (= den globala variabeln TRFM - l�s mer om den nedan)
%    
%     Med PZCHANGE kan man skapa och/eller modifiera en laplace- eller z-transform
%     genom att placera ut poler och nollst�llen med hj�lp av musen.
%     Transformens pol-nollst�llediagram samt motsvarande amplitudkarakt�ristik (-spektrum)
%     och faskarakt�ristik (-spektrum) visas i samma figurf�nster.
%     Det finns flera  utritningsvarianter, som t.ex. linj�r skala och dB-skala, 
%     och man kan sj�lv �ndra gr�nserna f�r frekvensomr�det. 
%     I pol-nollst�llediagrammet ritas poler som 'X' och nollst�llen 
%     som 'O'. Den aktuella polen/nollst�llet �r alltid r�df�rgad.
%    
%     En aktuell pol/nollst�lle kan p�verkas p� olika s�tt - exempelvis flytta den 
%     till valfri position m.h.a. musen, flytta till reella axeln, imagin�ra axeln 
%     eller enhetscirkeln (det sistn�mnda g�ller endast z-transformer), tag bort den
%     eller �ndra multiplicitet. Den aktuella polen/nollst�llet visas (i rektangul�r 
%     eller pol�r form) under pol-nollst�llediagrammet. Polens/nollst�llets position 
%     kan �ven �ndras direkt i dessa redigerbara f�lt.
%     Man kan d� �ven skriva in en position som t.ex. 'sqrt(2)'.
%     De flesta h�ndelser kan v�ljas fr�n n�gon l�mplig meny.
%    
%     Musknappar:
%            V�nster: L�gg till pol/nollst�lle i muspekarens position
%            Mitten:  Toggla mellan pol- och nollst�lle'mode'
%            H�ger:   V�lj, som aktuell pol eller nollst�lle, den pol/nollst�lle som 
%                     �r n�rmast muspekarens position
%    
%     Om du har en mus med f�rre �n tre knappar, s� kan du f� fram tre knappar p� sk�rmen
%     som har motsvarande musknappsfunktioner.
%     G�r l�mpligt val under menyn 'Information'.
%    
%     V�lj 'Quit' i menyn f�r att avsluta pzchange. Den aktuella laplace- eller z-transformen 
%     erh�lls d� i 'workspace' som den globala variabeln TRFM.
%     (Notera att n�r pzchange anv�nds kan man alltid f� tillg�ng till aktuell
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
global EXTRAdata % Anv�nds f�r att hantera pol- och nollst�llepositioner, 
                 % aktuell t pol/nollst�llemode m.m. Totalt 7 parametrar


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

THEFIG=figure('Position',[20 100 1600 900],'Name','PZCHANGE'); %Aktuell f�nsterstorlek 16x19
%THEFIG=figure('Position',[20 100 1100 650],'Name','PZCHANGE');
%THEFIG=figure('Position',[10 40 1000 768],'Name','PZCHANGE');  % Gammal figurf�nsterstorlek

%Menu settings:

men1 = uimenu('label','Info ');
       uimenu(men1,'label','Musknappar:');
       uimenu(men1,'label','      V�nster - L�gg till pol/nollst�lle vid mark�rpositionen (pekartypen anger om det �r pol eller nollst�lle som l�ggs till)');
       uimenu(men1,'label','      Mitten - Toggla mellan pol-l�ge och nollst�lle-l�ge');
       uimenu(men1,'label','      H�ger - V�lj/aktivera polen/nollst�llet n�rmast mark�ren');
       uimenu(men1,'label','Pekartyp:');
       uimenu(men1,'label','        "+" => pol-l�ge (l�gg till och manipulera poler)');
       uimenu(men1,'label','        "O" => nollst�lle-l�ge (l�gg till och manipulera nollst�llen)');
       uimenu(men1,'label','           ');
    
       uimenu(men1,'label','Om du inte har en mus med tre knappar eller bara kan anv�nda en musknapp, s� kan i st�llet tre motsvarande "knappar"') ;
       uimenu(men1,'label','visas till v�nster om pol-nollst�llediagrammet, som motsvarar musknapparna: KLICKA D� H�R!','callback','pzmenu(''Mouse'')');

% sub1 = uimenu(men1,'label',['Om du inte har en mus med tre knappar =>  Visa tre "knappar"        ' ; ...
%                            'till v�nster om pol-nollst�llediagrammet, som motsvarar musknapparna'], ...
%                            'callback','pzmenu(''Mouse'')');

% F�ljande menyval �r knappast aktuellt l�ngre ? borttagen nov 2020
% uimenu(sub1,'label','Visa tre "knappar" till v�nster om pol-nollst�llediagrammet, som motsvarar musknapparna', ...
%              'callback','pzmenu(''Mouse'')');
%       sub2 = uimenu(men1,'label','Om du har en monokrom sk�rm =>');
%       uimenu(sub2,'label','Rita vitt i st�llet f�r r�tt','callback','pzmenu(''B&W'')');

menq = uimenu('label','Avsluta ');
       uimenu(menq,'label','Avsluta pzchange. Transformen finns i den globala variabeln TRFM.', ...
	      'callback','pzquit');

men2 = uimenu('label','Ta bort ','Interruptible','on');
       uimenu(men2,'label','Tag bort aktuell pol/nollst�lle', ...
              'callback','pzmenu(''D'',''pres'')');
       uimenu(men2,'label','Tag bort alla poler eller nollst�llen (beroende p� pol/nollst�llel�ge) inom en rektangel, som du markerar','Interruptible','on', ...
	      'Callback','pzmenu(''D'',''box'')');
       uimenu(men2,'label','Tag bort alla poler och nollst�llen', ...
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
       uimenu(men5,'label','Flytta till imagin�ra axeln', ...
              'callback','pzmenu(''Move'',''im'')');
if t_type	% z-transform
       uimenu(men5,'label','Flytta till enhetscirkeln', ...
              'callback','pzmenu(''Move'',''unit'')');
end
men6 = uimenu('label','Koordinater ');
       uimenu(men6,'label','Rektangul�ra koordinater','callback','pzmenu(''C'',''rect'')');
       uimenu(men6,'label','Pol�ra koordinater','callback','pzmenu(''C'',''polar'')');
men7 = uimenu('label','Axelgradering ');
       uimenu(men7,'label','Automatisk axelgradering av pol-nollst�llediagrammet','callback','pzspplot(''P&Z'',''Fulpl'')');
       uimenu(men7,'label','Automatisk axelgradering av amplitud-och fasgraferna','callback','pzspplot(''Spe'',''Fulpl'')');
%       F�ljande �r BORTTAGEN 2020-11-12, beh�vs inte l�ngre, eftersom man kan zooma sj�lv i graferna sedan ett tag!! 
%       uimenu(men7,'label','Zoom PZ plot','callback','pzmenu(''Z'')')
men8 = uimenu('label','Amplitudgrafen ');
       uimenu(men8,'label','Linj�r amplitudskala','callback','pzmenu(''Magn'',1)');
       uimenu(men8,'label','Decibelskala: -100 to +20 dB', ...
              'callback','pzmenu(''Magn'',2)');
       uimenu(men8,'label','Decibelskala: -5 to +5 dB ','callback','pzmenu(''Magn'',3)');
men9 = uimenu('label','Normera ');
       NORMMODE1=0; NORMMODE2=men9;
%       uimenu(men9,'label','Normalize mode is OFF (click to toggle!)', ...
       uimenu(men9,'label','Amplitudnormering AV (klicka f�r att toggla!)', ...
              'callback','pzmenu(''N'',1)');
men0 = uimenu('label','Poler/Nollst. ');
%       uimenu(men0,'label','Skriv ut figuren','callback','print');  & On�dig - borttagen 20201112
       uimenu(men0,'label','Skriv polernas och nollst�llenas positioner i kommandof�nstret', ...
              'callback','pzmenu(''PoZeplot'')');
mena = uimenu('label','3D-plot ');
       uimenu(mena,'label','Rita en 3D-graf av transformen', ...
              'callback','pzmenu(''3Dplot'');')

   menb = uimenu('label','Pol-nollst.vektorer ');
       uimenu(menb,'label','Rita pol-nollst�llevektorer och motsvarande v�rden i amplitud- och fasgraferna', ...
              'callback','global THEFIG, set(THEFIG,''WindowButtonDownFcn'',''''); pzmenu(''SpectVect'');')
       uimenu(menb,'label','Tag bort pol-nollst�llevektorerna', ...
              'callback','global WSLIDER REGTIT, if ~isempty(WSLIDER), delete(WSLIDER),pzspplot(''P&Z'',''PZmen''),pzspplot(''Spe'',''Scale'',1),set(THEFIG,''WindowButtonDownFcn'',''pzaction''), delete(REGTIT), end')

   menc = uimenu('label','Tidsfkn ');
    if t_type	% z-transform
           uimenu(menc,'label','Rita inverstransformen', ...
              'callback','pzmenu(''Sigplot'');')
    else     % Laplacetransform
           uimenu(menc,'label','Rita inverstransformen (Krav: Fler poler �n nollst�llen)', ...
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
                'fontsize',12,'string','Aktuell pol/nollst�lle:','horizontal','left', ...
                'foreground','red','background',get(gcf,'color'));
text_re=uicontrol('style','text','units','normalized','position',[.32 .04 .062 .03], ...
                  'fontsize',12,'string','Realdel:','horizontal','left', ...
                  'foreground','red','background',get(gcf,'color'));
text_im=uicontrol('style','text','units','normalized','position',[.32 .01 .062 .03], ...
                  'fontsize',12,'string','Imagin�rdel:','horizontal','left', ...
                  'foreground','red','background',get(gcf,'color'));


% Presentation of the present pole/zero position:

pres_x=uicontrol('Style','edit','Units','normalized','Position',[0.39 .04 2*length width],...
        'fontsize',12,'String','','CallBack','pzmenu(''Move'',''xy'')', ...
      'foreground','black','background',0.7*[1 1 1],'UserData',inf,'horizontal','left');
pres_y=uicontrol('Style','edit','Units','normalized','Position',[0.39 .01 2*length width],...
        'fontsize',12,'String','','CallBack','pzmenu(''Move'',''xy'')', ...
      'foreground','black','background',0.7*[1 1 1],'UserData',inf,'horizontal','left');

% The K constant (till�gg augusti 2004):

% Tidigare positioner f�r 4x3-f�nster (�ndrat till 16x9-f�nster nov 2020): 
% [.15 .957-t_type*.1 .02 .03] f�r Kstring och [0.18 .96-t_type*.1 2*length width]f�r Kvalue

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
x=inf;  			% present x-coordinate   (OBS: Anv�nds inte h�r!?  Anm. dec 2014)
y=inf;  			% present y-coordinate   (OBS: Anv�nds inte h�r!?  Anm. dec 2014)
pointermode=1; 		% 0 => zero mode,  1 => pole mode
magn_type=1;		% magnitude axis set to linear

% F�ljande textobjekt EXTRA anv�nds bara f�r dess userdata-attributs skull:
% D�r lagras[pointermode magn_type t_type pres_pmode prev_pmode xp yp]
% eftersom Matlab fr.o.m. R2014 inte kan blanda handtag med andra variabler (dessa)
% NEJ!!!  Anv�nd i st�llet den globala variabeln EXTRAdata => enklare!

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
text_re text_im ...         % (12-13) Handles to text 'Realdel:'/'Imagin�rdel:' or 'Avst�nd:'/'Vinkel:'
pres_x pres_y ...           % (14-15) Handles to present position (x,y)
Kvalue ];                   % (16) OBS Tidigare (23): Handle to the level constant K
        
% TIDIGARE, t.o.m. nov. 2014, s� var userdata-variabeln f�ljande i pos 16-23:
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

