% KRETSLAB - SAMMANFATTANDE FUNKTIONSBESKRIVNING
% -----------------------------------------------
% 
% Nedanstående funktioner är i de flesta fall Kretslabfunktioner,
% men kan i en del fall vara normala Matlabfunktioner (speciellt 
% funktionerna under rubriken "Elementära matematiska funktioner").
%
% Skriv "helpwin funktionsnamn" för att erhålla hjälptexten till 
% funktionen  "funktionsnamn" i Matlabs hjälpnavigerare!
% Motsvarande hjälptext erhålls i kommandofönstret om du i stället
% skriver "help funktionsnamn".
% 
% Skriv "which funktionsnamn" om du vill veta vilken funktion 
% Matlab använder sig av om/när du anropar "funktionsnamn".
% 
% Allmänna funktioner
% -------------------
% kretslab        - Visar denna hjälptext för Kretslab i Matlabs hjälpnavigerare!
% startup         - Initierar Kretslab. Anropas när Matlab startar.
% help            - help fknsnamn returnerar hjälptext fill funktionen fknsnamn.
% helpwin         - Startar ett mer sofistikerat hjälpfönster med sökfunktion.
%                   Skriv t.ex. "helpwin kretslab" !!!!!
% who             - (alt. whos) listar vilka variabler som är definierade.
% clear           - clear x tar bort variabeln x.
% cleanup         - Kompakterar minnet. OBS: använd inte pack
% vartype         - vartype(x) anger vilken typ av variabel x är. 
% vtype           - vtype(x) ger typkoden får variabeln x.
% save            - save fil x sparar variabeln x på filen fil.mat 
% load            - load fil hämtar variabler från filen fil.mat 
% shg             - Visar grafiska fönstret.
% quit            - Avslutar Matlab.
% editpath        - Används för att definiera och ändra Matlabs sökväg.
% ;               - Skrivs efter funktionsanrop, för att förhindra resultatutskrift.
% <ctrl>+<c>      - Avbryter pågående kommando eller utskrift.
% 
% 
% Elementära matematiska funktioner
% ----------------------------------
% Konstanter:
% j               - Kvadratroten ur -1
% pi              - pi
% 
% Funktioner:
% ^               - Exponentiering. Ex: 2^5 = 32 
% sqrt            - Kvadratroten
% sin             - sinus
% cos             - cosinus
% tan             - tangens
% asin            - arcussinus
% acos            - arcuscosinus
% atan            - arcustangens
% sinh            - sinus hyperbolicus
% cosh            - cosinus hyperbolicus
% tanh            - tangenshyperbolicus
% exp             - e^t; basen e till den naturliga logaritmen
% log             - den naturliga logaritmen; ln(t)
% log10           - 10-logaritmen
% sinc            - sinc-functionen; sinc(t) = sin(pi*t)/(pi*t)
% us              - Heavisidefunktionen u(t)
% pulse           - pulse(t,t1,t2) = u(t-t1)-u(t-t2) 
%                   (kan naturligtvis även matas in som us(t-t1)-us(t-t2) )
% pulse2          - Specialgenerering av pulsfunktionen u(t-t1)-u(t-t2)
% ramp            - Rampfunktionen ramp(t,t1,t2)=((t-t1)/(t2-t1))*(u(t-t1)-u(t-t2))
% dimp            - Specialgenerering av dirac-impuls
% sign            - sign(t) = signum av t (= -1, 0 eller 1).
% abs             - Absolutbelopp; abs(t) = |t|
% angle           - Argumentet, dvs. fasvinkeln arg{t}
% real            - Realdelen Re{t}
% imag            - Imaginärdelen Im{t}
% conj            - Komplexkonjugatet t*
% max             - max(a,b) motsvarar max{a,b}
% min             - min(a,b) motsvarar min{a,b}
% round           - Avrundning till närmaste heltal.
% floor           - Avrundning till närmaste lägre heltal.
% ceil            - Avrundning till närmaste högre heltal.
% 
% 
% Ritfunktioner
% --------------
% signal         - Ritar signaler.
%                  OBS! Om du klickar på 'signal' här till vänster, kommer
%                  funktionens hjälptext att i hjälpnavigatorn skrivas ut 
%                  längst ned på den erhållna sidan!
% signalmod      - Variant av signal. Används för egendefinierade utskrifter.
% spect          - Ritar frekvensspektrum/-karaktäristik.
% spectmod       - Variant av spect. Används för egendefinierade utskrifter.
% logspect       - Ritar frekvensspektrum/-karaktäristik i logaritmisk skala.
% logspectmod    - Variant av logspect. Används för egendefinierade utskrifter.
% pwrspect       - Ritar energispektrum.
% pz             - Ritar pol-nollställediagram.
% pzmod          - Variant av pz. Används för egendefinierade utskrifter.
% splane         - Ritar beloppet av en laplacetransform i s-planet.
% zplane         - Ritar beloppet av en z-transform i z-planet.
% pzchange       - Ritar pol-nollställediagram och frekvensspektrum/-karaktäristik
%                - samt möjliggör interaktiv justering av poler och nollställen.
% ohfig          - Ökar textstorlek och linjetjocklek i senast ritade fönster
%                  (ger tydligare figurer vid utskrift m.m.)
% 
% 
% Inmatning
% ----------
% in             - Definierar signaler eller transformer.
% sample         - Samplar signaler.
% fouser         - Definierar fourierserier.
% fir            - Definierar FIR-filter.
% pzchange       - Interaktiv inmatning av poler och nollställen till laplace-
%                  och z-transform. Ritar samtidigt pol-nollställediagram och 
%                  frekvensspektrum/-karaktäristik.
% 
% Signaler
% ---------
% add            - Adderar signaler.
% mult           - Multiplicerar signaler.
% deriv          - Deriverar signaler.
% integr         - Integrerar signaler.
% pam            - Pulsamplitudmodulerar tidsdiskreta signaler.
% delay          - Fördröjer (skiftar) signaler.
% window         - Fönstrar signaler.
% part           - Tar ut delar av signaler.
% pwr            - Beräknar energin (alt. signalmedeleffekt) hos signaler.
% noise          - Adderar brus till signaler.
% output         - Faltar signaler/funktioner.
% ampl           - Förstärker signaler.
% value          - Ger amplitud vid viss tidpunkt.
% lp             - Ideal lågpassfiltrering av signal.
% hp             - Ideal högpassfiltrering av signal.
% bp             - Ideal bandpassfiltrering av signal.
% bs             - Ideal bandspärrfiltrering av signal.
% 
% 
% Fourierserier
% --------------
% output         - Filtrerar signaler.
% addtone        - Adderar deltoner.
% remtone        - Tar bort deltoner.
% thd            - Beräknar klirrfaktor (distorsion), signalmedeleffekt, 
%                  RMS-värde och likriktat medelvärde.
% value          - Ger amplitud och fas för deltoner.
% 
% 
% Transformer
% ------------
% foutr          - Fouriertransformerar signaler.
% ifoutr         - Inverstransformerar fouriertransformer.
% ilaptr         - Inverstransformerar laplacetransformer.
% iztr           - Inverstransformerar z-transformer.
% dft8           - 8 punkters DFT.
% dft16          - 16 punkters DFT.
% dft32          - 32 punkters DFT.
% dft64          - 64 punkters DFT.
% dft128         - 128 punkters DFT.
% value          - Ger amplitud och fas i viss frekvens.
% output         - Filtrerar i frekvensplanet.
% trfcn          - Beräknar frekvensfunktioner (transfer function).
% addpo          - Adderar poler.
% addze          - Adderar nollställen.
% rempo          - Tar bort poler.
% remze          - Tar bort nollställen.
% po             - Ger polplacering.
% ze             - Ger nollställeplacering.
% coeff          - Ger täljar- och nämnarpolynomskoefficienterna.
% normal         - Amplitudnormerar filter.
% ampl           - Multiplicerar med konstant.
% feedb          - Återkopplar system.
% pzchange       - Se under rubrikerna Ritfunktioner och Inmatning
% 
% 
% Filterdesign
% -------------
% lplp           - LP->LP-transformation.
% lphp           - LP->HP-transformation.
% butterw        - Beräknar butterworthfilter.
% firwin         - Beräknar FIR-filter med fönstermetoden.
% firopt         - Beräknar FIR-filter med Remez algoritm.
% firlen         - Ger en uppskattning av längden på ett optimalt 
%                  FIR-filter enligt Remez algoritm.
% ripple         - Beräknar designkonstant för Remez algoritm.
% firztr         - Beräknar systemfunktioner för FIR-filter.
% bilintr        - Bilinjär transformation.
% pzchange       - Se under rubrikerna Ritfunktioner och Inmatning
% 
% 
% Övrigt
% -------
% dd1            - Demonstration av Kretslabfunktioner för tidskontinuerliga
%                  signaler och system. Tryck på valfri tangent för att stega  
%                  dig igenom demonstrationsfilen! 
%                  KÖR DD1 FÖR ATT SE HUR KRETSLAB ANVÄNDS!!
% dd2            - Demonstration av Kretslabfunktioner för tidsdiskreta
%                  signaler och system. Tryck på valfri tangent för att stega  
%                  dig igenom demonstrationsfilen!
%                  KÖR DD2 FÖR ATT SE HUR KRETSLAB ANVÄNDS!!
% kretsdemo1     - Demonstrationsverktyg för den tidskontinuerliga kursdelen.
%                  Några av demo-filerna fungerar dock bara tillsammans med andra
%                  Matlabfunktioner (som examinatorn har).
% kretsdemo2     - Demonstrationsverktyg för den tidsdiskreta kursdelen.
% vikex          - Demonstration av vikningseffekter vid sampling.
%            
% ------------------------------------------------------------------------
%
% OBS!!  Om du fick ovanstående text presenterad i kommandofönstret,
% rekommenderas du att i stället läsa hjältexten i Matlabs hjälpnavigerare!
% Skriv då "kretslab", så startas den!
%
% ------------------------------------------------------------------------
%