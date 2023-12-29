function splplot(U,n,fmax)
%splplot
% splplot används lokalt av logspect

global pm1 pm2 pm3 pm4 KlabL FSMAX

Hz_text='';
vu=vtype(U);
if vu==5,       % Fouriertransform, tidskontinuerlig
     f=U(KlabL+2)*(0:KlabL/2-1);
     if nargin<3, fmax=U(KlabL+1)/2; end
     Hz_text=' Hz';

elseif vu==6,   % Laplacetransform
     if nargin<3, fmax=bandwi(U); end
     if fmax==inf, fmax=FSMAX/2; end
     f=(0:KlabL/2-1)*2*fmax/KlabL;
     Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
     Un=U(2,3)*poly(U(2,4:3+U(2,2)));
     
     H=U;   % Kopia av systemfunktionen - används längre ned för att bestämma 3 dB-gränsv.frekvenser
     U=polyval(Ut,j*2*pi*f)./polyval(Un,j*2*pi*f);
     Hz_text=' Hz';

elseif vu==9,   % Fouriertransform, tidsdiskret
    f=(0:KlabL/2-1)/KlabL;
    if nargin<3, fmax=.5; end

elseif vu==10,  % z-transform
     if nargin<3, fmax=.5; end
     f=(0:KlabL/2-1)/KlabL;
     Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
     Un=U(2,3)*poly(U(2,4:3+U(2,2)));
     U=polyval(Ut,exp(j*2*pi*f))./polyval(Un,exp(j*2*pi*f));
end

if vu~=11,      % Allt utom DFT
    Ufi=U;  % Kopia av U som används för at plotta fasen
    ffi=f;  % Kopia av f som används för at plotta fasen
     U=abs(U(1:KlabL/2));
     a=find(f<=fmax);
     %U=max(U,1e-5*ones(size(U)));            % OBS!!! BORTKOMMENTERAD DEC -99
     U=20*log10(U);
     plot(f(a),U(a))
     axis([0 fmax -100 20])
     grid
     
% Kopierad text och kod från pzspplot, för vettig beräkning av gränsfrekvenser:
% NU SKA GRÄNSFREKVENSEN/GRÄNSFREKVENSERNA BESTÄMMAS UTGÅENDE FRÅN MAXAMPLITUDEN
% LÄNGS HELA FREKVENSAXELN UPP TILL EN RIMLIGT HÖG MAXFREKVENS
% fmax = 10*AVST. TILL YTTERSTA POLEN 
% För ett HP-filter har man då nått ca. 99.5% av maxamplituden vid detta fmax
%
% U = (till och med hit) en vektor av längd 512, innehållande ampl.kar. från 0 till fmax

     if vu==6,    % Laplacetransform: Hitta 3 dB-gränsvinkelfrekvenser
         
        fmax2=10*max(abs(po(H)))/2/pi;
        f2=(0:KlabL-1)*fmax2/KlabL;                   % Hela maximala frekvensområdet i 1000 punkter, oavsett skalning i fönstret
        UU2=abs(polyval(Ut,j*2*pi*f2)./polyval(Un,j*2*pi*f2));  % Ampl.kar längs hela frekv.axeln
        U2=max(UU2,1e-10*ones(size(UU2)));		% U2 = maxamplituden längs hela frekv.axeln
                                                % 0 avrundas till 1e-10, för att inte log(U2)=-Inf vid logaritmering
        U2=20*log10(U2);                        % U2 = amplitudkaraktäristiken i dB-skala
        b=find(U2>=max(U2)-3);                  % Positionerna i U2 där ampl. är mellan max och max-3 dB
        f=f2;
   
     else
         b=find(U>=max(U)-3); % Alla positioner där man är mellan max och max-3dB
     end
     
     
 text='3 dB-gränsfrekvenser ';
    % text='Cutoff frequencies ';
     if b(1)~=1,
      text=[text num2str(f(b(1)),'%.2f')];
     end
     c=find(diff(b)>1);

     if length(c)>0,
          if length(text)==21,    
              % Tillägget '%.2f' i num2str anger att omvandlingen ska visa 2 decimaler
              % Om man i stället har t.ex. '%.4g', så erhålls 4 signifikanta siffror
            text=[text num2str(f(b(c(1))),'%.2f') ' , ' num2str(f(b(c(1)+1)),'%.2f')];
          else
            text=[text ' , ' num2str(f(b(c(1))),'%.2f') ' , ' num2str(f(b(c(1)+1)),'%.2f')];
          end
          for i=2:length(c)-1,
            text=[text ' , ' num2str(f(b(c(i))),'%.2f') ' , ' num2str(f(b(c(i)+1)),'%.2f')];
          end
     end
     % if b(length(b))~=KlabL/2,   % Äldre, funkar ej vid uppgraderad splplot okt 2020
       if b(length(b))~=length(f)
          if length(text)==21,
           text=[text num2str(f(b(length(b))),'%.2f')];
          else
           text=[text ' , ' num2str(f(b(length(b))),'%.2f')];
          end
     end
     b=find(text==',');
     if length(b)~=0,
          b=b(length(b));
          text=[text(1:b-1) 'och' text(b+1:length(text)) Hz_text];
        % text=[text(1:b-1) 'and' text(b+1:length(text))];
     else
          text=[text(1:18) text(21:length(text)) Hz_text];
        % text=[text(1:15) 'y' text(19:length(text))];
     end
     title(text)
     ylabel('Magnitud  [dB]')
     if vu==5 | vu==6,
      xlabel('Frekvens  [Hz]')
     else
      xlabel('Normerad frekvens')
     end
     
% Äldre kod för att rita fasen, men den berkar vara kod för amplituden!?
% Har aldrig detta funkat?? Har justerat nu i dec 2020 till samma
% som i spplot - se koden efter följande kommenterade stycke:
%      if n==2,
%       subplot(2,1,2)
%       plot(f(a),U(a))
%       axis([0 fmax -5 5])
%       grid
%       ylabel('Magnitud [dB]')
%       if vu==5 | vu==6,
%        xlabel('Frekvens  [Hz]')
%       else
%        xlabel('Normerad frekvens')
%       end
%      end


if n==2,
  b=find(ffi<=fmax);
  fi=180/pi.*angle(Ufi(b));
  a=find(fi>0);
  fi(a)=fi(a)-360;
  subplot(2,1,2)
  plot(ffi(b),fi), 
  grid
  ylabel('Fas')
  if vu==5 | vu==6,
   xlabel('Frekvens  [Hz]')
  else
   xlabel('Normerad frekvens')
  end
  
end

     
else    % Om DFT
     if nargin<3, fmax=U(129); end
     if fmax>U(129)-1, fmax=U(129)-1; end
     U=abs(U(1:fmax+1));
     %U=max(U,1e-5*ones(size(U)));            % OBS!!! BORTKOMMENTERAD DEC -99
     U=20*log10(U);
     plot(0:fmax,U,'o')
     axis([0 fmax -100 20])
     hold on
     for i=1:fmax,
        plot([i-1 i-1],[U(i) -100])
     end
     hold off
     grid
     xlabel('Punktnummer')
     ylabel('Magnitud')
     if n==2,
          subplot(2,1,2)
          plot(0:fmax,U,'o')
          axis([0 fmax -5 5])
          hold on
          for i=1:fmax,
               plot([i-1 i-1],[U(i) -5])
          end
          hold off
          grid
          xlabel('Punktnummer')
          ylabel('Magnitud')
     end
end
shg


