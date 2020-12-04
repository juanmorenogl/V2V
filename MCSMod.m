function [dataTX,signalTX]=MCSMod(numRBs,rbSize,MCS)
numDataCarriers = numRBs*rbSize;                % Número de subcarriers con datos
trellis = poly2trellis(7,[133 171]);

switch MCS
    case 1 %BPSK 1/2
        bitsPerSubCarrier = 1;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(1/2);
        dataTX = randi([0 M-1],bitsSent,1);
        dataCoded = convenc(dataTX,trellis);
        signalTX=pskmod(dataCoded,M);
    case 2 %BPSK 3/4
        bitsPerSubCarrier = 1;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(3/4);
        dataTX = randi([0 M-1],bitsSent,1);
        puncpat = [1;1;0];
        dataCoded = convenc(dataTX,trellis,puncpat);
        signalTX=pskmod(dataCoded,M);
    case 3 %QPSK 1/2
        bitsPerSubCarrier = 2;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(1/2);
        dataTX = randi([0 1],bitsSent,1);
        dataCoded = convenc(dataTX,trellis);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
    case 4 %QPSK 3/4
        bitsPerSubCarrier = 2;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(3/4);
        dataTX = randi([0 1],bitsSent,1);
        puncpat = [1;1;0];
        dataCoded = convenc(dataTX,trellis,puncpat);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
    case 5 %16QAM 1/2
        bitsPerSubCarrier = 4;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(1/2);
        dataTX = randi([0 1],bitsSent,1);
        dataCoded = convenc(dataTX,trellis);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
    case 6 %16QAM 3/4
        bitsPerSubCarrier = 4;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(3/4);
        dataTX = randi([0 1],bitsSent,1);
        puncpat = [1;1;0];
        dataCoded = convenc(dataTX,trellis,puncpat);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
    case 7 %64QAM 2/3
        bitsPerSubCarrier = 6;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(2/3);
        dataTX = randi([0 1],bitsSent,1);
        puncpat = [1;1;1;0];
        dataCoded = convenc(dataTX,trellis,puncpat);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
    case 8 %64QAM 3/4
        bitsPerSubCarrier = 6;                          %1: BPSK 2: QPSK, 4: 16QAM, 6: 64QAM, 8: 256QAM
        M=2^bitsPerSubCarrier;
        bitsSent = (numDataCarriers*bitsPerSubCarrier)*(3/4);
        dataTX = randi([0 1],bitsSent,1);
        puncpat = [1;1;0];
        dataCoded = convenc(dataTX,trellis,puncpat);
        signalTX=qammod(dataCoded,M,'InputType', 'Bit');
end


end