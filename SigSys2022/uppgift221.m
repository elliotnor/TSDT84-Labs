Y = remtone(X, 'lp', M);    % Den lågpassfiltrerade signalen y(t).
Z = remtone(X, 'hp', M+1);  % Det som filtreras bort, dvs. z(t)=x(t)–y(t),
                            % som är en högpassfiltrerad x(t)
figure(221)
signal(Y, Z);
    subplot(2, 1, 1); 
    title(['{\it M} = ' int2str(M) '    \Rightarrow   Lågpassfiltrerad signal y(t)']);
    subplot(2, 1, 2); 
    title(['{\it M} = ' int2str(M) '  \Rightarrow  z(t) = bortfiltrerad signaldel hos x(t)']); 
ohfig
    

figure(222)
spect(Y, Z); 
    subplot(2, 1, 1); 
    title(['{\it M} = ' int2str(M) '    \Rightarrow   Amplitudspektrum för y(t)']); 
    ylabel('')

    subplot(2, 1, 2); 
    title(['{\it M} = ' int2str(M) '    \Rightarrow   Amplitudspektrum för z(t)']); 
    ylabel('')
    
ohfig