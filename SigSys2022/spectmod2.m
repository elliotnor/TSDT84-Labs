function spectmod2(H, samplepoints, plots, fmax, tmax)
% Tillagd av Mattias 2020 (plot–offline, men nytt namn här) för 
% plothjälp i SigSys-skriptet
% Modifierad av Lasse

spectrum = plots(1);        % Om == 1 => Rita amplitudspektrum/-karaktäristik
phase = plots(2);           % Om == 1 => Rita fasspektrum/-karaktäristik
unitresponse = plots(3);    % Om == 1 => Rita signal/impulssvar

global FSMAX

if spectrum || phase
    % hantera laplace (vtype=6) och z (vtype=10)
    % utgår från spect.m och spplot.m
    if vtype(H)==6  % Laplace transform
        if nargin==3
            fmax = bandwi(H);
            if fmax==inf, fmax = FSMAX/2; end
        end
        f = (0:512)*fmax/512;
        Ht = H(1,3)*poly(H(1,4:3+H(1,2)));
        Hn = H(2,3)*poly(H(2,4:3+H(2,2)));
        Hnew = polyval(Ht,j*2*pi*f)./polyval(Hn,j*2*pi*f);
    else    % z-transform
        fmax=.5;
        f=(0:512)/1024;
        Ht=U(1,3)*poly(H(1,4:3+H(1,2)));
        Hn=U(2,3)*poly(H(2,4:3+H(2,2)));
        Hnew=polyval(Ht,exp(j*2*pi*f))./polyval(Hn,exp(j*2*pi*f));
    end
    
    b=find(f<=fmax);
end

if spectrum

    %figure;
    %clf
    if phase            % Både amplitud & fas
        figure(444)
        subplot(2,1,1);
    else                % Bara amplitud
        figure(222);
    end
    
    plot(f(b),abs(Hnew(b)))
    Hmax=max(abs(Hnew(b)));   % Tillägg Lasse augusti 2004
    if ~isnan(Hmax), set(gca,'ylim',[0 Hmax*1.1]), end % Tillägg Lasse augusti 2004
    grid
    title('Amplitudkaraktäristik')
    % ylabel('Magnitude')
    xlim([0 fmax])
    
    if vtype(H)==6
        xlabel('Frekvens  [Hz]')
        
    else
        xlabel('Normerad frekvens')
    end
    ohfig
end

if phase
    %figure;
    %clf
    
    if spectrum             % Både amplitud & fas
        figure(444)
        subplot(2,1,2);
    else                    % Bara fas
        figure(222);
    end
    
    fi=180/pi.*angle(Hnew(b));
    a=find(fi>0);
    fi(a)=fi(a)-360;
    plot(f(b),fi), 
    grid
    title("Faskaraktäristik");
    % ylabel('Phase')
    if vtype(H)==6
        xlabel('Frekvens  [Hz]')
    else
        xlabel('Normaliserad frekvens')
    end
    xlim([0 fmax])
    ohfig
end


if unitresponse
   figure(102);
   if vtype(H)==6	% Laplacetransform
	sig=ilaptr(H);
	if nargin<5
        tmax=sig(samplepoints+1)*samplepoints/8;
    end
	signal(sig,tmax)
    xlabel('Tid [s]')
	currax=axis;
%	axis([-tmax/5 tmax*4/5 currax(3:4)])
    axis([-tmax/5 tmax currax(3:4)])
   else		% z-transform
	sig=iztr(elimpz(H));
	signal(sig,20)
    xlabel('Sampelnummer n')
	currax=axis;
	axis([-5 20 currax(3:4)])
   end
   title('Impulssvar','verticalalignment','baseline')
     ohfig
     drawnow
end
end