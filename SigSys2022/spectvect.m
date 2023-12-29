function spectvect
%spectvect
% Funktionen används av (anropas från) pzmenu

global TRFM THEFIG WSLIDER lw PSZ
userdata=get(THEFIG,'UserData');
pole=TRFM(2,4:3+TRFM(2,2));	% The poles of TRFM
zero=TRFM(1,4:3+TRFM(1,2));	% The zeros of TRFM

axes(userdata(1))
WSLdata=get(WSLIDER,'userdata');	% Vector with handles to the pole and zero vectors 
					% and to the amplitude and phase 'dot' handles
%keyboard                    
if isempty(WSLdata)			% The first time => Initiate WSLdata
    hold on
    if vtype(TRFM)==6,		% Laplace Transform
	typeind=0;
    else			% z-transform
	typeind=1;
    end
    for a=1:length(pole)
	plot(real(pole(a)),imag(pole(a)),'xr','MarkerSize',PSZ(2),'linewidth',lw)
	pzhand=plot([real(pole(a)) typeind],[imag(pole(a)) 0],'r','linewidth',lw);
	WSLdata=[WSLdata pzhand];	
    end
    for a=1:length(zero)
	plot(real(zero(a)),imag(zero(a)),'ob','MarkerSize',PSZ(1),'linewidth',lw)
	pzhand=plot([real(zero(a)) typeind],[imag(zero(a)) 0],'b','linewidth',lw);
	WSLdata=[WSLdata pzhand];	
    end
    
    if vtype(TRFM)==6,		% Laplace Transform
    	currpzax=axis;		% axis of pz plot
    	whand=text('position',[0.05*currpzax(2) 0],'string','\omega_0','fontsize',18);
    else
	whand=text('position',[1.05 0],'string','e^{j\Omega_0}','fontsize',18);
    end
    hold off

    set(userdata(8),'string','0')			% f_min=0
    set(userdata(9),'string',num2str(get(WSLIDER,'max')/2/pi))	% f_max=W_max/(2pi) of pz plot
    pzspplot('Spe','Scale',1)			% Replot spectrum
    axes(userdata(2))
    hold on 
    ampch=get(userdata(2),'Children');		% The magnitude plot handle
    ampch=ampch(length(ampch));
    Magn=get(ampch,'YData');
    amphhand=plot(0,Magn(1),'.r','MarkerSize',32);%,'EraseMode','xor');
    hold off

    axes(userdata(3))
    hold on
    phch=get(userdata(3),'Children');			% The phase plot handle
    phch=phch(length(phch));
 
    Phase=get(phch,'YData');
     phasehand=plot(0,Phase(1),'.r','MarkerSize',32);%,'EraseMode','xor');
    hold off
    WSLdata=[WSLdata ampch amphhand phch phasehand whand];

    set(WSLIDER,'userdata',WSLdata);

else		% New slider value
    omega0=get(WSLIDER,'value');	%  Get w_0 from slider
    for a=1:length(pole)+length(zero)
	yline=get(WSLdata(a),'YData');
	if vtype(TRFM)==6,	% Laplace Transform
	    set(WSLdata(a),'YData',[yline(1) omega0]) % Change pole/zero vector to s=jw_0
	else			% z-transform
	    xline=get(WSLdata(a),'XData');
	    set(WSLdata(a),'XData',[xline(1) cos(omega0)]) 	% Change pole/zero vector
	    set(WSLdata(a),'YData',[yline(1) sin(omega0)]) 	% to z=e^(jW_0)
	end
    end
    if vtype(TRFM)==6,	% Laplace Transform
    	oldpos=get(WSLdata(a+5),'position');	
    	set(WSLdata(a+5),'position',[oldpos(1) omega0])	% Pos for texten 'wo'
    else		% z-transform
	set(WSLdata(a+5),'position',(1+0.3*omega0/pi)*[cos(omega0) sin(omega0)])	% Pos for texten 'Wo'
    end

    
    % a should now be length(pole)+length(zero)
    axes(userdata(2))
    fdata=get(WSLdata(a+1),'XData');		% The frequency vector
    dist=abs(fdata-omega0/2/pi);
    f=find(dist==min(dist));			% Find the position of the closest frequency

    Magn=get(WSLdata(a+1),'YData');		% The magnitude vector
    set(WSLdata(a+2),'XData',fdata(f(1)))	% a+2 => amphhand
    set(WSLdata(a+2),'YData',Magn(f(1)))
    
    Phase=get(WSLdata(a+3),'YData');		% The phase vector
    set(WSLdata(a+4),'XData',fdata(f(1)))	% a+4 => phasehand
    set(WSLdata(a+4),'YData',Phase(f(1)))

end

