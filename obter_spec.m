%{
  Determina o espectrograma de um sinal x.
  Fs = Frequênicia de amostragem.
  Tjan = Tempo da janela em ms.
  Tav = tempo de avanço em ms.
  
  S = Matriz de espectrograma, MxN, M = Tjan, N = Num. jan.
  
%}

function S = obter_spec(x,Fs,Tjan,Tav)
  Tjan = round(Fs*(Tjan/1000));
  Tav = round(Fs*(Tav/1000));
  N = length(x);
  Num_jan = floor((N-Tjan)/Tav);
  
  S = zeros(Tjan,Num_jan);
  
  W = exp(-sqrt(-1)*2*pi/Tjan);
  F = zeros(Tjan,Tjan);
  
  for k = 1:Tjan
    F(k,:) = W.^((k-1)*[0:Tjan-1]);
  endfor
  
  S(:,1) = F*x(1:Tjan);
  S(:,2) = F*x(Tav:Tjan+Tav-1);
  S(:,3) = F*x(Tav*2:Tjan+(Tav*2)-1);
  
  for col = 1:Num_jan
    S(:,col) = abs(F*x(Tav*(col-1)+1:Tjan+(Tav*(col-1))));
  endfor
  
  imagesc(S); title('Espectrograma do sinal x'); xlabel('Tempo (amostras)'); ylabel('Frequência (Hz)');
  
  endfunction
