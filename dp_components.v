
//will use these for tx and addr
module txData(dataOut, shift, SCK, dataIn, full);
    output reg [7:0] dataOut;
    input shift, SCK, dataIn, full;
    
    reg [7:0] buffer;
    
    initial begin
        buffer = 8'b0;
    end
    
    always @(negedge SCK)begin
        if(shift)begin
            buffer <= {dataIn, buffer[7:1]};
        end else if (full)begin
            dataOut <= buffer; 
        end else begin 
            dataOut <= dataOut;
            buffer <= buffer;
        end
    end
endmodule 

module rxData(dataOut, load, shift, SCK, dataIn, done);
    output reg dataOut;
    input load, shift, SCK, done;
    input [7:0] dataIn;
    
    reg [7:0] buffer;
    
    initial begin
        buffer = 8'b0;
    end

    always @(posedge SCK)begin
        if(load) buffer <= dataIn;
        else if(!done && shift)begin
            dataOut <= buffer[0];
            buffer <= buffer >> 1;
        end else buffer <= buffer;
    end
endmodule

module counter(done, start, count, SCK);
    output reg done, start;
    input count, SCK;
    
    reg [3:0] cycleCount;
    
    initial begin
        cycleCount = 4'b1000;
        start = 1;
    end
    
    always@(negedge SCK)begin
    
        if(count)
            cycleCount <= cycleCount - 4'b1;
        else cycleCount <= cycleCount;
        
        if(cycleCount == 1) begin
            done <= 1;
            start = 1;
            //cycleCount <= 3'b111;
        end else begin
            start = 0;
            done <= 0;
            
            if(cycleCount == 0) begin cycleCount <= 4'b1000; end
            
        end //end else
    end; //end always
    
endmodule


module SRAM(dataOut, dataIn, addr, WE);
    output reg [7:0] dataOut;
    input [7:0] dataIn;
    input [7:0] addr;
    input WE;

    reg [7:0] sram [255:0];
    
    always@(*)begin
        if(WE)begin
            sram[addr] = dataIn;
        end else begin
            dataOut = sram[addr];
        end
    end

endmodule