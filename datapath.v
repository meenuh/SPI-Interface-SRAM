
module datapath(done, instr, SRAMDataOut, SRAMAddrOut, rxDataOut, load, shift, dataIn, done, count, SCK, addrShift, txShift, bitIn, instrShift);

    input count, SCK, load, shift, txShift, addrShift, bitIn, instrShift;
    input [7:0] dataIn;
    output done;
    output rxDataOut;
    output [7:0] SRAMDataOut;
    output [7:0] SRAMAddrOut;
    output [7:0] instr;
    
    assign full = done;
    
    counter counter(done , start, count, SCK);
    rxData rxBuff(rxDataOut, load, shift, SCK, dataIn, done);
    txData txBuff(SRAMDataOut, txShift, SCK, bitIn, done);
    txData AddrBuff(SRAMAddrOut, addrShift, SCK, bitIn, done);
    txData InstrBuff(instr, instrShift, SCK, bitIn, done);
    
endmodule