Y = remtone(X, 'lp', M);  % Lågpassfiltrera signalen  => y(t)

Px = pwr(X);     % Signalmedeleffekten för x(t) 
Py = pwr(Y);     % Signalmedeleffekten för y(t)

disp('Signalmedeleffekten Px för insignalen x(t):')
fprintf("<strong> Px = %12.4f </strong>", Px);

fprintf("\n \n")
disp('Signalmedeleffekten Py för den')
disp('lågpassfiltrerade signalen y(t):')
%fprintf("\n")
fprintf("<strong> Py = %12.4f </strong>", Py);

fprintf("\n \n")
disp(' ')
disp(' ')

disp('Insignalen och den lågpassfiltrerade signalen:')
fprintf("\n")

figure(211)
signal(X,Y);
subplot(2, 1, 1); title('Insignalen x(t)');
subplot(2, 1, 2); title(['{\it M} = ' int2str(M) '    \Rightarrow   Lågpassfiltrerad signal y(t)']); ohfig

disp(' ')
disp('Enkelsidigt amplitudspektrum')
disp('för motsvarande signaler:')
disp(' ')

figure(212)
spect(X, Y);
subplot(2, 1, 1); title('Amplitudspektrum för x(t)'); ylabel('')
subplot(2, 1, 2); title(['{\it M} = ' int2str(M) '    \Rightarrow   Amplitudspektrum för y(t)']); ylabel(''), ohfig

