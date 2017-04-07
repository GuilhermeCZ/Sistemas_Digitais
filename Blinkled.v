module contador (
    input clk,
    output state);

    reg [28:0]count;
    reg [1:0] lig;

    assign state = (lig);

    always @ (posedge clk ) begin
      count <= count + 1;
      if (count == 50000000) begin
        lig <= ~lig;
        count <= 0;
      end
    end

endmodule //

module led (
    input CLOCK_50,
    output [7:0] LEDG,
	 output [9:0] LEDR
	 );

    wire state;

    contador LED(CLOCK_50, state);

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

/*module teste;
	
	reg clk;
	wire saida;	

	led lig(clk, saida);

	always #2 begin
		clk <= ~clk;
	end
	
	initial begin 
		$dumpvars(0, clk, lig);
		#5;
		clk <= 0;
		#5;
		#300;
		$finish;
	end

endmodule // */
