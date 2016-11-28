
module SPI_Interface(done, rxBitOut, addr, WE, txDataToSRAM, rxDataFromSRAM, txDataIn, ss, SCK);
    output rxBitOut, WE, done;
    output [7:0] addr;
    output [7:0] txDataToSRAM;
    
    input [7:0] rxDataFromSRAM;
    input txDataIn, ss, SCK;
    
    wire [7:0] instr;
    wire shiftAddr, loadRX, shiftRX, shiftTX, count, instrShift;
    
//    module datapath(SRAMDataOut, SRAMAddrOut, rxDataOut, load, shift, dataIn, done, count, SCK, addrShift, txShift, bitIn);
//module control_unit(count, WE, shiftRX, shiftAddr, shiftTX, loadRX, WR, SCK, ss, done);

    datapath dp(done, instr, txDataToSRAM, addr, rxBitOut, loadRX, shiftRX, rxDataFromSRAM, done, count, SCK, shiftAddr, shiftTX, txDataIn, instrShift);
    control_unit cu(count, WE, shiftRX, shiftAddr, shiftTX, loadRX, instr[0], SCK, ss, done, instrShift);

endmodule