function txSigUFMC=modUFMC(inputData,numFFT,subbandSize,numSubbands,cpLen)

subbandOffset = numFFT/2-subbandSize*numSubbands/2;            %  for band center

%CREAMOS FILTRO CHEBYSHEV PROTOTIPO
slobeAtten = 80;                % side-lobe attenuation, dB
prototypeFilter = chebwin(cpLen, slobeAtten);
inpData = reshape(inputData,subbandSize, numSubbands);

% figure(3);
% axis([-0.5 0.5 -100 20]);
% hold on; 
% grid on
% 
% xlabel('Normalized frequency');
% ylabel('PSD (dBW/Hz)')
% title(['UFMC, ' num2str(numSubbands) ' Subbands, '  ...
%     num2str(subbandSize) ' Subcarriers each'])

txSigUFMC = complex(zeros(numFFT+cpLen-1, 1));
for bandIdx = 1:numSubbands
    %PACK SYMBOLS FOR EACH SUBBAND
    offset = subbandOffset+(bandIdx-1)*subbandSize; 
    symbolsInOFDM = [zeros(offset,1); inpData(:,bandIdx); ...
                     zeros(numFFT-offset-subbandSize, 1)];
    ifftOut = ifft(ifftshift(symbolsInOFDM));
    
    %FILTER EACH SUBBAND WITH THE PROTOTYPE FILTER
    bandFilter = prototypeFilter.*exp( 1i*2*pi*(0:cpLen-1)'/numFFT* ...
             ((bandIdx-1/2)*subbandSize+0.5+subbandOffset+numFFT/2) );    
    filterOut = conv(bandFilter,ifftOut);
    txSigUFMC = txSigUFMC + filterOut;
    
%    [psd,f] = periodogram(filterOut, rectwin(length(filterOut)), ...
%                           numFFT*2, 1, 'centered'); 
%     plot(f,10*log10(psd)); 
end

end