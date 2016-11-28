
module gen_sck(sck, clk);
    input clk;
    output sck;
 
    reg [2:0] r_reg;
    wire [2:0] r_nxt;
    reg clk_track;
    
    initial begin
        r_reg <= 3'b0;
        clk_track <= 1'b0;
    end
 
    always @(posedge clk)begin
     
     if (r_nxt == 3'b100)
           begin
             r_reg <= 0;
             clk_track <= ~clk_track;
           end
     
      else 
          r_reg <= r_nxt;
    end
     
    assign r_nxt = r_reg+1;   	      
    assign sck = clk_track;
endmodule