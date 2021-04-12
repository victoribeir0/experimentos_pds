%{
    ** Eco com filtro comb (IIR) **
    x = Sinal de entrada.
    d = Atraso (em amstras).
    t = Tempo de decaímento (em amostras).
    f = Feedback, controla o quanto do sinal atrasado é incluído na efeito.
    y = Sinal de saída com eco.
%}

function y = eco(x,d,t,f,fs,comb)

d = d/1000;  % Atrasos em ms.
d = round(d*fs); % Converte para amostras.
t = t/1000;
t = round(t*fs);

N = length(x);    % Dimensão do sinal.
y = zeros(1,N+t); % Sinal de saida com eco.

% Sinal x de entrada 'crescido', para ficar do mesmo tamanho da saída e evitar problemas no laço for.
xx = zeros(1,N+t);
xx(1:N) = x;

% A parte inicial do sinal de saída é igual a entrada, o eco começa a partir de d.
y(1:d) = x(1:d);

if strcmp(comb,'iir')
    % Filtro comb, indo até o número de amostras de atraso.
    for n = d+1:N+t
        y(n) = xx(n) + f*y(n-(d));
    endfor
    
else
    % Filtro comb, indo até o número de amostras de atraso.
    for n = d+1:N
        y(n) = x(n) + f*x(n-(d));
    endfor
    
endif

endfunction
