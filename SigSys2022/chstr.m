function sut=chstr(str,var)
% chstr
% chstr, som används av funktionen in, lägger till '.'
% före alla '^', '*' och '/', i textsträngen som
% definierar den inmatade funktionen.
%
v = char(str);
for k = fliplr(find((v=='^') | (v=='*') | (v=='/')))
   v = [v(1:k-1) ' .' v(k:end)];
end
sut=['(' v ').*ones(size(' var '))'];

