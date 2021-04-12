%{
    Reverb com filtro comb.
    x = Sinal de entrada.
    d = Vetor de delays para cada filtro comb (4 filtros).
    y5 = Saída sem os filtros passa-tudo.
    y = Saída com os filtros passa-tudo.
%}

function [y6,y] = reverb(x,d,fs)

t = 5000;
f = [0.2 0.1 0.2 0.1];    % Feedback, controla o quanto do sinal atrasado é incluído na efeito.

% 4 filtros comb em paralelo.
y1 = eco(x,d(1),t,f(1),fs,'iir');
y2 = eco(x,d(2),t,f(2),fs,'iir');
y3 = eco(x,d(3),t,f(3),fs,'iir');
y4 = eco(x,d(4),t,f(4),fs,'iir');

y5 = 1/4*(y1+y2+y3+y4);

f_d = [50 40]; % Atraso dos filtros passa-tudo.
f_d = (f_d/1000)*fs;

% Filtros passa-tudo.
y6 = zeros(1,length(y5));
y6(1:f_d(1)) =  y5(1:f_d(1));

for n = f_d(1)+1:length(y5)
    y6(n) = 0.2*y6(n-(f_d(1))) - 0.2*y5(n) + 1*y5(n-(f_d(1)));
endfor

y = zeros(1,length(y6));
y(1:f_d(2)) =  y6(1:f_d(2));

for n = f_d(2)+1:length(y6)
    y(n) = 0.2*y(n-(f_d(2))) - 0.2*y6(n) + y6(n-(f_d(2)));
endfor
    
endfunction
