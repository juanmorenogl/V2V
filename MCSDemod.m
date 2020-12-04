function dataRX=MCSDemod(rxSig,MCS)
trellis = poly2trellis(7,[133 171]);
ConstrLength = log2(trellis.numStates);

switch MCS
    case 1 %BPSK 1/2
        bitsPerSubCarrier = 1;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        dataDeCoded = pskdemod(rxSig,M);
        tbdepth = 5*ConstrLength;
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard');
    case 2 %BPSK 3/4
        bitsPerSubCarrier = 1;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;        
        dataDeCoded = pskdemod(rxSig,M);
        tbdepth = 10*ConstrLength;
        puncpat = [1;1;0];
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard',puncpat);
    case 3 %QPSK 1/2
        bitsPerSubCarrier = 2;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;        
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 5*ConstrLength;
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard');
    case 4 %QPSK 3/4
        bitsPerSubCarrier = 2;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;        
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 10*ConstrLength;
        puncpat = [1;1;0];
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard',puncpat);
    case 5 %16QAM 1/2
        bitsPerSubCarrier = 4;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;       
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 5*ConstrLength;
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard');
    case 6 %16QAM 3/4
        bitsPerSubCarrier = 4;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;       
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 10*ConstrLength;
        puncpat = [1;1;0];
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard',puncpat);       
    case 7 %64QAM 2/3
        bitsPerSubCarrier = 6;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;        
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 8*ConstrLength;
        puncpat = [1;1;1;0];
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard',puncpat); 
    case 8 %64QAM 3/4
        bitsPerSubCarrier = 6;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;       
        dataDeCoded = qamdemod(rxSig,M,'OutputType', 'Bit');
        tbdepth = 10*ConstrLength;
        puncpat = [1;1;0];
        dataRX = vitdec(dataDeCoded,trellis,tbdepth,'trunc','hard',puncpat);
end

end