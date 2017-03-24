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
    input CLOCK_50;
    output [7:0]LEDG);

    wire state;

    contador LED(CLOCK_50, state);

    assign  LEDG[0] <= state;

endmodule //

/*module contador (
    input clk,
    output state);

    reg [28:0]count = 0;
    reg [1:0] lig = 0;

    assign state = (lig);

    always @ (clk ) begin
      count <= count + 1;
      if (count == 50) begin
        lig <= ~lig;
        count <= 0;
      end
    end

endmodule //

module led (
    input CLOCK_50,
    output LEDG);

    wire state;

    contador LED(CLOCK_50, state);

    assign  LEDG = state;

endmodule //

module teste;
	
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
