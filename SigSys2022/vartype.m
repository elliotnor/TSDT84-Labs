function vartype(x)
%VARTYPE Anger variabeltyp.
%
%    VARTYPE(x) - x är godtycklig Kretslabvariabel.
%    
%    Beskrivning:
%    Funktionen vartype skriver i kommandofönstret ut vilken typ av
%    kretslabvariabel x är. Variabeltypen erhålls från funktionen 
%    vtype enligt följande:
%    vtype(x) =  = 1  = > 'Tal eller annan Matlab-variabel'
%    vtype(x) =  = 2  = > 'Vektor'
%    vtype(x) =  = 3  = > 'Matris'
%    vtype(x) =  = 4  = > 'Tidskontinuerlig signal'
%    vtype(x) =  = 5  = > 'Fouriertransform av tidskontinuerlig signal'
%    vtype(x) =  = 6  = > 'Laplacetransform'
%    vtype(x) =  = 7  = > 'Fourierserie'
%    vtype(x) =  = 8  = > 'Tidsdiskret signal'
%    vtype(x) =  = 9  = > 'Fouriertransform av tidsdiskret signal'
%    vtype(x) =  = 10  = > 'z-transform'
%    vtype(x) =  = 11  = > 'DFT'
%    Annars  = > 'Annan Matlabvariabel'
%     
%    See also:
%    VTYPE
%    
%    ######################################################
%    
%    KRETSLABS VARIABELTYPER
%    -----------------------
%    
%    Nedan följer en beskrivning av hur Kretslab lagrar signaler och 
%    transformer. Numret på variabeltypen är detsamma som returneras
%    av funktionen vtype.
%    
%    1. Tal
%    -------
%    Format (rader x kolumner): 1x1
%    Beskrivning: Alla tal, reella eller komplexa.
%    Kontrollsymboler: Inga.
%    
%    2. Vektor
%    ----------
%    Format (rader x kolumner): 1xn
%    Beskrivning: Alla radvektorer som inte tolkas som någon annan variabeltyp.
%    Kontrollsymboler: Inga.
%    
%    3. Matris
%    ----------
%    Format (rader x kolumner): nxm
%    Beskrivning: Alla matriser av godtycklig dimension som inte tolkas 
%                 som någon annan variabeltyp.
%    Kontrollsymboler: Inga.
%    
%    4. Tidskontinuerlig signal
%    ---------------------------
%    Format (rader x kolumner): lx(KlabL+1)
%    Beskrivning: Element #1-KlabL är signalvärden i tidsföljd. 
%                 Element #(KlabL/2)+1 motsvarar tidpunkten t = 0.
%    Kontrollsymboler: Element #KlabL+1 ger sampelperioden, dvs tidsavståndet 
%                      mellan varje värde.
%    
%    5. Fouriertransform av tidskontinuerlig signal
%    -----------------------------------------------
%    Format (rader x kolumner): 1x(KlabL+2)
%    Beskrivning: Element #1->KlabL är transformens värden för frekvenser 
%                 mellan -fs/2 och fs/2, där fs är sampelfrekvensen. 
%                 De första 512 elementen är transformens värden för 
%                 positiva frekvenser och element #KlabL/2+1->KlabL är värden 
%                 för negativa frekvenser. Element #1 motsvarar f = 0.
%    Kontrollsymboler: Element #KlabL+1 ger sampelfrekvensen.
%                      Element #KlabL+2 ger frekvensavståndet mellan varje värde.
%    
%    6. Laplacetransform
%    --------------------
%    Format (rader x kolumner): 2xn
%    Beskrivning: De första tre elementen i varje rad är kontrollsymboler. 
%                 Därefter innehåller rad 1 nollställen och rad 2 poler. 
%                 Om antalen är olika fylls den kortare raden ut med nollor 
%                 i slutet.
%    Kontrollsymboler: 
%      Element #(1,1) = 6 ger typnumret (för att skilja på laplace- och z-transform).
%      Element #(1,2) ger antal nollställen.
%      Element #(1,3) ger koefficienten för täljarens högstagradsterm.
%      Element #(2,1) används inte.
%      Element #(2,2) ger antal poler.
%      Element #(2,3) ger koefficienten för nämnarens högstagradsterm.
%    
%    7. Fourierserie
%    ----------------
%    Format (rader x kolumner): 1x515
%    Beskrivning: De första 512 elementen är de komplexa fourierkoefficienterna. 
%                 Element #1-256 motsvarar c_0->c_255 och element #257-512 
%                 motsvarar c_(-256)->c_(-1).
%    Kontrollsymboler: Element #513 ger signalens grundfrekvens, dvs 1/T.
%                      Element #514 och #515 används inte.
%    
%    8. Tidsdiskret signal
%    ----------------------
%    Format (rader x kolumner): 1x(KlabL+4)
%    Beskrivning: Element #1-KlabL är signalvärden i nummerföljd. 
%                 Element #KlabL/2+1 motsvarar punkten n = 0.
%    Kontrollsymboler: Element #KlabL+1 -> KlabL+4 används inte.
%    
%    9. Fouriertransform av tidsdiskret signal
%    ------------------------------------------
%    Format (rader x kolumner): 1xKlabL
%    Beskrivning: Element #1-KlabL är transformens värden for normerade 
%                 frekvenser mellan 0 och 1. Element #1 motsvarar theta = 0 
%                 och 1023 element #KlabL motsvarar theta = 1023/1024.
%    Kontrollsymboler: Inga.
%    
%    10. z-transform
%    ----------------
%    Format (rader x kolumner): 2xn
%    Beskrivning: De första tre elementen i varje rad är kontrollsymboler. 
%                 Därefter innehåller rad 1 nollställen och rad 2 poler. 
%                 Om antalen är olika fylls den kortare raden ut med nollor i slutet.
%    Kontrollsymboler: 
%      Element #(1,1)  =  10 ger typnumret (för att skilja på laplace- och z-transform).
%      Element #(1,2) ger antal nollställen.
%      Element #(1,3) ger koefficienten for täljarens högstagradsterm.
%      Element #(2,1) används inte.
%      Element #(2,2) ger antal poler.
%      Element #(2,3) ger koefficienten for nämnarens högstagradsterm.
%    
%    11. DFT
%    --------
%    Format (rader x kolumner): 1x129
%    Beskrivning: Element #1-L är DFT:ns värden för k mellan 0 och L-1,
%    	         där L är DFT:ns längd. Om DFT:n är kortare än 128 punkter 
%    	         fylls vektorn ut med nollor.
%    Kontrollsymboler: Element #129 ger DFT:ns längd L.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==1,
 disp('Tal eller annan Matlab-variabel')
elseif vtype(x)==2,
 disp('Vektor')
elseif vtype(x)==3,
 disp('Matris')
elseif vtype(x)==4,
 disp('Tidskontinuerlig signal')
elseif vtype(x)==5,
 disp('Fouriertransform av tidskontinuerlig signal')
elseif vtype(x)==6,
 disp('Laplacetransform')
elseif vtype(x)==7,
 disp('Fourierserie')
elseif vtype(x)==8,
 disp('Tidsdiskret signal')
elseif vtype(x)==9,
 disp('Fouriertransform av tidsdiskret signal')
elseif vtype(x)==10,
 disp('z-transform')
elseif vtype(x)==11,
 disp('DFT')
else
 disp('Annan Matlabvariabel')
end
