function txSigOFDM=modOFDM(inputData,numFFT,cpLen,nullIdx)

txSigOFDM = ofdmmod(inputData,numFFT,cpLen,nullIdx);

% % Plot (PSD) para señal OFDM
% [psd,f] = periodogram(txSigOFDM, rectwin(length(txSigOFDM)), numFFT*2, ...
%     1, 'centered');
% figure(1)
% plot(f,10*log10(psd));
% grid on
% axis([-0.5 0.5 -100 -20]);
% xlabel('Normalized frequency');
% ylabel('PSD (dBW/Hz)')
% title(['OFDM, ' num2str(numFFT-numel(nullIdx)) ' Subcarriers'])

end
