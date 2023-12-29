function setlen(L)
%setlen
% setlen används lokalt av Kretslab

global pm1 pm2 pm3 pm4 KlabL
LL=[256 512 1024];
if L>1024, L=1024; end
a=find(LL>=L);
KlabL=LL(a(1));
disp(['Vector length ' num2str(KlabL)])
