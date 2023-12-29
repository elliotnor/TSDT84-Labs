function pzspplot(type,todo,pmode,z)

% PZSPPLOT is used only by PZCHANGE to plot pz diagram and spectrum

% (c) Lasse Alfredsson  1994-2020


global TRFM THEFIG  % the transform and handle to the current figure
global REDX REDO lw PSZ EXTRAdata FSMAX

userdata=get(THEFIG,'UserData');
H=TRFM;
% Tillägg dec 2014:
% EXTRAdata = get(userdata(16),'UserData'); % = userdata-vektorn i EXTRA (se pzchange)

fontstorlek = 12;  %Fontstorlek på axelgradering, xlabel, ylabel


% PLOT OF POLES AND ZEROS:

if type=='PZS' | type=='P&Z'	% Plot pz
   axes(userdata(1));		% pz axis is active
   hold on
   zero=H(1,4:3+H(1,2));	% The zeros of TRFM
   pole=H(2,4:3+H(2,2));	% The poles of TRFM
   nz=num2str(H(1,2));		% #zeros
   np=num2str(H(2,2));		% #poles
   presx=get(userdata(14),'UserData');
   presy=get(userdata(15),'UserData');

   if todo=='addpz'		% Add extra pole or zero 
	set(userdata(14),'UserData',real(z));	 % Update the present
	set(userdata(15),'UserData',imag(z));	 % (rectangular) position
	if strcmp('Realdel:',get(userdata(12),'string')) 	 % Rectangular coord
	   set(userdata(14),'string',num2str(real(z)));	 % Update the present
	   set(userdata(15),'string',num2str(imag(z)));	 % (rectangular) position
	else
	   set(userdata(14),'string',num2str(abs(z)));	 % Update the present
	   set(userdata(15),'string',num2str(angle(z))); % (polar) position
	end
	if length(presx)>0	                % => Present pole/zero exists
	   if EXTRAdata(4)==1, prtype='xb'; psz=2;
	   else		       prtype='ob'; psz=1;
	   end
	   plot(presx,presy,prtype,'MarkerSize',PSZ(psz),'LineWidth',lw);  % Change present to green(pole) or yellow (zero)
	   plot(presx,-presy,prtype,'MarkerSize',PSZ(psz),'LineWidth',lw); % The complex conjugate
	   EXTRAdata(5)=EXTRAdata(4); % Update previous pointer mode
	   EXTRAdata(6)=presx;        % Update the
	   EXTRAdata(7)=presy; 	      % previous pole/zero
	end
	EXTRAdata(4)=pmode;			% Update present type
	if pmode==1, plottype=REDX; psz=2;	% New (present) pole
	else         plottype=REDO; psz=1;	% New (present) zero
	end
	plot(real(z),imag(z),plottype,'MarkerSize',PSZ(psz),'LineWidth',lw);		% Plot new pole/zero
	plot(real(z),-imag(z),plottype,'MarkerSize',PSZ(psz),'LineWidth',lw);	% and its complex conjugate
	set(THEFIG,'UserData',userdata);  
%    set(userdata(16),'UserData',EXTRAdata);
	pzmenu('Check');			% Check if present is correct

   elseif todo=='Scale'		% Change axis of pz plot
	   axis([str2num(get(userdata(4),'string')) ...
		 str2num(get(userdata(5),'string')) ...	
		 str2num(get(userdata(6),'string')) ...	
		 str2num(get(userdata(7),'string'))]);

   elseif todo=='Fulpl'	| todo=='PZmen'	% Default pz plot or plot after pzmenu
	 curraxis=axis;
	 cla
	 zre=max(abs(real(zero)));
	 zim=max(abs(imag(zero)));
 	 pre=max(abs(real(pole)));
	 pim=max(abs(imag(pole)));
	 range=1.1*max([zre zim pre pim]);
	 if isempty(range), range=1; end
	 if EXTRAdata(3)==1	% indicates z-transform
	    range=max(1,range);
	    t=0:.01:2*pi;
	    pp=plot(exp(j*t),'-');
	    set(pp,'color',[.7 .7 .7])
	    if todo=='Fulpl'
		axis([-1.3*range 1.3*range -1.3*range 1.3*range]);
	    else	% (i.e. todo='PZmen')
		axis(curraxis);
	    end
	    axis('square')
	 else
	    plot([0 0],[0 0])
	    if todo=='Fulpl'
	    	axis([-range range -1.15*range 1.15*range]);
	    else	% (i.e. todo='PZmen')
		axis(curraxis);
	    end
	 end
	 grid on
	 hold on
	 if length(zero)>0,
	    while length(zero)>0
		plot(real(zero(1)),imag(zero(1)),'ob','Markersize',PSZ(1),'LineWidth',lw);
 		a=1;
 		for b=length(zero):-1:2,
		    if abs(zero(b)-zero(1))<1e-4
     			a=a+1;
 		        zero(b)=[];
    		    end
       		end
   		if a>1, % Skriv ut multipliciteten på nollstället
 		   text(real(zero(1)),imag(zero(1)),[' (' int2str(a) ')'],'FontSize',13),
 	        end
	        zero(1)=[];
	    end
 	 end
 	 if length(pole)>0,
  	    while length(pole)>0,
   		plot(real(pole(1)),imag(pole(1)),'xb','Markersize',PSZ(2),'LineWidth',lw);
   		a=1;
   		for b=length(pole):-1:2,
    		    if abs(pole(b)-pole(1))<1e-4,
     			a=a+1;
     			pole(b)=[];
    		    end
   		end
   		if a>1,   % Skriv ut multipliciteten på polen
   		   text(real(pole(1)),imag(pole(1)),[' (' int2str(a) ')'],'FontSize',13),
   		end	
   		pole(1)=[];
  	    end
 	 end
	 curraxis=axis;
   	 set(userdata(4),'string',num2str(curraxis(1),'%.2f'));  % Update the edit
   	 set(userdata(5),'string',num2str(curraxis(2),'%.2f'));  % uicontrols for
   	 set(userdata(6),'string',num2str(curraxis(3),'%.2f'));  % the axis
	 set(userdata(7),'string',num2str(curraxis(4),'%.2f'));  % scalings
	 if length(presx)>0	                % => Present pole/zero exists
	    if EXTRAdata(4)==1, prtype=REDX; psz=2;
	    else prtype=REDO;  psz=1;
	    end
	    plot(presx,presy,prtype,'Markersize',PSZ(psz),'LineWidth',lw);  % Change present to cyan(pole) or yellow (zero)
	    plot(presx,-presy,prtype,'Markersize',PSZ(psz),'LineWidth',lw); % The complex conjugate
	 end
	 set(userdata(1),'Box','on');	% a line box around the pz plot
   end
   
   K = H(1,3)/H(2,3);
   if abs(K)>999                  % Justerat de K-relaterade raderna okt 2020
       Kstr=num2str(K,'%.5g');    % 5 värdesiffror
   else
       Kstr=num2str(K,'%.2f');    % 2 decimaler
   end
  
   set(userdata(16),'string',Kstr);  % Update K
   xlabel(['Antal nollställen: ' nz '    Antal poler: ' np])
 
   set(gca,'fontsize',fontstorlek) % Tillägg 201112: Justerar fontstorlek på axlarna, xlabel m.m. i pol-nollställediagrammet
   
   % Tillägg nov 2014: Rita realaxeln & imaginära axeln
   
   pzax = axis;
   line([pzax(1) pzax(2)], [0 0],'color',[0 0 0])
   line([0 0], [pzax(3) pzax(4)],'color',[0 0 0])
   hold off


end

if type=='PZS' | type=='Spe';	% Plot spectrum
   axes(userdata(2));		% ACTIVATE MAGNITUDE AXIS
   if todo=='Fulpl'  		% Use default (Full) frequency scaling
      fmin=0;     	
      if EXTRAdata(3)==0	% => Laplace transform
       	fmax=bandwi(H);
        if fmax==inf, fmax=200; end 
      else fmax=0.5;	% => z-transform
      end
   else						% Use selected frequency limits
      fmin=str2num(get(userdata(8),'string'));
      fmax=str2num(get(userdata(9),'string'));
   end

   f=(0:511)*2*(fmax-fmin)/1024+fmin;	% (511=>KlabL/2-1, 1024=>KlabL) doesnt' matter
   f3=f;    % Används vid plot av faskaraktäristiken
   Ut=H(1,3)*poly(H(1,4:3+H(1,2)));
   Un=H(2,3)*poly(H(2,4:3+H(2,2)));

   if EXTRAdata(3)==0				% Laplace transform
      UU=polyval(Ut,j*2*pi*f)./polyval(Un,j*2*pi*f);
      xlab='Frekvens  [Hz]';
      Hz_text=' Hz';
   else						% z-transform
      UU=polyval(Ut,exp(j*2*pi*f))./polyval(Un,exp(j*2*pi*f));
      xlab='Normerad frekvens';
      Hz_text='';
   end
   U=abs(UU);				% UU = Frekvensfunktionen,   U = Amplitudkaraktäristiken

   if EXTRAdata(2)==1,  % EXTRAdata(2)=magn_type  1: Linear  2: full dB  3: -5 to +5 dB
        maxm=1.2*max(U);
        if strcmp('NaN',num2str(maxm)), 		% If max(U)==NaN
            maxm=1e10;
        end
        if todo=='Scale' 				% Magnitude scaling changed
            curraxis=[fmin fmax str2num(get(userdata(10),'string')) ...
		    str2num(get(userdata(11),'string'))];
        else					% todo=='Fulpl' | 'PZmen' | 'addpz'
            curraxis=[fmin fmax 0 maxm];
            set(userdata(8),'string',num2str(fmin,'%.2f'));		% uicontrol: f_min
            set(userdata(9),'string',num2str(fmax,'%.2f'));		% uicontrol: f_max
            set(userdata(10),'string','0'); 				    % uicontrol: m_min
            set(userdata(11),'string',num2str(maxm));	% uicontrol: m_max
        end

   else  % dB-skala 
      
      
      U=U(1:512);						% U = ampl.kar från f=0 till f=fmax  
      U=max(U,1e-10*ones(size(U)));		% U = ampl.karaktäristiken, där 0 avrundas till 1e-10, för att inte log(U)=-Inf vid logaritmering
      U=20*log10(U);					% U = amplitudkaraktäristiken i dB-skala
      if EXTRAdata(2)==2        % Full dB-skala
		if todo=='Fulpl'
 		   curraxis=[fmin fmax -100 20];
  	    	   set(userdata(8),'string',num2str(fmin));	% uicontrol: f_min
  	    	   set(userdata(9),'string',num2str(fmax));	% uicontrol: f_max
    	 	   set(userdata(10),'string','-100'); 		% uicontrol: m_min
  	    	   set(userdata(11),'string','20');			% uicontrol: m_max
		elseif todo=='addpz' | todo=='PZmen' | (todo=='Scale' & pmode==1)
								% pmode is dummy here !!
		   maxm=round(max(U)+10);							% Maxamplituden + 10 dB
		   curraxis=[fmin fmax round(min(U)) maxm];  		% Magn. axis changed
     	   set(userdata(10),'string',num2str(curraxis(3)));	% uicontrol: m_min
      	   set(userdata(11),'string',num2str(curraxis(4)));	% uicontrol: m_max
		elseif todo=='Scale' & pmode==0,		
	 	  curraxis=[fmin fmax str2num(get(userdata(10),'string')) ...
		  str2num(get(userdata(11),'string'))];      	% magn. axis changed
		end
      else 	   % ( EXTRAdata(2)=3, dvs. dB-skal -5 dB till +5 dB )
   		curraxis=[fmin fmax -5 5];
		if todo=='Fulpl'
	   		set(userdata(8),'string',num2str(fmin,'%.2f'));	% uicontrol: f_min
      		set(userdata(9),'string',num2str(fmax,'%.2f'));	% uicontrol: f_max
		end
   	 	set(userdata(10),'string','-5'); 				% uicontrol: m_min
      	set(userdata(11),'string','5');					% uicontrol: m_max
      end
   end


   a=find(f>=fmin & f<=fmax);
   if EXTRAdata(2)==1,			% Linear magn. scaling
      plot(f(a),U(a),'LineWidth',lw)
      axis(curraxis)
      grid on
      TT=title('Frekvenskaraktäristik (eller -spektrum)');
      ylabel('Magnitud')
      xlabel(xlab)
   else							% dB scaling
      plot(f(a),U(a),'LineWidth',lw)
      axis(curraxis)
      grid on
      if EXTRAdata(2)==3,
		set(userdata(2),'ytick',[-5 -3 0 5]);
      end
      

      
% NU SKA GRÄNSFREKVENSEN/GRÄNSFREKVENSERNA BESTÄMMAS UTGÅENDE FRÅN MAXAMPLITUDEN
% LÄNGS HELA FREKVENSAXELN UPP TILL EN RIMLIGT HÖG MAXFREKVENS
% fmax = 10*AVST. TILL YTTERSTA POLEN 
% För ett HP-filter har man då nått ca. 99.5% av maxamplituden vid detta fmax
%
% U = (till och med hit) en vektor av längd 512, innehållande ampl.kar. från fmin till fmax
      
	
	   	if EXTRAdata(3)==0                          % Laplace transform
%            fmax2=bandwi(H);
%            if fmax2==inf, fmax2=FSMAX/2; end
            fmax2=10*max(abs(po(H)))/2/pi;
            f2=(0:999)*fmax2/1000;                   % Hela maximala frekvensområdet i 1000 punkter, oavsett skalning i fönstret
			UU2=abs(polyval(Ut,j*2*pi*f2)./polyval(Un,j*2*pi*f2));  % Ampl.kar längs hela frekv.axeln
            U2=max(UU2,1e-10*ones(size(UU2)));		% U2 = maxamplituden längs hela frekv.axeln
                                                    % 0 avrundas till 1e-10, för att inte log(U2)=-Inf vid logaritmering
            U2=20*log10(U2);                        % U2 = amplitudkaraktäristiken i dB-skala
            b=find(U2>=max(U2)-3);                  % Positionerna i U2 där ampl. är mellan max och max-3 dB
            f=f2;
        else                            % Om z-transform
            b=find(U>=max(U)-3);        % U är 512 lång
		end
			

      
%      textstr='Cutoff frequencies ';
       textstr='3 dB-gränsfrekvenser ';

      if b(1)~=1,
   		textstr=[textstr num2str(f(b(1)),'%.2f')];
      end
      
      c=find(diff(b)>1);
      if length(c)>0,
        if length(textstr)==21,
          textstr=[textstr num2str(f(b(c(1))),'%.2f') ' , ' num2str(f(b(c(1)+1)),'%.2f')];
        else
          textstr=[textstr ' , ' num2str(f(b(c(1))),'%.2f') ' , ' num2str(f(b(c(1)+1)),'%.2f')];
        end
        for i=2:length(c)-1,
          textstr=[textstr ' , ' num2str(f(b(c(i))),'%.2f') ' , ' num2str(f(b(c(i)+1)),'%.2f')];
        end
      end
%      if b(length(b))~=512,			% OLD t.o.m. 2015-11
      if b(length(b))~=length(f),		
          
        if length(textstr)==21,
          textstr=[textstr num2str(f(b(length(b))),'%.2f')];
        else
          textstr=[textstr ' , ' num2str(f(b(length(b))),'%.2f')];
        end
      end
      b=find(textstr==',');
      if length(b)~=0,
        b=b(length(b));
%       textstr=[textstr(1:b-1) 'and' textstr(b+1:length(textstr))];
        textstr=[textstr(1:b-1) 'och' textstr(b+1:length(textstr)) Hz_text];
      else
%       textstr=[textstr(1:15) 'y' textstr(19:length(textstr))];
        textstr=[textstr(1:18) textstr(21:length(textstr)) Hz_text];
      end
      TT=title(textstr);
      ylabel('Magnitud [dB] ')
      xlabel(xlab)
   end

         set(gca,'fontsize',fontstorlek) %Tillägg 201112: Ändra fontstl. på axlarna i amplitudgrafen
         set(TT,'fontsize',fontstorlek+4); % Lite större storlek på titeln
         
   axes(userdata(3));					% ACIVATE PHASE AXIS

   fi=180/pi.*angle(UU(a));
   c=find(fi>0);
   if length(c)>0, fi(c)=fi(c)-360; end
   plot(f3(a),fi,'LineWidth',lw)			% Plot phase characteristic
   axis([fmin fmax -400 0])
   grid
   ylabel('Fas')
   xlabel(xlab)
   
   set(gca,'fontsize',fontstorlek) %Tillägg 201112: Ändra fontstl. på axlarna i fasgrafen
   
end

set(THEFIG,'UserData',userdata); 
% Tilläg 2014
% set(userdata(16),'UserData',EXTRAdata);
