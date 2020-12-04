function rxSigFOFDM=demodFOFDM(inputData,numFFT,cpLen,nullIdx,symOffset,eqH,numDataCarriers)

toneOffset = 2.5;        % Tone offset en subcarriers
L = 513;                 % Tamaño del filtro 
halfFilt = floor(L/2);
n = -halfFilt:halfFilt;

%CREAMOS EL FILTRO PROTOTIPO DE TX
pb = sinc((numDataCarriers+2*toneOffset).*n./numFFT);
w = (0.5*(1+cos(2*pi.*n/(L-1)))).^0.6;
fnum = (pb.*w)/sum(pb.*w);
filtRx = dsp.FIRFilter('Structure', 'Direct form symmetric', ...
    'Numerator', fnum);

% Receive matched filter
rxSigFilt = filtRx(inputData);

% Account for filter delay
rxSigFiltSync = rxSigFilt(L:end);

rxSigFOFDM = ofdmdemod(rxSigFiltSync,numFFT,cpLen,symOffset,nullIdx); % with a time shift

rxSigFOFDM = eqH.*rxSigFOFDM;

end