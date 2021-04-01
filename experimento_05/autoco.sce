/*
    Calcula a autocorrelação do sinal x em janelas e determina o f0 (estimado) para cada janela.
    x = Sinal de entrada.
    Njan = Núm. de amostras em cada janela.    
    f0 = Freq. fundamental para cada janela analisada.    
*/

function f0 = autoco(x, Tjan, fs)
x = x(1,:); // Evita que seja anlisado os dois canais de áudio.
Njan = round((Tjan/1000)*fs); // Num. de amostras em cada janela.
NAv = round((10/1000)*fs);    // Num. de amostras para o avanço (sobreposição).
Tam = round((length(x)-Njan)/NAv); // Num. total de janelas.
R = zeros(Tam,round(Njan/3)); // Inicialização da matriz de autocorrelaçao.
j = 1;
ji = 1;

for i = 1:NAv  // Laço for para cada janela.
    ap = ((i-1)*NAv)+1; 
    
    for m = 1:round(Njan/3) // Laço for para cada varrer dentro da janela.
        
        // Caso esteja na última janela, o alg. não pode mais calcular a autoco.
        if (ap+Njan-1)+m-1 <= length(x)
                        
            a = x(ap:ap+Njan-1); // Seleciona o segmento do sinal.
            b = x((ap:ap+Njan-1)+m-1);
            a = a-mean(a); // Remove o nível DC subtraindo pela média.
            b = b-mean(b);
                        
            R(i,m) = mean(a.*b); // Calcula a autocorrelação:
        end        
    end
end

ind_skip = 20; // Variável onde começa a valer para encontrar o máx.
[m,k_0] = max(R(:,ind_skip:$),'c');

/*
    Devido o calculo do máximo (passo anterior) ser feito a partir do índice
    20, os valores de max_pos devem ser somados a ind_skip-1, para voltar para
    os valores de origem.
*/
k_0 = k_0 + (ind_skip-1);
k_0 = fs./k_0; // Para obter a freq. em Hz divide Fs/max_pos.
k_0 = k_0(k_0 <= 500); //Matem somente os menos que 500 Hz.

mdn = median(k_0);
range_med = 15; // Valor em que a mediana pode variar (para mais ou para menos).

// Obtém os índices em que k0 que não estão distantes da mediana.
idx_n = find(k_0 <= mdn+range_med & k_0 >= mdn-range_med);
f0 = k_0(idx_n); // Atualiza os k0 (descarta os que estão distantes de mediana).

endfunction
