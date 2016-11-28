module control_unit(count, WE, shiftRX, shiftAddr, shiftTX, loadRX, WR, SCK, ss, done, instrShift);
    output reg count, WE, shiftRX, shiftAddr, shiftTX, loadRX, instrShift;
    input WR, SCK, ss, done;
    
    reg [2:0] ns, cs;
    
    localparam IDLE = 3'b0,
    ADDR = 3'b010,
    INSTR = 3'b001,
    READ = 3'b011,
    WRITE = 3'b100;
    
    initial begin
        cs = IDLE;
    end
    
    always @(posedge SCK) begin
        cs <= ns;
    end
    
    always @(ss, cs, done) begin
        case(cs)
            IDLE: begin
                if(!ss) ns <= INSTR;
                else ns <= IDLE;
            end
            ADDR: begin
                if(done)begin 
                    if(WR) ns <= WRITE;
                    else ns <= READ;
                end else ns <= ADDR;
            end
            INSTR: begin
                if(done) begin
                    ns <= ADDR;
                end else ns <= INSTR;
            end
            READ: begin
                if(!done) ns <= IDLE;
                else ns <= READ;
            end
            WRITE: begin
                if(done) ns <= IDLE;
                else ns <= WRITE;
            end
            default: ns <= cs;
        endcase
    end
    
    always @(cs, done)begin
        case(cs) 
            IDLE: begin 
                    count = 0; WE = 0; shiftRX = 0; shiftAddr = 0; shiftTX = 0; loadRX = 0; instrShift = 0; 
                end
            ADDR: begin 
                    count = 1; WE = 0; shiftRX = 0; shiftTX = 0; loadRX = 0; instrShift = 0;
                    if(done) shiftAddr = 0;
                    else shiftAddr = 1; 
                end
            INSTR: begin 
                    count = 1; WE = 0; shiftRX = 0; shiftTX = 0; loadRX = 0; shiftAddr = 0;
                    if(done) instrShift = 0;
                    else instrShift = 1;
                end
            READ: begin 
                    count = 1; WE = 0; shiftAddr = 0; shiftTX = 0; instrShift = 0;
                    if(done)begin 
                        loadRX = 1; shiftRX = 0;
                    end else begin
                        loadRX = 0; shiftRX = 1; 
                    end 
                end
            WRITE: begin 
                    count = 1; instrShift = 0;
                    if(done) begin WE = 1; shiftTX = 0; end
                    else begin WE = 0; shiftTX = 1; end
                    shiftRX = 0; shiftAddr = 0; loadRX = 0; 
                end
        endcase
    end
    

endmodule