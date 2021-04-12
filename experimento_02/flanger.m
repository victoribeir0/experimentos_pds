%{
  Flanger com filtro comb.
  x = sinal de entrada.
  fs = Freq. de amostragem.  
  f_lfo = freq. do LFO que controla o atraso variante no tempo.
  atraso = Determina o range de atraso (ideal para flanger: 2-8 ms).
%}

function y = flanger(x,fs,f_lfo,atraso)

N = length(x);  % Dimensão do sinal.
y = zeros(1,N); % Sinal de saida com flanger.

t = 0:1/fs:(N/fs);
d = cos(2*pi*f_lfo*t); % Função senoidal para o atraso.
d = (d+1)./2;          % Normaliza entre 0 e 1.
d = d*atraso;          % Normaliza entre 0 e o atraso.
d = (d/1000)*fs;       % Converte em amostras.
inicio = round(d(1));  % Guarda o valor inicial.

% A parte inicial do sinal de saída é igual a entrada.
y(1:inicio) = x(1:inicio);

for n = inicio+1:N
    atraso = round(d(n));    
    y(n) = 0.7*y(n-atraso) + 0.7*x(n) + 0.7*x(n-atraso);
endfor

endfunction
