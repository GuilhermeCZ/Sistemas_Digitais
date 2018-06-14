module area (input clock, input [11:0] x1, input [11:0] x2, input [11:0] x3,
          input [11:0] y1, input [11:0] y2, input [11:0] y3, output [11:0] abs);

          reg [11:0] S0 = 0;
          assign S0 = abs;

          always @ ( posedge clock ) begin
            S0 = ((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
          end

endmodule //area
module isInside (input clock, input [11:0] x1, input [11:0] x2, input [11:0] x3,
          input [11:0] y1, input [11:0] y2, input [11:0] y3,
          input [11:0] x, input [11:0] y, output [1:0] ponto);

          reg [1:0] S1 = 0;
          reg [11:0] A0 = 0;
          reg [11:0] A1 = 0;
          reg [11:0] A2 = 0;
          reg [11:0] A3 = 0;
          assign S1 = ponto;

          wire [11:0] SA;
          wire [11:0] SA1;
          wire [11:0] SA2;
          wire [11:0] SA3;

          area a(clock, x1, y1, x2, y2, x3, y3, SA);
          area a1(clock, x, y, x2, y2, x3, y3, SA1);
          area a2(clock, x1, y1, x, y, x3, y3, SA2);
          area a1(clock, x1, y1, x2, y2, x, y, SA3);

          always @ ( posedge clock) begin
            if (SA == SA1 + SA2 + SA3) begin
              S1 = ~S1;
            end
            else begin
              S1 = ~S1;
            end
          end
endmodule //isInside
module teste ();
  reg clock;
  reg [11:0] x1, x2, x3, y1, y2, y3;
  wire [1:0] S0;
  integer x;
  integer y;
  always #1 clock = ~clock;

  always @ ( posedge clock ) begin
    for (x = 1; x <= 48; x++) begin
      for (y = 1; y <= 64; y++) begin
        isInside I(clock, x1,x2,x3,y1,y2,y3, x,y, S0);
      end
    end
  end

  initial begin
    $dumpvars();
    #0 clock <= 0;
    x1 = 12;
    y1 = 15;
    x2 = 12;
    y2 = 25;
    x3 = 15;
    y3 = 15;
    #10

  end
endmodule //teste
