clear
clc

Fs = 640;                       % Frequ�ncia de amostragem
tempo = 60;                     % Tempo total de dura��o do sinal
L = 4;                          % Dura��o de cada janela (em segundos)
n_janelas = tempo/L;            % N�mero total de janelas
total_amostras = L*Fs;          % Total de amostras por janela
load('s0010_rem.mat');          % Leitura do sinal da base de dados
pulse_total = val(1, :);        % Seleciona o primeiro canal do sinal da base de dados

figure('units','normalized','outerposition',[0 0 1 1]);         % Maximiza a figura
subplot(1,2,1)
N_total = tempo*Fs;
y_total = fft(pulse_total);                                     % C�lculo da DFT
shift_y_total = fftshift(y_total);                              % Desloca o sinal no dom�nio da frequ�ncia  
g_total = -Fs/2:(Fs/N_total):Fs/2-(Fs/N_total);                 % Cria vetor de frequ�ncias
plot(g_total, abs(shift_y_total).^2, 'm');
xlabel('Frequ�ncia em Hertz')
ylabel('Amplitude')
title('Espectro do sinal considerando todas as amostras')

for n = 1:n_janelas        
    
    
    pulse = val(1, (n-1)*total_amostras + 1:n*total_amostras); 
    
    % C�lculo da DFT
    N = total_amostras;
    y = fft(pulse);                                     % C�lculo da DFT
    shift_y = fftshift(y);                              % Desloca o sinal no dom�nio da frequ�ncia  
    g = -Fs/2:(Fs/N):Fs/2-(Fs/N);                       % Cria vetor de frequ�ncias
    subplot(1,2,2)
    h = plot(g, abs(shift_y).^2, 'b');
    xlabel('Frequ�ncia em Hertz')
    ylabel('Amplitude')
    title('Espectro de cada janela')
    
    refreshdata(h, 'caller')                            % Atualiza plot
    drawnow; pause(.5)
end;