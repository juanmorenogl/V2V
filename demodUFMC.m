function rxSigUFMC=demodUFMC(inputData,numFFT,subbandSize,numSubbands,cpLen,hall)

subbandOffset = numFFT/2-subbandSize*numSubbands/2; 

%CREAMOS FILTRO CHEBYSHEV PROTOTIPO
slobeAtten = 80;                % side-lobe attenuation, dB
prototypeFilter = chebwin(cpLen, slobeAtten);

% Pad receive vector to twice the FFT Length 
%   No windowing or additional filtering adopted
yRxPadded = [inputData; zeros(2*numFFT-numel(inputData),1)];

% Perform FFT and downsample by 2
RxSymbols2x = fftshift(fft(yRxPadded));
RxSymbols = RxSymbols2x(1:2:end);

% Select data subcarriers
dataRxSymbols = RxSymbols(subbandOffset+(1:numSubbands*subbandSize));
dataHall= hall(subbandOffset+(1:numSubbands*subbandSize));
eqH = conj(dataHall)./(conj(dataHall).*dataHall);
eqSig = eqH.*dataRxSymbols;

% Use zero-forcing equalizer after demodulation
rxf = [prototypeFilter.*exp(1i*2*pi*0.5*(0:cpLen-1)'/numFFT); ...
       zeros(numFFT-cpLen,1)];
prototypeFilterFreq = fftshift(fft(rxf));
prototypeFilterInv = 1./prototypeFilterFreq(numFFT/2-subbandSize/2+(1:subbandSize));

% Equalize per subband - undo the filter distortion
dataRxSymbolsMat = reshape(eqSig,subbandSize,numSubbands);
EqualizedRxSymbolsMat = bsxfun(@times,dataRxSymbolsMat,prototypeFilterInv);
rxSigUFMC = EqualizedRxSymbolsMat(:);

end