function txSigFOFDM=modFOFDM(inputData,numFFT,cpLen,nullIdx)

toneOffset = 2.5;        % Tone offset en subcarriers
L = 513;                 % Tamaño del filtro 
halfFilt = floor(L/2);
n = -halfFilt:halfFilt;

%CREAMOS EL FILTRO PROTOTIPO DE TX
pb = sinc((numel(inputData)+2*toneOffset).*n./numFFT);
w = (0.5*(1+cos(2*pi.*n/(L-1)))).^0.6;
fnum = (pb.*w)/sum(pb.*w);
filtTx = dsp.FIRFilter('Structure', 'Direct form symmetric', ...
    'Numerator', fnum);

%MODULAMOS EN OFDM LOS DATOS DE ENTRADA
txSigOFDM = ofdmmod(inputData,numFFT,cpLen,nullIdx);

%FILTRAMOS LA SEÑAL MODULADA OFDM CON EL FILTRO PROTOTIPO CON PADDING DE
%CEROS PARA LA COLA DEL FILTRO
txSigFOFDM = filtTx([txSigOFDM; zeros(L-1,1)]);

% % Plot (PSD) para señal F-OFDM
% [psd,f] = periodogram(txSigFOFDM, rectwin(length(txSigFOFDM)), numFFT*2, ...
%     1, 'centered');
% figure(2)
% plot(f,10*log10(psd));
% grid on
% axis([-0.5 0.5 -200 -20]);
% xlabel('Normalized frequency');
% ylabel('PSD (dBW/Hz)')
% title(['F-OFDM, ' num2str(numFFT-numel(nullIdx)) ' Subcarriers'])
end