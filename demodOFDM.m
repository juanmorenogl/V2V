function rxSigOFDM=demodOFDM(inputData,numFFT,cpLen,nullIdx,symOffset,eqH)

rxSigOFDM = ofdmdemod(inputData,numFFT,cpLen,symOffset,nullIdx);

rxSigOFDM = eqH.*rxSigOFDM;

end