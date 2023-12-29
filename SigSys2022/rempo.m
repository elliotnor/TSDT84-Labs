function H=rempo(G,pole)
%REMPO Tar bort poler från laplace- eller z-transformer.
%
%    Y = REMPO(X,[p1 p2...pn]) - X är laplace- eller z-transform, 
%                              p1...pn är komplexa tal.
%    
%    Beskrivning:
%    Polerna p1...pn tas bort från X. För varje komplexvärt p1...pn 
%    tas även motsvarande komplexkonjugerade pol bort automatiskt.
%    
%    See also:
%    IN, ADDZE, ADDPO, REMZE, PO, ZE, PZ, COEFF
%    

global pm1 pm2 pm3 pm4 KlabL
H=addze(G,pole);


