function ty=vtype(x)
%VTYPE Anger variabeltyp.
%
%    ty = VTYPE(x)
%    
%    Beskrivning:
%    Används av Kretslabfunktioner för att bestämma aktuell
%    variabeltyp:
%    	
%    VTYPE(x) =  = 1  = > Tal eller annan Matlab-variabel
%    VTYPE(x) =  = 2  = > Vektor
%    VTYPE(x) =  = 3  = > Matris
%    VTYPE(x) =  = 4  = > Tidskontinuerlig signal
%    VTYPE(x) =  = 5  = > Fouriertransform av tidskontinuerlig signal
%    VTYPE(x) =  = 6  = > Laplacetransform
%    VTYPE(x) =  = 7  = > Fourierserie
%    VTYPE(x) =  = 8  = > Tidsdiskret signal
%    VTYPE(x) =  = 9  = > Fouriertransform av tidsdiskret signal
%    VTYPE(x) =  = 10  = > z-transform
%    VTYPE(x) =  = 11  = > DFT
%    Annars  = > Annan Matlabvariabel
%    
%    See also: VARTYPE
%
%              OBS!! I HJÄLPTEXTEN TILL FUNKTIONEN VARTYPE STÅR 
%                    NOGGRANNARE BESKRIVNING OM HUR DE OLIKA 
%                    KRETSLABVARIABLERNA REPRESENTERAS!!

global pm1 pm2 pm3 pm4 KlabL
[r,c]=size(x);
if r==1 & c==1,
 ty=1;
elseif r==1 & c==129,
 ty=11;
elseif r==1 & c==515,
 ty=7;
elseif r==1 & c==KlabL,
 ty=9;
elseif r==1 & c==KlabL+1,
 ty=4;
elseif r==1 & c==KlabL+2,
 ty=5;
elseif r==1 & c==KlabL+4,
 ty=8;
elseif r==1,
 ty=2;
elseif r==2 & x(1,1)==6,
 ty=6;
elseif r==2 & x(1,1)==10,
 ty=10;
else
 ty=3;
end
