function pzaction
%pzaction
% pzaction anropas som ''windowbuttondownfcn'' när musknapp
% trycks ned vid användande av pzchange.
% Definition/anrop från pzchange och pzmenu.

global TRFM THEFIG REDX REDO lw
global MOUSEMODE PSZ EXTRAdata

userdata=get(THEFIG,'UserData');
% Tillägg dec 2014:
%EXTRAdata = get(userdata(16),'UserData'); % = userdata-vektorn i EXTRA (se pzchange)

parent=get(gco,'parent');
if ~(gco==userdata(1) | (parent==userdata(1) & gco~=userdata(1))), return, end
%  set(THEFIG,'pointer','watch');  % Snurrande markör medan pzchange jobbar
                                   % (behövs inte ?det går tillräckligt snabbt ändå)
pos=get(userdata(1),'CurrentPoint');
mouse=get(gcf,'SelectionType');
z=pos(1,1)+j*pos(1,2);
if (strcmp(mouse,'normal') & ~MOUSEMODE) | MOUSEMODE==1	% Add a pole/zero
   if EXTRAdata(1)					% ==1 => pole mode
	TRFM=addpo(TRFM,z);
   else
	TRFM=addze(TRFM,z);
   end
   pzmenu('N')	      		      		% Normalize, if needed
   pzspplot('PZS','addpz',EXTRAdata(1),z); 	% Plot extra pole/zero and spectrum


elseif (strcmp(mouse,'extend') & ~MOUSEMODE) 	% Change pole/zero mode
   EXTRAdata(1)=1-EXTRAdata(1);			% Change indicator for pointer mode
   set(THEFIG,'UserData',userdata);
%   set(userdata(16),'UserData',EXTRAdata);

elseif (strcmp(mouse,'alt') & ~MOUSEMODE) | MOUSEMODE==3	% Set the closest pole or zero 
					      	% (depending on pointermode)
                       			      	% to 'present'.
   if EXTRAdata(1)==1                  		% Pole mode
	poorze=TRFM(2,4:3+TRFM(2,2)); 		% the poles of TRFM
	plottype=REDX; ppsz=2;
   else			              		% Zero mode
	poorze=TRFM(1,4:3+TRFM(1,2)); 		% the zeros of TRFM
	plottype=REDO; ppsz=1;
   end
   if ~isempty(poorze)		% forr: max(size(poorze))>0 % Closest pole/zero exists
	dist=abs(z-poorze);
	closest=poorze(find(min(dist)==dist)); 	% closest pole/zero
	closest=closest(1);
	presx=get(userdata(14),'UserData');
   	presy=get(userdata(15),'UserData');
	presz=presx+j*presy;
	if presx==inf, presz=inf; end		% No present exists
	if min(abs(conj(closest)-presz),abs(closest-presz))>1e-4
		 				% Closest ~= present
	    EXTRAdata(6)=presx;			% Previous x = present x
	    EXTRAdata(7)=presy;			% Previous y = present y
	    EXTRAdata(5)=EXTRAdata(4);		% Previous type = present type
	    set(userdata(14),'UserData',real(closest)); % Change present
	    set(userdata(15),'UserData',imag(closest)); % position
	    if strcmp('Realdel:',get(userdata(12),'string'))		% Rectangular repr
		set(userdata(14),'string',num2str(real(closest))); 	% Change present
		set(userdata(15),'string',num2str(imag(closest))); 	% position
	    else						% Polar repr
		set(userdata(14),'string',num2str(abs(closest)));   	% Change present
		set(userdata(15),'string',num2str(angle(closest))); 	% position
	    end
	    EXTRAdata(4)=EXTRAdata(1);
	    if EXTRAdata(5), ptype='xb'; psz=2;
	    else ptype='ob'; psz=1;
	    end
	    hold on
	    if presz~=inf
 		plot(real(presz),imag(presz),ptype,'Markersize',PSZ(psz),'LineWidth',lw);      	% Plot previous
		plot(real(presz),-imag(presz),ptype,'Markersize',PSZ(psz),'LineWidth',lw)		% and its conjugate
	    end
	    plot(real(closest),imag(closest),plottype,'Markersize',PSZ(ppsz),'LineWidth',lw)		% Plot present
	    plot(real(closest),-imag(closest),plottype,'Markersize',PSZ(ppsz),'LineWidth',lw)		% and its conjugate
 	    hold off
	end

   end
   set(THEFIG,'UserData',userdata);
%   set(userdata(16),'UserData',EXTRAdata);
end

if EXTRAdata(1), 
   set(THEFIG,'pointer','crosshair');
else 
   set(THEFIG,'pointer','circle');
end

drawnow

% Tilläg 2014
% set(userdata(16),'UserData',EXTRAdata);







