// Eco com filtro comb.
// x = Sinal de entrada.
// d = Atraso (em amstras).
// t = Tempo de decaímento (em amostras).
// y = Sinal de saída com eco.
// f = Feedback, controla o quanto do sinal atrasado é incluído na efeito.

function y = eco(x,d,t,f)
    
    N = length(x);    // Dimensão do sinal.
    y = zeros(1,N+t); // Sinal de saida com eco.
    
    // Sinal x de entrada 'crescido', para ficar do mesmo tamanho da saída e evitar problemas no laço for.
    xx = zeros(1,N+t); 
    xx(1:N) = x; 
    
    // A parte inicial do sinal de saída é igual a entrada, o eco começa a partir de d.
    y(1:d) = x(1:d); 
    
    // Filtro comb, indo até o número de amostras de atraso.
    for n = d:N+t               
        y(n) = xx(n) + f*y(n-(d-1));
    end

endfunction
