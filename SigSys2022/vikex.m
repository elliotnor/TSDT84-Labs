function vikex(action,fs2)

% VIKEX Samplings- & vikningsexempel i Signaler & System.
%       Används i en av kursens datoruppgifter.
% 
%       Användning: Sampling av högersidig sinus resp. dämpad sinus
%       - se hur poler ändras i z-planet då samplingsfrekvensen fs ändras.
%       Notera att fs/2 kan varieras mellan 4 Hz och 40 Hz, med hjälp av regeln nere
%       till vänster. Se till att förstora figurfönstret till hela skärmens storlek!
%
% (c) Lasse Alfredsson, ISY/LiTH, Senast uppdaterad för TSDT18 2012-11-28

%       OBS! Kretslabs globala variabel KlabL anger antal sampelvärden för
%       tidssignaler i Kretslab. Vanligtvis är KlabL=65536, men för att VIKEX skall
%       fungera korrekt kommer funktionen att ändra KlabL till 1024!!
%       När ni är färdiga med VIKEX sätter ni lämpligen KlabL till 65536 igen!

global Xf pm1 pm2 pm3 Xf x_sample sigval x_text2 xn_text Hspol AX x_text fsslider edfs fstxt xthand fshand fstext xnhand pol1 pol2 Khand Xthand argXthand KlabL


if nargin==0 , 
    action='init'; 
    fs2=2; 
    Ktemp=KlabL;
    KlabL=1024;
end

if strcmp(action,'init')
    sigval=fs2;	% bara i detta menyanrop används inargumentet fs2 för att indikera/representera sigval.
   	fs2=28;
    
   	figure(10)
   	clf
	set(gcf,'name',' ')
   	axesdef(12,'Sampling - vikningseffekt');

  	fsslider=uicontrol('style','slider','units','pixels', ...
		'pos',[160 5 200 20], ...	
		'sliderstep',[0.02 0.1],'min',4,'max',40, ...
		'value',fs2, ...
   		'callback','global fsslider fstxt, fs2=round(10*get(fsslider,''value''))/10; set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');

      fstxt= uicontrol('style','text','units','pixels', 'backgroundcolor','white', ...
      	'pos',[10 4 120 22], 'string',['fs/2 = ' num2str(fs2) ' Hz'], 'fontsize', 14);

  uimenu('Label','            ');
     sigmen = uimenu('Label','Välj ny signal !!     ');
              uimenu(sigmen, 'Label','20*exp(-10*t)*sin(2*pi*10*t)*us(t)', 'callback','vikex(''init'',1)');
              uimenu(sigmen, 'Label','16*sin(2*pi*20*t)*us(t)', 'callback','vikex(''init'',2)');

     fsmenu=uimenu('Label','Välj specifika sampelfrekvenser');
	   fs2vektor=[4 5 6 7 8 9 10 11 12 13 40/3 15 20];
		  uimenu(fsmenu,'Label','fs = 8 Hz,   dvs. fs/2 = 4 Hz', ...
		     'callback','global fsslider fstxt, fs2=4; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 80/9 Hz,   dvs. fs/2 = 40/9 (ca. 4.444) Hz', ...
		     'callback','global fsslider fstxt, fs2=40/9; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 10 Hz,   dvs. fs/2 = 5 Hz', ...
		     'callback','global fsslider fstxt, fs2=5; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 80/7 Hz,   dvs. fs/2 = 40/7 (ca. 5.714) Hz', ...
		     'callback','global fsslider fstxt, fs2=40/7; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 12 Hz,   dvs. fs/2 = 6 Hz', ...
		     'callback','global fsslider fstxt, fs2=6; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 40/3 Hz,   dvs. fs/2 = 20/3 (ca. 6.666) Hz', ...
		     'callback','global fsslider fstxt, fs2=20/3; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 15 Hz,   dvs. fs/2 = 7.5 Hz', ...
		     'callback','global fsslider fstxt, fs2=7.5; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 16 Hz,   dvs. fs/2 = 8 Hz', ...
		     'callback','global fsslider fstxt, fs2=8; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
 		  uimenu(fsmenu,'Label','fs = 18 Hz,   dvs. fs/2 = 9 Hz', ...
		     'callback','global fsslider fstxt, fs2=9; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
 		  uimenu(fsmenu,'Label','fs = 20 Hz,   dvs. fs/2 = 10 Hz', ...
		     'callback','global fsslider fstxt, fs2=10; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
 		  uimenu(fsmenu,'Label','fs = 22 Hz,   dvs. fs/2 = 11 Hz', ...
		     'callback','global fsslider fstxt, fs2=11; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 25 Hz,   dvs. fs/2 = 12.5 Hz', ...
		     'callback','global fsslider fstxt, fs2=12.5; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');	
		  uimenu(fsmenu,'Label','fs = 80/3 Hz,   dvs. fs/2 = 40/3 (ca. 13.333) Hz', ...
		     'callback','global fsslider fstxt, fs2=40/3; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');	
		  uimenu(fsmenu,'Label','fs = 30 Hz,   dvs. fs/2 = 15 Hz', ...
		     'callback','global fsslider fstxt, fs2=15; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 40 Hz,   dvs. fs/2 = 20 Hz', ...
		     'callback','global fsslider fstxt, fs2=20; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 60 Hz,   dvs. fs/2 = 30 Hz', ...
		     'callback','global fsslider fstxt, fs2=30; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');
		  uimenu(fsmenu,'Label','fs = 80 Hz,   dvs. fs/2 = 40 Hz', ...
		     'callback','global fsslider fstxt, fs2=40; set(fsslider,''value'',fs2), set(fstxt,''string'',[''fs/2 = '' num2str(fs2) '' Hz'']), vikex(''current'',fs2)');

	fs=2*fs2;

	pm1=1/fs;		% pm1 = T
	pm2=exp(-10*pm1);	% pm2 = r
		
	switch sigval
		case 1
			xtitel = '{\it x}({\itt}) = 20{\ite}^{-10{\itt}}sin(2\pi10{\itt}){\itu}({\itt})';
			x_text = '20*exp(-10*t)*sin(2*pi*10*t)*us(t)';	
			x_text2 = '20*exp(-10*t).*sin(2*pi*10*t).*us(t)';
			xn_text = '20*exp(-10*pm1*n)*sin(20*pi*pm1*n)*us(n)';
			Xs = in(400*pi,[1 20 400*pi^2+100],'s');
			pm3=2*pi*10*pm1;	% pm3 = Omega_0
			Kz=20*pm2*sin(pm3);
			Hspol=-10+j*2*pi*10;
		case 2
			xtitel = '{\it x}({\itt}) = 16sin(2\pi20{\itt}){\itu}({\itt})';
			x_text = '16*sin(2*pi*20*t)*us(t)'; 	
			x_text2 = '16*sin(2*pi*20*t).*us(t)';
			xn_text = '16*sin(2*pi*20*pm1*n)*us(n)';
			Xs = in(16*2*pi*20,[1 0 (2*pi*20.3)^2],'s');
			pm3=2*pi*20*pm1;	% pm3 = Omega_0
			Kz=16*sin(pm3);
			Hspol=j*2*pi*20;
   end
 

	x=in(x_text,'t');
	x_sample=sample(x_text,fs);
	Xf=foutr(x_sample);

    axes(AX(1,1))
   	signalmod(x,.5)
   	switch sigval
	case 1
		axis([-.1 .5 -10 16])
	case 2
		axis([-.1 .5 -17 17])
	end
   	grid on
   	hold on
	t=1/fs*(-100:500);
	xthand= plot(t,eval(x_text2),'.r','markersize',20,'erasemode','xor');
   	hold off
   	title(xtitel)
   
    axes(AX(1,2))
   	plot(Hspol,'xr','markersize',12)
   	hold on
   	plot(conj(Hspol),'xb','markersize',12)
   	title('\it X(s)')
   	xlabel(['{\it K_{(s)}} = ' num2str(Xs(1,3))])
	switch sigval
	case 1
	   	axis([-20 10 -80 80])
	   	set(gca,'XTick',[-20 -10 0 10])
	   	set(gca,'YTick',[-80 -60 -40 -20 0 20 40 60 80])
		ax=1.05;
	case 2
	   	axis([-20 10 -160 160])
	   	set(gca,'XTick',[-20 -10 0 10])
	   	set(gca,'YTick',[-160 -80 0 80 160])
		ax=120;
	end
   	grid on
   	hold off
 
    axes(AX(1,3))
	spectmod(Xs,'A',40);	
% 	title('\it X(f)|')
    title('|{\itX}({\itj2\pif_ })|')
	axis([0 40 0 ax]) 
   	hold on
  	fshand=plot(fs/2*[1 1],[0 ax],'r','erasemode','xor');
   	fstext=text(fs/2+1,0.25*ax,'f_s/2','erasemode','xor','color','red');
   	grid on
   	hold off
   
    axes(AX(1,4))
   	spectmod(Xs,'P',40);
   	title('arg {\itX}({\itj2\pif_ })')
  
    axes(AX(2,1))
	    vv=version; 
        if vv(1)=='7'; 
%             xnhand=stem('v6',-3:17,x_sample(510:530),'filled');
            xnhand=stem(-3:17,x_sample(510:530),'filled');
        else % Matlab version 6 och tidigare
            xnhand=stem(-3:17,x_sample(510:530),'filled');
        end
   % keyboard
	set(xnhand(1),'erasemode','xor');
% 	set(xnhand(2),'erasemode','xor');
   	% signalmod(x_sample,20)
   	% set(gca,'XLim',[-.1 .5]*fs)
   	grid on
   	title('{\it x}[{\itn}] = {\itx}({\itnT})')
   	xxll=xlabel('\it n','position',[17.6612  -18.1184   17.3205]);
   	switch sigval
	case 1
		axis([-2 17 -10 16])
	case 2
		axis([-2 17 -17 17])
	end
    
    
 
    axes(AX(2,2))
   	pzmod(in([1 0],1,'z'));
   	hold on
   	axis('square')
	pol1=plot(exp(Hspol/fs),'xr','markersize',12,'erasemode','xor');
	pol2=plot(exp(conj(Hspol)/fs),'xb','markersize',12,'erasemode','xor');
	title('{\it X}[{\itz}]_{(impulsinv. transf. från {\itX}({\its}))}')
   	Khand=xlabel(['{\it K_{(z)}} = ' num2str(Kz)],'erasemode','xor');
   	set(gca,'XTick',[-1 0 1])
   	set(gca,'YTick',[-1 0 1])
   	grid on
   	hold off
   
    axes(AX(2,3))
    	theta=(0:511)/1024;
    	Xthand=plot(theta,abs(Xf(1:512)),'erasemode','xor');
	ax=axis;
	set(AX(2,3),'Ylim',[0 1.1*ax(4)])
    	set(gca,'XLim',[0 0.5])
    	set(gca,'XTick',[0 .25 .5])
    	grid on
%     	xlabel('Normerad frekvens \Theta')
    	xlabel('Normerad vinkelfrekvens \Omega')
%    	tXT=title('              {\it     |X[\Theta]|}    ( {\it X[\Theta] = F}\{{\it x[n]} \} )      ','horizontalalign','center');
   	title('|{\itX}[{{\ite}^{{\itj}\Omega}}]|');
    set(gca,'xticklabel',{'0','pi/2','pi'})	

  
    axes(AX(2,4))
   	argXthand=plot(theta,angle(Xf(1:512))*180/pi,'erasemode','xor');
   	set(gca,'XLim',[0 0.5])
   	set(gca,'XTick',[0 .25 .5])
	set(gca,'YLim',[-180 180])
	set(gca,'YTick',[-180 -90 0 90 180])
   	grid on
   	title('arg {\it X}[{\ite}^{{\itj}\Omega}]');
    set(gca,'xticklabel',{'0','pi/2','pi'})
%    	title('arg {\itX}[{\ite}^{{\itj2\pi}\Theta}_ ]');
%    	xlabel('Normerad frekvens \Theta')
    	xlabel('Normerad vinkelfrekvens \Omega')
	if sigval==2
      text(0.06,30,'Fasen är otydbar!!','fontsize',14,'color','red');
      set(argXthand,'visible','off');
	end

   OHfigure2


else  % action =/ 'init', dvs slideranrop eller direkt funktionsanrop

	fs=2*fs2;

	pm1=1/fs;		% pm1 = T
	pm2=exp(-10*pm1);	% pm2 = r

	x_sample=sample(x_text,fs);
   Xf=foutr(x_sample);
   if max(abs(Xf))<5.7e-10, Xf=zeros(1,1024); end	% Sampling i nollgenomgångar => eliminera beräkningsfel

 	switch sigval
		case 1
			pm3=2*pi*10*pm1;	% pm3 = Omega_0
			Kz=20*pm2*sin(pm3);
		case 2
			pm3=2*pi*20*pm1;	% pm3 = Omega_0
			Kz=16*sin(pm3);
   end
      if abs(Kz)<1e-12, Kz=0; end	% Eliminera beräkningsfel vid sampling i nollgenomgångar!
      

   %AX(1,1)
	t=1/fs*(-100:500);
	set(xthand,'xdata',t);
	set(xthand,'ydata',eval(x_text2));
	
    %AX(1,3)
	set(fshand,'xdata',fs2*[1 1]);
	posfs=get(fstext,'position');
	set(fstext,'position',[fs2+1 posfs(2:3)]);

    %AX(2,1)
 	set(xnhand(1),'ydata',x_sample(510:530));
% 	xn_ydata=get(xnhand(2),'ydata');
% 	xn_ydata(2:3:3*21)=x_sample(510:530);
% 	set(xnhand(2),'ydata',xn_ydata);
   
    
   %AX(2,2)
	polrod=exp(Hspol/fs);
	set(pol1,'xdata',real(polrod));
	set(pol1,'ydata',imag(polrod));
	set(pol2,'xdata',real(polrod));
	set(pol2,'ydata',-imag(polrod));
	set(Khand,'string',['{\it K_{(z)}} = ' num2str(Kz)]);

   %AX(2,3) & AX(2,4)
		set(Xthand,'ydata',abs(Xf(1:512)));
	switch sigval
	case 1
		set(argXthand,'ydata',angle(Xf(1:512))*180/pi);
	case 2
		
	end
	

end

% if nargin==0,
%     disp('OBS!!')
%     disp('Kretslabs globala variabel KlabL anger antal sampelvärden för tidssignaler i Kretslab.')
%     disp('Vanligtvis är KlabL=65536, men i vikex.m används KlabL=1024.') 
%     disp(['Eventuellt behöver du justera KlabL när du är färdig med vikex (du har f.n. KlabL=' int2str(Ktemp) ').'])
%     
%     Wtxt='Kretslabs globala variabel KlabL anger antal sampelvärden för tidssignaler i Kretslab. ';
%     Wtxt=[Wtxt 'Vanligtvis är KlabL=65536, men i vikex.m används KlabL=1024. '];
%     Wtxt=[Wtxt 'Eventuellt behöver du justera KlabL när du är färdig med vikex (du har f.n. KlabL=' int2str(Ktemp) ').'];
%     warndlg(Wtxt, 'Ändra KlabL')
% end



