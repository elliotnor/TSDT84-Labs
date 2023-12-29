function pzmenu(choice,alt,menuobj)
%pzmenu
% pzmenu anropas vid olika menyval i pzchange

% (c) Lasse Alfredsson  1994-2015


global TRFM THEFIG MENUFLG REDX REDO TEXT1 NORMMODE1 NORMMODE2 MOUSEMODE KlabL EXTRAdata

MENUFLG=1;
currpoint=get(THEFIG,'pointer');
% set(THEFIG,'pointer','watch')  % Bortkommenterad 201124 - behövs inte
                                 % längre, det går tillräckligt snabbt att beräklna ändå
userdata=get(THEFIG,'UserData');
% Tillägg dec 2014:
% EXTRAdata = get(userdata(16),'UserData'); % = userdata-vektorn i EXTRA (se pzchange)
% pointermode=EXTRAdata(1);
% magn_type=EXTRAdata(2);
% t_type=EXTRAdata(3);
% pres_pmode=EXTRAdata(4);
% prev_pmode=EXTRAdata(5);
% xp=EXTRAdata(6);
% yp=EXTRAdata(7);

presx=get(userdata(14),'UserData');
presy=get(userdata(15),'UserData');

if strcmp('Check',choice)		% Correct present if a pole/zero has been
					% placed over a zero/pole.
   presz=presx+j*presy;
   if     EXTRAdata(4)==1 & sum(abs(presz-TRFM(1,4:3+TRFM(1,2)))<1e-4)>0, 
				% i.e. if pres_pmode is pole while the
				% present type is actually a zero
	EXTRAdata(4)=0;
%    set(userdata(16),'UserData',EXTRAdata);
    set(THEFIG,'UserData',userdata);	% Update 'UserData'
	pzspplot('P&Z','PZmen',-1);		% Replot
   elseif EXTRAdata(4)==0 & sum(abs(presz-TRFM(2,4:3+TRFM(2,2)))<1e-4)>0, 
				% i.e. if pres_pmode is zero while the
				% present type is actually a pole
	EXTRAdata(4)=1;
%    set(userdata(16),'UserData',EXTRAdata);
    set(THEFIG,'UserData',userdata);	% Update 'UserData'
	pzspplot('P&Z','PZmen',-1);		% Replot
   end


elseif  strcmp('D',choice)		% Delete
 if strcmp('pres',alt)			% Delete present pole/zero
   if length(presx)>0	                % => Present pole/zero exists
	presz=presx+j*presy;
	if EXTRAdata(4)			% Present is a pole
	   pole=TRFM(2,4:3+TRFM(2,2));  % The poles of TRFM
	   numpz=find(abs(pole-presz)<1e-4 & sign(imag(presz))==sign(imag(pole)));
	   TRFM=addze(TRFM,presz*ones(size(numpz)));		% addze => rempo
	else				% Present is a zero
	   zero=TRFM(1,4:3+TRFM(1,2));  % The zeros of TRFM
	   numpz=find(abs(zero-presz)<1e-4 & sign(imag(presz))==sign(imag(zero)));
	   TRFM=addpo(TRFM,presz*ones(size(numpz)));		% addpo => remze
	end
	if EXTRAdata(6)~=inf		% Previous exists
	   EXTRAdata(4)=EXTRAdata(5);	% Present pz type = previous type
	   
	   EXTRAdata(5)=inf;		% => Previous does not exist
	   set(userdata(14),'UserData',EXTRAdata(6)); 		% Update the present
	   set(userdata(15),'UserData',EXTRAdata(7));		% (rect.) position
	   if strcmp('Realdel:',get(userdata(12),'string')) 	% Rectangular coord
	      set(userdata(14),'string',num2str(EXTRAdata(6))); % Update the present
	      set(userdata(15),'string',num2str(EXTRAdata(7)));	% (rect.) position
	   else
	      z=EXTRAdata(6)+j*EXTRAdata(7);
  	      set(userdata(14),'string',num2str(abs(z)));	% Update the present
	      set(userdata(15),'string',num2str(angle(z))); 	% (polar) position
	   end
	   EXTRAdata(6)=inf;			% Set previous position
	   EXTRAdata(7)=inf;			% nonexistent
	else					% Previous does NOT exist
	   EXTRAdata(4)=inf;			% => Present pz type nonexistent
	   set(userdata(14),'UserData',inf); 	% => The present position
	   set(userdata(15),'UserData',inf);	% has no coordinate
	   set(userdata(14),'string',''); 	% Set the present
	   set(userdata(15),'string','');	% position empty
    end
%    set(userdata(16),'UserData',EXTRAdata);
    set(THEFIG,'UserData',userdata);	% Update 'UserData'
	pzmenu('N')				            % Normalize, if needed
	pzspplot('PZS','PZmen',-1);		% Rewrite pz plot and spectrum plot
						            % The -1 is a dummy
   end

 elseif strcmp('box',alt)			% Delete within a box
   axes(userdata(1));
   set(THEFIG,'pointer',currpoint,'interruptible','on','windowbuttondownfcn','', ...
	      'windowbuttonupfcn','1;','windowbuttonmotionfcn','')
   set(gca,'interruptible','on')
   tchoose=uicontrol('style','text','units','normalized', ...
	             'position',[.17 .92 .27 .075],'string',sprintf(['    Klicka och dra för att markera en rektangel i pol-nollställediagrammet! '...
                 'Alla poler/nollställen (beroende på aktuellt läge) inom rektangeln, samt deras komplexkonjugerade motsvarighet, raderas. ' ...
                 'Ev. ritas tyvärr inte själva rektangeln i Matlab R2020...']), ...
 	    	     'horizontal','center','foreground','black','background','cyan', ...
		         'interruptible','on', 'fontsize',12);
   waitforbuttonpress;
   pos1=get(userdata(1),'CurrentPoint');	% Position 1 within axes
   winpos=get(gcf,'currentpoint');		% Position within window 
   %rbbox([winpos 0 0],winpos);
   TESTAR=rbbox;
   % set(THEFIG,'pointer','watch');
   delete(tchoose);
   pos2=get(userdata(1),'CurrentPoint');	% Position 2 within axes
   % TESTAR, pos1, pos2   %     TESTAR HÄR NOV 2020 VARFÖR RUBBERBAND INTE FUNKAR I R2020!
   set(THEFIG,'windowbuttondownfcn','pzaction');
   set(gca,'interruptible','off')
   set(THEFIG,'interruptible','off')
   x1=pos1(1,1);
   y1=pos1(1,2);
   x2=pos2(1,1);
   y2=pos2(1,2);
   if x1>x2, t=x1; x1=x2; x2=t; end		% We want x1<x2
   if y1<y2, t=y1; y1=y2; y2=t; end		% We want y1>y2
   if y1>0 & y2<0				% Then don't include both the pole/zero
						% and its complex conjugate, if in the box
	if abs(y2)<y1, 	y2=-1e-4;
	else 		y1=1e-4;
	end
   end
   if EXTRAdata(1)				% Pole mode
	poles=TRFM(2,4:3+TRFM(2,2));		% The poles
	P_Z=poles(find(poles>x1 & poles<x2 & imag(poles)>y2 & imag(poles)<y1));
	TRFM=addze(TRFM,P_Z);			% addze => rempo
   else
	zeros=TRFM(1,4:3+TRFM(1,2));		% The zeros
	P_Z=zeros(find(zeros>x1 & zeros<x2 & imag(zeros)>y2 & imag(zeros)<y1));
	TRFM=addpo(TRFM,P_Z);			% addpo => remze
   end

   prevpz=abs([P_Z+j*EXTRAdata(7) P_Z-j*EXTRAdata(7)]-EXTRAdata(6));
   if any(prevpz<1e-4)				% Previous pole/zero was deleted
	EXTRAdata(6)=inf;			% Set previous
	EXTRAdata(7)=inf;			% nonexistent
        EXTRAdata(5)=inf;
   end
   prespz=abs([P_Z+j*presy P_Z-j*presy]-presx);
   if any(prespz<1e-4)				% Present pole/zero was deleted
	if EXTRAdata(6)~=inf			% Previous exists
	   EXTRAdata(4)=EXTRAdata(5);		% Present pz type = previous type
	   EXTRAdata(5)=inf;			% Set previous nonexistent
	   set(userdata(14),'UserData',EXTRAdata(6)); 		% Update the present
	   set(userdata(15),'UserData',EXTRAdata(7));		% (rect.) position
	   if strcmp('Realdel:',get(userdata(12),'string')) 	% Rectangular coord
	      set(userdata(14),'string',num2str(EXTRAdata(6))); % Update the present
	      set(userdata(15),'string',num2str(EXTRAdata(7)));	% (rect.) position
	   else
	      z=EXTRAdata(6)+j*EXTRAdata(7);
  	      set(userdata(14),'string',num2str(abs(z)));	% Update the present
	      set(userdata(15),'string',num2str(angle(z))); 	% (polar) position
	   end
	   EXTRAdata(6)=inf;			% Set previous position
	   EXTRAdata(7)=inf;			% nonexistent
	else					% Previous does NOT exist
	   EXTRAdata(4)=inf;			% => Present pz type nonexistent
	   set(userdata(14),'UserData',inf); 	% => The present position
	   set(userdata(15),'UserData',inf);	% has no coordinate
	   set(userdata(14),'string',''); 	% Set the present
	   set(userdata(15),'string','');	% position empty
	end
   end
%   set(userdata(16),'UserData',EXTRAdata);
   set(THEFIG,'UserData',userdata);		% Update 'UserData'
   pzmenu('N')					% Normalize, if needed
   pzspplot('PZS','PZmen',-1);			% Rewrite pz plot and spectrum plot
						% The -1 is a dummy

 elseif strcmp('all',alt)			% Delete all
   TRFM=[TRFM(1,1) 0 1;0 0 1];
   % Tillägg 2014, nästa rad, samt redigerad nästnästa rad
   EXTRAdata = [strcmp('crosshair',currpoint) 1 EXTRAdata(3) inf*ones(1,4)];
%   set(userdata(16),'UserData',[strcmp('crosshair',currpoint) 1 EXTRAdata(3) inf*ones(1,4)]);
   % Denna tidigare rad behövs inte 2014, ty konsekvens: userdata=[userdata(1:15) userdata(16) userdata(17)];
   set(userdata(14),'string','');
   set(userdata(15),'string','');
   set(userdata(14),'UserData',inf);
   set(userdata(15),'UserData',inf);
%   set(userdata(16),'UserData',EXTRAdata);
   set(THEFIG,'UserData',userdata);	% Update 'UserData'
   pzspplot('PZS','Fulpl');
 end

elseif strcmp('M',choice)		% Multiplicity
  if length(presx)>0			% Present exists
    presz=presx+j*presy;
    if EXTRAdata(4)			% Present is a pole
    	poorze=TRFM(2,4:3+TRFM(2,2));	% The poles
    else
    	poorze=TRFM(1,4:3+TRFM(1,2));
    end
    currm=sum(abs(poorze-presz)<1e-4 & sign(imag(poorze))==sign(imag(presz)));	
					% Current multiplicity of present pz
    eval(['newm=' alt ';']);
    
    numbpz=abs(newm-currm);
    if newm<currm,					% => remove pz
	if EXTRAdata(4)
	   TRFM=addze(TRFM,presz*ones(1,numbpz));	% rempo = addze
	else
	   TRFM=addpo(TRFM,presz*ones(1,numbpz));	% remze = addpo
	end
    elseif newm>currm					% => add pz
	if EXTRAdata(4)
	   TRFM=addpo(TRFM,presz*ones(1,numbpz));
	else
	   TRFM=addze(TRFM,presz*ones(1,numbpz));
	end
    end
    
    if newm==0,				% The pz is deleted
	if EXTRAdata(4)
	   TRFM=addpo(TRFM,presz);	% No pole exists. Add one pole again
	else
	   TRFM=addze(TRFM,presz);	% No pole exists. Add one pole again
	end
	pzmenu('D','pres');		% Delete the pole again
    else
	pzmenu('N')			% Normalize, if needed
	pzspplot('PZS','PZmen',-1);	% Rewrite pz plot and spectrum plot
    end
  end



elseif strcmp('Move',choice)		% Move
  if length(presx)>0			% Present exists
    flag=1;
if strcmp('xy',alt)		% Change edit pres_x or pres_y
    x=str2num(get(userdata(14),'string'));
    y=str2num(get(userdata(15),'string'));
    if ~strcmp('Realdel:',get(userdata(12),'string'))
      dist=x;
      x=1e-5*round(1e5*dist*cos(y));
      y=1e-5*round(1e5*dist*sin(y));
    end
    axes(userdata(1));
    currax=axis;
    if x<currax(1) | x>currax(2) | y<currax(3) | y>currax(4)
      tchoose=uicontrol('style','text','position',[.19 .96 .25 .03],'units', ...
   	      'normalized','string','New coordinate must be within axes !!', ...
	      'horizontal','center','foreground','black','background','cyan');
      pause(1)
      set(tchoose,'visible','off')
      pause(.2)
      set(tchoose,'visible','on')
      pause(1)
      delete(tchoose)
      flag=0;
    end
end
if flag			
    presz=presx+j*presy;
    if EXTRAdata(4)			% Present is a pole
    	poorze=TRFM(2,4:3+TRFM(2,2));	% The poles
    else				% Present is a zero
    	poorze=TRFM(1,4:3+TRFM(1,2));   % The zeros
    end
    currm=sum(abs(poorze-presz)<1e-4 & sign(imag(poorze))==sign(imag(presz)));	
					% Current multiplicity of present pz
    prespzvect=presz*ones(1,currm);	% Vector of present poles/zeros
    if EXTRAdata(4)
	TRFM=addze(TRFM,prespzvect);	% Remove all present poles: addze = rempo
    else
	TRFM=addpo(TRFM,prespzvect);	% Remove all present zeros: addpo = remze
    end

    if strcmp('re',alt)			% Real axis
	newpz=real(prespzvect);	
    elseif strcmp('im',alt)		% Imaginary axis
	newpz=j*imag(prespzvect);
    elseif strcmp('unit',alt)		% Unit circle (for z-transforms)
	newpz=prespzvect./abs(prespzvect);
    elseif strcmp('z',alt)		% Choose using pointer
	axes(userdata(1))
    tchoose=uicontrol('style','text','units','normalized','position',[.35 .95 .30 .05], ...
		'fontsize',12,'string',['Markera en ny position med musen!                                     ' ; 'Vänster musknapp => flytta och sluta.   Höger musknapp => Flytta igen!'], ...
    'horizontal','center','foreground','black','background','cyan');
	set(THEFIG,'pointer',currpoint)
	currax=axis;

%	tempstr=get(THEFIG,'WindowButtonDownFcn');
	set(THEFIG,'WindowButtonDownFcn','');
%	waitforbuttonpress;
    [x,y,musknapp]=ginput(1);       % NY
%	pos=get(userdata(1),'CurrentPoint');
%	x=pos(1,1);
%	y=pos(1,2);
	while x<currax(1) | x>currax(2) | y<currax(3) | y>currax(4)
		set(tchoose,'string','Ny position måste vara inom koordinataxlarnas gränser!');
        [x,y,musknapp]=ginput(1);       % NY
%		waitforbuttonpress;
%		pos=get(userdata(1),'CurrentPoint');
%		x=pos(1,1);
%		y=pos(1,2);
    end

    %	set(userdata(1),'ButtonDownFcn',tempstr);
 	% set(THEFIG,'pointer','watch'); %Behövs inte längre ändra pekaren till klocka - det går snabbt ändå!
	newpz=(x+j*y)*ones(1,currm);
    elseif strcmp('xy',alt)
	newpz=(x+j*y)*ones(1,currm);
    end
    if EXTRAdata(4)
	TRFM=addpo(TRFM,newpz);		% Add the new (moved) poles
    else
	TRFM=addze(TRFM,newpz);		% Add the new (moved) zeros
    end
    set(userdata(14),'UserData',real(newpz(1)));		% Update present
    set(userdata(15),'UserData',imag(newpz(1)));		% position
if ~strcmp('xy',alt)	% => Don't change for example 'sqrt(2)' to '1.4142'
    if strcmp('Realdel:',get(userdata(12),'string'))
	set(userdata(14),'string',num2str(real(newpz(1))));	% Update present
	set(userdata(15),'string',num2str(imag(newpz(1))));	% position
    else
	set(userdata(14),'string',num2str(abs(newpz(1))));	% Update present
	set(userdata(15),'string',num2str(angle(newpz(1))));	% position
    end
end

%    set(userdata(16),'UserData',EXTRAdata);
    set(THEFIG,'UserData',userdata)	% Update
    typetest=EXTRAdata(4);
    pzmenu('Check')			% Check if present pole/zero has become a
					% zero/pole
    userdata=get(THEFIG,'UserData');
    % Tillägg dec 2014:
%    EXTRAdata2 = get(userdata(16),'UserData'); % = userdata-vektorn i EXTRA (se pzchange)
    if EXTRAdata(4)==typetest,		% No change of present type has occurred
 	pzmenu('N')			% Normalize, if needed
        pzspplot('PZS','PZmen',-1);	% Rewrite pz plot and spectrum plot
    end

    set(THEFIG,'WindowButtonDownFcn','pzaction');
end
  end


elseif strcmp('C',choice)				% Coordinates
   presz=get(userdata(14),'UserData')+j*get(userdata(15),'UserData');	% Present pos.
   if strcmp('polar',alt)				% Change to polar
	set(userdata(12),'string','Avstånd:');
	set(userdata(13),'string','Vinkel:');
	set(userdata(14),'string',num2str(abs(presz)));
	set(userdata(15),'string',num2str(angle(presz)));
   else						% (alt='rect') Change to rectangular
	set(userdata(12),'string','Realdel:');
	set(userdata(13),'string','Imaginärdel:');
	set(userdata(14),'string',num2str(real(presz)));
	set(userdata(15),'string',num2str(imag(presz)));
   end
%   set(userdata(16),'UserData',EXTRAdata);
   set(THEFIG,'UserData',userdata);	% Update 'UserData'


% OBS!!!! Menyvalet "Zoom PX Plot" är borttaget 2020-11-12
% Detta p.g.a. att man sedan ett tag har zoom-ikonerna (+) och (-)
% till höger ovfanför alla grafer. Det är bara att klicka där för att
% välja zoomläge i stället för att välja zoom-läge i menyn!

% elseif strcmp('Z',choice)				% Zoom PZ plot
%     global QQQQQ OOOOOO BBBBBB DDDDDD
%    QQQQQ=uicontrol('style','pushbutton','units','normal','pos',[.27 .96 .1 .03], ...
%  	       'backgroundcolor',[.7 .7 .7],'string','Quit zooming');
%    set(QQQQQ,'callback',['global THEFIG QQQQQ, userdata=get(THEFIG,''userdata'');' ...
% 		     'zoom off, axes(userdata(1)), currax=axis; ' ...
% 		     'set(userdata(4),''string'',num2str(currax(1))); ' ...
% 		     'set(userdata(5),''string'',num2str(currax(2))); ' ...
% 		     'set(userdata(6),''string'',num2str(currax(3))); ' ...
% 		     'set(userdata(7),''string'',num2str(currax(4))); ' ...
% 		     'set(THEFIG,''windowbuttondownfcn'',''pzaction''); ' ...
% 		     'delete(QQQQQ)']);
% %		     'delete(' num2str(Q,20) ')']);  %Funkade inte i nyare Matlab
% 
%    set(THEFIG,'windowbuttondownfcn','');
%    Istr=str2mat('  ', ...
% 	 '  Zoom pz plot - information:', ...
% 	 ' ', ...
% 	 '   You are now able to zoom in and out on the pole/zero plot.', ...
% 	 '   Click the left mouse button to zoom in on the point under the cursor.', ...
% 	 '   Click the right mouse button to zoom out (shift-click om Macintosh).', ...
% 	 '   Each time you click, the axes limits will be changed by a factor of 2 (in or out).', ...
% 	 '   You can also click and drag to zoom into an area.', ...
% 	 '  ', ...
% 	 '   Click the ''Quit zooming'' pushbutton when zooming is finished.');
% 
%    BBBBBB=uicontrol('style','edit','units','normal','position',[.295 .44 .48 .34], ...
%                'backgr','cyan');
%    DDDDDD=uicontrol('style','edit','units','normal','position',[.3 .45 .47 .32],'string',Istr, ...
%                'horizontalalignment','left','max',12);
% 	
%    OOOOOO=uicontrol('style','pushbutton','units','normal','pos',[.31 .46 .035 .035], ...
%  	       'backgroundcolor',[.7 .7 .7],'string','OK');
%    set(OOOOOO,'callback',['global OOOOOO BBBBBB OOOOOO DDDDDD, delete(BBBBBB), delete(OOOOOO), delete(DDDDDD), zoom on']);
% %   set(OOOOOO,'callback',['delete(' num2str(B,20) '), delete(' num2str(OOOOOO,20) '), delete(' num2str(D,20) '), zoom on']);


elseif strcmp('Magn',choice)		% Magnitude scaling
   EXTRAdata(2)=alt;			% Set the magnitude plot type
%   set(userdata(16),'UserData',EXTRAdata);
   set(THEFIG,'UserData',userdata)	% Update 'UserData'
   pzspplot('Spe','PZmen',-1);		% Replot spectrum. Don't change axis


elseif strcmp('N',choice)		% Normalize on/off
 if nargin==2,				% Toggle between Normalize on/off
   normen=['AV (klicka för att toggla!)' ; 'PÅ (klicka för att toggla!)'];
%   normen=['OFF (click to toggle!)' ; 'ON (click to toggle!) '];  % Senaste, t.o.m. 201112
%   normen=['(on)/OFF' ; 'ON/(off)'];
   NORMMODE1=1-NORMMODE1;
   set(get(NORMMODE2,'Children'),'Label',['Amplitudnormering ' normen(NORMMODE1+1,:)]);
%  set(get(NORMMODE2,'Children'),'Label',['Normalize mode is ' normen(NORMMODE1+1,:)]);
 end

 if NORMMODE1,			% Normalize mode
   N=TRFM(1,3)*poly(TRFM(1,4:3+TRFM(1,2)));
   D=TRFM(2,3)*poly(TRFM(2,4:3+TRFM(2,2)));
   if TRFM(1,1)==6			% Laplace transform
%    	r=max([imag(po(TRFM)) 1]);
   	r=max([abs(po(TRFM)) 1]);
  	w=j*100*r*(0:0.00005:1);
  	H=polyval(N,w)./polyval(D,w);
  	maxdata=max(abs(H));
   else 				% z-transform
  	w=1/512*(0:256);   
  	H=polyval(N,exp(j*2*pi*w))./polyval(D,exp(j*2*pi*w));
  	maxdata=max(abs(H));
   end
   TRFM=ampl(TRFM,1/maxdata);		% Scale amplitude
   pzspplot('PZS','PZmen',-1);		% Replot spectrum. Don't change axis
 end

elseif strcmp('3Dplot',choice)		% splane or zplane
   figure('name','3D-plot, transformens absolutbelopp. Denna graf uppdateras inte om du ändrar i pzchange!');
   if EXTRAdata(3)			% if z-transform
	zplane(TRFM);			% 3D plot of TRFM
   else
  	splane(TRFM);
   end


elseif strcmp('B&W',choice)		% Monochrome screen: plot everything as white
   REDX='xw';
   REDO='ow';
   set(userdata(12),'foreground','white');
   set(userdata(13),'foreground','white');
   set(TEXT1,'foreground','white');
   pzspplot('P&Z','PZmen',-1);

elseif strcmp('PoZeplot',choice)	% Type out the poles and zeros of TRFM
   disp('Nollställenas lägen:')
   disp(TRFM(1,4:3+TRFM(1,2))')
   disp('Polernas lägen:')
   disp(TRFM(2,4:3+TRFM(2,2))');

elseif strcmp('Mouse',choice)		% Emulate mouse buttons
   ap=uicontrol('style','pushbutton','units','normal','pos',[.01 .65 .05 .04], ...
 	   	'backgroundcolor','yellow','string','Addera', 'fontsize',12,...
		'callback','global MOUSEMODE, MOUSEMODE=1; ud=get(gco,''userdata''); set(ud(2),''backgroundcolor'',[.7 .7 .7]); set(gco,''backgroundcolor'',''yellow'');');

   bp=uicontrol('style','pushbutton','units','normal','pos',[.01 .60 .05 .04], ...
 	   	'backgroundcolor',[.7 .7 .7],'string','Toggla', 'fontsize',12, ...
		'callback','global THEFIG EXTRAdata, userdata=get(THEFIG,''UserData''); EXTRAdata(1)=1-EXTRAdata(1); if EXTRAdata(1), set(THEFIG,''pointer'',''crosshair'');else set(THEFIG,''pointer'',''circle''); end ');

   cp=uicontrol('style','pushbutton','units','normal','pos',[.01 .55 .05 .04], ...
 	   	'backgroundcolor',[.7 .7 .7],'string','Välj', 'fontsize',12, ...
		'callback','global MOUSEMODE, MOUSEMODE=3; ud=get(gco,''userdata''); set(ud(1),''backgroundcolor'',[.7 .7 .7]); set(gco,''backgroundcolor'',''yellow'');');

   set(ap,'userdata',[ap cp]);
   set(cp,'userdata',[ap cp]);
   MOUSEMODE=1;




elseif strcmp('SpectVect',choice)		% Spectrum from pole and zero vectors
   axes(userdata(1))	% PZ axes
   currax=axis;
   global WSLIDER REGTIT
   pos=get(userdata(1),'position');
   ysl1=pos(2)+pos(4)*abs(currax(3))/abs(currax(4)-currax(3));
   ysl2=pos(4)*currax(4)/abs(currax(4)-currax(3));
   deltay=0.045;  
   if vtype(TRFM)==6,	% Laplace transform
	WSLIDER=uicontrol('style','slider','units','normal','pos',[0.52 ysl1-deltay 0.028 ysl2+2*deltay], ...	% 'pos',[0.52 0.5055 0.028 0.484]
		'sliderstep',[0.02 0.1],'min',0,'max',currax(4),'value',0, ...
		'userdata',[],'callback','spectvect');

    
    % 	REGTIT=title('Ändra \omega_0 med regeln   ==>','horizontalalign','left','verticalalign','baseline','fontsize',14);
    REGTIT=title('           Ändra \omega_0 med regeln   ==>','horizontalalign','left','verticalalign','bottom','color','red','fontsize',16);
   else,		% z-transform
	WSLIDER=uicontrol('style','slider','units','normal','pos',[0.52 ysl1-deltay 0.028 ysl2+2*deltay], ...	
		'sliderstep',[0.02 0.1],'min',0,'max',3.1416,'value',0, ...
		'userdata',[],'callback','spectvect', 'fontsize',14);
  	REGTIT=title('            Ändra \Omega_0 med regeln   ==>','horizontalalign','left','verticalalign','bottom','color','red','fontsize',16);
   end

   spectvect

elseif strcmp('Sigplot',choice)		% Plot inverse transform signal
   figure
   if vtype(TRFM)==6,	% Laplace transform
	sig=ilaptr(TRFM);
    
	signal(sig)
	currax=axis;
    tmax=currax(2);
	axis([-tmax/5 currax(2:4)])

   else,		% z-transform
	sig=iztr(elimpz(TRFM));
	signal(sig,20)
	currax=axis;
	axis([-5 20 currax(3:4)])
   end
   title('Inversa transformen','verticalalignment','baseline')
   ohfig
   drawnow
   
elseif  strcmp('NewK',choice)		% Change the "level constant" K. Added August 2004
    K=str2num(get(userdata(16),'string'));
    TRFM(1,3)=K*TRFM(2,3);  % set new K
    NORMMODE1=1;          % Change "Normalised" status to ON (wether it actually is or not)
    pzmenu('N',1);          % and let pzmenu change/set status to OFF (and redraw spectrum)
    pzspplot('PZS','PZmen',-1);

end

    if strcmp('Move',choice) & strcmp('z',alt)
        delete(tchoose);
        if musknapp==3  % Om pol/mus-flytt med höger musknapp, så anropa igen!
            pzmenu('Move','z')
        end
    end
    

set(THEFIG,'pointer',currpoint);

