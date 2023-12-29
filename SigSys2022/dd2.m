%DD2 Demonstration av Kretslabfunktioner för tidsdiskreta signaler och system. 
%
%    Tryck på valfri tangent för att stega dig igenom demonstrationsfilen! 
%    KÖR DD2 FÖR ATT SE HUR KRETSLAB ANVÄNDS (i del 2)!!
%
% See also DD1

clc

    % Lasse: Vid förevisning, ställ om fonten i "File -> Preferences ->
   % -> Command Window Font" till "MS Sans Serif", 18 pt !!!
   
   % OBS! Funktionen OHfig används nedan för att rita figurer
   % med tjockare streck och med större textstorlek
	% ----------------------------------------------------------------

	
	clc
  	echo on 
	% Mata in systemfunktionen till ett visst LTI-system
	% H(s) = (s^3 + 100s)/(s^3 + 6s^2 + 16s + 16)
H=in([1 0 100 0],[1 6 16 16],'s');

	
pz(H)	  % Rita pol-nollställediagram
	OHfig

	pause  % ----------------------------------------------------------------

	% Rita amplitud- och faskaraktäristik (0 - 6 Hz)
spect(H,6)
	OHfig

	pause  % ----------------------------------------------------------------

Hn=normal(H);	% Amplitudnormera H => |H(f)|max = 1
   
spect(H,Hn,6)	% Rita |H(f)| och |Hn(f)|
	OHfig

	pause  % ----------------------------------------------------------------

logspect(Hn,6)	% Rita |H(f)| i logaritmisk skala
   OHfig
   
	% OBS!!  "Warning: Log of zero" är inget att bry sig om !
   
   pause  % ----------------------------------------------------------------
   clc
   
	% Mata in signalen x(t), som sedan får bli insignal till systemet 
x=in('exp(-t)*sin(7*t)*us(t)','t');
   
	% Fouriertransformera x(t) (OBS! Laplacetransformering går ej numeriskt!)  
X=foutr(x);

	% Beräkna utsignalens frekvensspektrum, Y(f)=X(f)*Hn(f)
	% Här används det amlitudnormerade filtret med systemfkn Hn(s)!
	% Kretslab beräknar själv Hn(f) = Hn(s)|s=j2pi*f
    
Y=output(X,Hn);		

spect(X,Y,6)	% Rita |X(f)| och |Y(f)|
	OHfig

	pause  % ----------------------------------------------------------------
   
   clc
	% Rita |X(f)|, |H(f)| och |Y(f)| = |X(f)|*|H(f)| i samma figur:
   
clf	% Rensa figurfönstret

plotX= spectmod(X,'A',6);	% Rita |X(f)| (blå) (plotX är "handtag" till kurvan)
hold on	% Så att nästa kurva ritas i samma diagram

plotH= spectmod(Hn,'A',6);	  % Rita |Hn(f)| (plotH är "handtag" till kurvan)
set(plotH,'color','magenta') 	% Ändra |Hn(f)|-kurvan till röd färg

plotY= spectmod(Y,'A',6);	% Rita |Y(f)| (plotY är "handtag" till kurvan)
set(plotY,'color','red')		% Ändra |Y(f)|-kurvan till röd färg

legend('\it |X(f)|','\it |Hn(f)|','\it |Y(f)| = |X(f)|*|Hn(f)|')
hold off

	pause  % ----------------------------------------------------------------
   clc
   
N = ze(H)  	% Nollställena till H(s) (den *icke* amplitudnormerade!)
   
P = po(H)	  % Polerna till H(s):

	pause  % ----------------------------------------------------------------
   
poly(N)	  % Ger täljarpolynomens koefficienter (från nollställena) för H(s)

poly(P)	  % Ger nämnarpolynomens koefficienter (från polerna) för H(s)

	pause  % ----------------------------------------------------------------

[Tk,Nk] = coeff(H)	% Täljar- och nämnarpolynomens koefficienter för H(s)

pause  % ---------------------------------------------------------------

roots(Tk)  	% Ger nollställena till polynomet med koefficienter i Tk
	% = Nollställena till H(s)

roots(Nk)	% Ger nollställena till polynomet med koefficienter i Nk
	% = Polerna till H(s)

	pause  % ----------------------------------------------------------------
	clc
   
	% Hn(s) har ett komplexkonjugerat polpar i s = -2 +/- 2j
	% Flytta dessa till s = -1 +/- 6j, 
	% samt flytta polen i s=-2 till s=-5,5 och öka dess multipliciteten med 1 
	% (ger alltså dubbelpol i s=-5,5)
	% Tag även bort nollstället i origo.
	% Den nya systemfunktionen betecknas H2(s) och skall även amplitudnormeras:
   
	% Tag först bort polparet (OBS - komplexkonjugatet tas automatiskt bort)
	% samt polen i -2:
H2=rempo(Hn,[-2+2j -2]);
   
	% Tag bort nollstället i origo;   
H2=remze(H2,0);
   
	% Lägg till poler i s = -1 +/- 6j och dubbelpol i s = -5,5:
H2=addpo(H2,[-1+6j -5.5 -5.5]);

	% Amplitudnormera:
H2=normal(H2);
   
	pause  % ----------------------------------------------------------------
   
	% Rita pol-nollställediagram:
pz(H2)
	OHfig

	pause  % ----------------------------------------------------------------
   
	% Rita amplitud- och faskaraktäristiken, |H2(f)| resp arg H2(f)
   % Ett hyfsat bra lågpassfilter (av ordning 4 = antalet poler)
	% med gränsfrekvens 1 Hz!
spect(H2,6)
	OHfig

	pause  % ----------------------------------------------------------------
   
	% Rita logaritmisk amplitudkaraktäristik, 20*log |H2(f)| i två varianter
logspect(H2,6)
	OHfig

	pause  % ----------------------------------------------------------------
	clc	
   
   % Butterworthfilter (LP) av ordning 4, med gränsfrekvens 1 Hz:
Hb=butterw(4);

	% Butterworthfiltrets pol-nollställediagram:
pz(Hb)
	OHfig

	pause  % ----------------------------------------------------------------

	% Jämför amplitudspektra |H2(f)| och |Hb|:   
spect(H2,Hb,6)   
subplot(2,1,1), title('{\it |H2(f)|}  (det modifierade filtret)'), xlabel('')
subplot(2,1,2), title('{\it |Hb(f)|}  (Butterworthfiltret)')
	OHfig
   
	pause  % ----------------------------------------------------------------
	clc   
   
	% Filtertransformera Butterworthfiltret - LP med gränsfrekvens 5 Hz:
	% Erhålles genom att flytta ut polerna till avståndet 2pi*5 från origo!
Hlp5=lplp(Hb,5);

	% Filtertransformera Butterworthfiltret - HP med gränsfrekvens 3 Hz:
Hhp3=lphp(Hb,3);

spect(Hlp5,Hhp3,8)
	OHfig
   
	pause  % ----------------------------------------------------------------
 
	% Pol-nollställediagram HP-filtret med gränsfrekvens 3 Hz:
pz(Hhp3)
	OHfig
   
   pause  % ----------------------------------------------------------------
   
   % 3D-plot av det första Butterworthfiltrets amplitudkaraktäristik
	% i ett område i vänstra halvplanet:
splane(Hb)
   
   pause  % ----------------------------------------------------------------
	clc
   
	% Justera polernas läge hos Butterworthfiltret
	% så att högre branthet i övergångsbandet erhålls!
	% Flytta t.ex. polerna till -1,29 +/- 2,46j och -0,53 +/- 5,95j
	% Amplitudnormering skall fortfarande gälla!
	% Då erhålls ett Chebychevfilter av ordning 4.
   
	% Använd Kretslabfunktionen pzchange !!
	% ---------------------------------------------------------
   
pzchange(Hb)



% ANM:   
% Om inte Kretslabfunktionen ilaptr (inverstransformering) fungerar
% (se text om begränsningar i Kretslabmanualen),
% så kan man själv gå över till fouriertransformen 
% för att sedan inversfouriertransformera:

global TRFM, figure(4), signal( ifoutr( output( TRFM, in('1','f') ))), OHfig

   
   
   