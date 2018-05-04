module contador (
    input clk,
	 input [1:0] b1,
    output state);

    reg [30:0]count;
    reg [1:0] lig;
    assign state = (lig);
	 
    always @ (posedge clk ) begin
      count <= count + 1;
      case (b1)
			
			2'b00 : if (count >= 5000000) begin
						  lig <= ~lig;
						  count <= 0;
						end
			2'b01 : if (count >= 750000000) begin
						  lig <= ~lig;
						  count <= 0;
						end
			default : if (count >= 50000000) begin
						  lig <= ~lig;
						  count <= 0;
						end
		endcase
    end

endmodule //

module phudim (
    input CLOCK_50,
	 input [2:0] KEY,
    output [7:0] LEDG,
	 output [9:0] LEDR
	 );

    wire state;
	 reg [1:0] b1 = 2;
	 
    contador LED(CLOCK_50, b1, state);
	
	 always @ (posedge CLOCK_50) begin
		 if (~KEY[0]) begin
				b1 = 2'b00;
		 end 
		 else if (~KEY[1]) begin
				b1 = 2'b01;
		 end
		 else if (~KEY[2]) begin
				b1 = 2'b10;
		 end
	 end

    assign  LEDG[0] = state;
	 assign  LEDG[1] = ~state;
	 assign  LEDG[2] = state;
	 assign  LEDG[3] = ~state;
	 assign  LEDG[4] = state;
	 assign  LEDG[5] = ~state;
	 assign  LEDG[6] = state;
	 assign  LEDG[7] = ~state;
	 assign  LEDR[0] = state;
	 assign  LEDR[1] = ~state;
	 assign  LEDR[2] = state;
	 assign  LEDR[3] = ~state;
	 assign  LEDR[4] = state;
	 assign  LEDR[5] = ~state;
	 assign  LEDR[6] = state;
	 assign  LEDR[7] = ~state;
	 assign  LEDR[8] = state;
	 assign  LEDR[9] = ~state;
	 

endmodule //
