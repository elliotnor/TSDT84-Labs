n = -5:19;   % Anm: I boken står det (0:19), men från -5 är lämpligare
x = inline('n==0');     % = enhetsimpulsen
a = [1 -0.6 -0.16]; b = [5 0 0];
h = filter(b,a,x(n));
clf; stem(n,h,'k'); xlabel('n'); ylabel('h[n]');
