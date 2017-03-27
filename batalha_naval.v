module priplayer (
  input clk,
  output [2:0]ply1);

  reg [2:0]jogada;
  reg j1 = 0 ;

  assign ply1 = (jogada);

  always @ (posedge clk ) begin
    j1 = j1 + 1;
    if(j1==1)begin
        jogada[0] = 0;
        jogada[1] = 0;
        jogada[2] = 1;
    end else if(j1==2)begin
        jogada[0] = 0;
        jogada[1] = 1;
        jogada[2] = 0;
    end else if(j1==3)begin
        jogada[0] = 0;
        jogada[1] = 1;
        jogada[2] = 1;
    end else if(j1==4)begin
        jogada[0] = 1;
        jogada[1] = 0;
        jogada[2] = 0;
    end else if(j1==5)begin
        jogada[0] = 1;
        jogada[1] = 0;
        jogada[2] = 1;
    end else if(j1==6)begin
        jogada[0] = 1;
        jogada[1] = 1;
        jogada[2] = 0;
        j1=0;
    end
  end

endmodule //

module segplayer (
    input clk,
    output [2:0]ply2);

    reg [2:0]jogada;
    reg j2 = 0;

    assign ply2 = (jogada);

    always @ ( clk ) begin
      j2 = j2 + 1;
      if(j2==3) begin
          jogada[0] = 0;
          jogada[1] = 0;
          jogada[2] = 1;
      end else if(j2==2) begin
          jogada[0] = 0;
          jogada[1] = 1;
          jogada[2] = 0;
      end else if(j2==1) begin
          jogada[0] = 0;
          jogada[1] = 1;
          jogada[2] = 1;
      end else if(j2==4) begin
          jogada[0] = 1;
          jogada[1] = 0;
          jogada[2] = 0;
      end else if(j2==6) begin
          jogada[0] = 1;
          jogada[1] = 0;
          jogada[2] = 1;
      end else if(j2==5) begin
          jogada[0] = 1;
          jogada[1] = 1;
          jogada[2] = 0;
          j2=0;
      end
    end

endmodule //

module batalha (
  input CLOCK_50,
  output [2:0]win);

  wire pl1;
  wire pl2;
  reg ww = 0;

  assign win = ww;  
  
  priplayer jog1(CLOCK_50, ply1);
  segplayer jog2(CLOCK_50, ply2);

  assign pl1 <= (ply1);
  assign pl2 <= (ply2);

  if(pl1 == pl2) begin
    ww = 1;
  end else begin
    ww = 0;
  end

endmodule //

module test;
    reg clk;
    reg jog1;
    reg jog2;
    reg win;
    wire saida;

    priplayer pri(clk, ply1);
    segplayer seg(clk, ply2);

    always #2 begin
        clk <= ~clk;
    end

    assign jog1 = (pri);
    assign jog2 = (seg);

    if(jog1 == jog2) begin
      win <= 1;
    end else begin
      win <= 0;
    end

    assign saida = (win);

    initial begin
      $dumpvars(0, clk, pri, seg, saida);
      #2;
      clk <= 0;
      #300;
      #300;
      #300;
      #300;
      #300;
      #300;
      #300;
      #300;
      $finish;
    end

endmodule //
