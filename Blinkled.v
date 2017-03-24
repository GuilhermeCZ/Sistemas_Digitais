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
