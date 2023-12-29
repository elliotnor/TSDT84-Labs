function sphand=spectmod(X,AP,fmax)
%SPECTMOD Ritar spektrum
%    sphand = SPECTMOD(X,AP,fmax) eller SPECTMOD(X,AP): 
%    Fungerar som spect och spplot, men bara med ETT spektrum (X).
%    Bara spektrum till fourierserie, fourier- eller laplacetransform, dvs. vtype(X)=7, 5 resp. 6
%    Ingen clg/clf utförs innan utskrift. 
%    AP='A' => endast amplitudspektrum ritas 
%    AP='P' => endast fasspektrum ritas (P=phase)
%    sphand är handtag till plotten
%
%    Example:
%     X=in('1/(1+j*w)','w');
%     subplot(1,2,1)
%     spectmod(X,'A',10);
%     title('Amplitudspektrum')
%     subplot(2,2,2)
%     spectmod(X,'A',4);
%     ylabel('Amplitudspektrum')
%     subplot(2,2,4)
%     spectmod(X,'P',4);
%     ylabel('Fasspektrum')
%
%    See also spect

% Lasse Alfredsson, september 1997

global pm1 pm2 pm3 pm4 KlabL
lw=2;
if nargin==2,
	fmax=bandwi(X);
	if fmax==inf, fmax=200; end
end
if vtype(X)==5 | vtype(X)==6
    if vtype(X)==5		% Fouriertransform, X(w)
       	f=X(KlabL+2)*(0:(KlabL/2-1));
  	    if nargin==2, fmax=X(KlabL+1)/2; end
  	    if fmax>X(KlabL+1)/2, fmax=X(KlabL+1)/2; end
	    b=find(f<=fmax);
	    f=f(b);
	    X=X(b);
    elseif vtype(X)==6		% Laplacetransform, X(s)
	    f=(0:512)*fmax/512;
	    Xt=X(1,3)*poly(X(1,4:3+X(1,2)));
	    Xn=X(2,3)*poly(X(2,4:3+X(2,2)));
	    X=polyval(Xt,j*2*pi*f)./polyval(Xn,j*2*pi*f);
    end
    if strcmp(AP,'A')	% Amplituden plottas
	    sphand=plot(f,abs(X),'b','linewidth',lw);
    else			% AP='P' - fasspektrum plottas
  	    fi=180/pi.*angle(X);
  	    a=find(fi>0);
  	    fi(a)=fi(a)-360;
  	    sphand=plot(f,fi,'b','linewidth',lw);
    end
    grid
    xlabel('Frekvens  [Hz]','fontsize',14)
    set(gca,'fontsize',14)
    
elseif vtype(X)==7      % Fourierserie
    msize2=18;
    if nargin<3, fmax=30; end   % fmax = högsta deltonsnumret
    if fmax>255, fmax=255; end
    A=[real(X(1)) 2*abs(X(2:fmax+1))];
    if strcmp(AP,'A')	% Amplituden plottas
        dotpl=plot(0,A(1),'.');
        set(dotpl,'MarkerSize',msize2)
        axis([0 fmax 1.1*min([A 0]) 1.1*max([A 0])])
        %axis;
        hold on
        for i=1:fmax+1,
            dotpl=plot(i-1,A(i),'.');
            set(dotpl,'MarkerSize',msize2)
            plot([i-1 i-1],[A(i) 0])
        end
        grid
        title(['Grundtonens frekvens: ' num2str(X(513)) ' Hz'])
        xlabel('Deltonsnummer')
        ylabel('Amplitud')
        hold off
    elseif strcmp(AP,'P')	% Fasen plottas
        fi=180/pi*(pi/2+angle(X(1:fmax+1)));
        a=find(fi>180);
        fi(a)=fi(a)-360;
        a=find(A==0);
        i(a)=zeros(size(a));
        i=fi(2:length(fi));
        dotpl=plot(1,fi(1),'.');
        set(dotpl,'MarkerSize',msize2)
        axmin=1.1*min([fi 0]);
        axmax=1.1*max([fi 0]);
        if axmin==axmax, axmin=-90; axmax=90; end
        axis([0 fmax axmin axmax])
        %  axis;
        hold on
        for i=1:fmax,
            dotpl=plot(i,fi(i),'.');
            set(dotpl,'MarkerSize',msize2)
            plot([i i],[fi(i) 0])
        end
        grid
        xlabel('Deltonsnummer')
        ylabel('Fas')
        hold off
    end
end
