
//will use these for tx and addr
module txData(dataOut, load, shift, SCK, dataIn, full);
    output reg [7:0] dataOut;
    input shift, SCK, dataIn, load, full;
    
    reg [7:0] buffer;
    
    always @(negedge SCK)begin
        if(load && shift)begin
            buffer <= {dataIn, buffer[7:1]};
        end else if (full)begin
            dataOut <= buffer; 
        end //else dataOut <= dataOut;
    end
endmodule 

module rxData(dataOut, load, shift, SCK, dataIn, done);
    output reg dataOut;
    input load, shift, SCK, done;
    input [7:0] dataIn;
    
    reg [7:0] buffer;

    always @(negedge SCK)begin
        if(load) buffer <= dataIn;
        else if(shift && !done)begin
            dataOut <= buffer[0];
            buffer <= {0, buffer[7:1]};
        end
    end
endmodule

module counter(done, count, SCK);
    output reg done;
    input count, SCK;
    
    reg [2:0] cycleCount;
    
    initial begin
        cycleCount = 3'b111;
    end
    
    always@(posedge SCK)begin
        if(cycleCount == 0)
            done <= 1;
        else begin
            done <= 0;
            
            if(count)
                cycleCount <= cycleCount - 3'b1;
            //else cycleCount <= cycleCount;
        end //end else
    end; //end always
    
endmodule


module SRAM(dataOut, dataIn, addr, WE);
    output reg [7:0] dataOut;
    input [7:0] dataIn;
    input [7:0] addr;
    input WE;

    reg [255:0] sram [7:0];

endmodule