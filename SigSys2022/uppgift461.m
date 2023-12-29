load dtmf.mat;
try
    load Uppgift45
    disp('BP-filtret och ''toner'' är hämtade!')
    X = foutr(toner);
    Y = output(X, H_BP);
    y = ifoutr(Y);
catch
    disp('Tyvärr, du har inte sparat något BP-filter än.')
end