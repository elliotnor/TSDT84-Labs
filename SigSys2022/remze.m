function H=remze(G,zero)
%REMZE Tar bort nollställen från laplace- eller z-transformer.
%
%    Y = REMZE(X,[z1 z2...zn]) - X är laplace- eller z-transform, 
%                              z1...zn är komplexa tal.
%    
%    Beskrivning:
%    Nollställena z1...zn tas bort från X. För varje komplexvärt z1...zn 
%    tas även motsvarande komplexkonjugerade nollställe bort automatiskt. 
%    
%    See also:
%    IN, ADDZE, ADDPO, REMPO, PO, ZE, PZ, COEFF
%    

global pm1 pm2 pm3 pm4 KlabL
H=addpo(G,zero);

