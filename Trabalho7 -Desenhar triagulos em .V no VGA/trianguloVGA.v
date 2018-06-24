module mem_ROM (
   input CLOCK_50,
   input  [17:0] w_addr,
   input  [15:0] w_data,
   input  [17:0] r_addr,
   output [15:0] r_data,

   output [17:0] addr,
   inout [15:0] data,

   output we, // config da placa para memoria
   output oe, //
   output ub, //
   output lb, //
   output ce  //
   );

   reg state = 0;
   assign we = state;
   assign oe = 0;
   assign ub = 0;
   assign lb = 0;
   assign ce = 0;
   assign r_data = reg_r_data;

   reg [15:0] reg_r_data;

   reg [17:0] reg_addr;
   reg [15:0] reg_dq;

   assign addr = reg_addr;

   assign data = reg_dq;

   always @(posedge CLOCK_50)
   begin

       case (state)
           0: begin
               reg_addr <= r_addr;
               reg_dq <= 16'hzzzz;
               state <= 1;
           end
           1: begin
               reg_r_data <= data;
               reg_addr <= w_addr;
               reg_dq <= w_data;
               state <= 0;
           end
       endcase
   end

endmodule // mem_ROM

module trianguloVGA (
   input CLOCK_50,
   input [3:0] KEY,
   input [9:0] SW,
   output [3:0] VGA_R,
   output [3:0] VGA_G,
   output [3:0] VGA_B,
   output VGA_HS,
   output VGA_VS,
   output [7:0] LEDG,
   output [9:0] LEDR,
   output [17:0] SRAM_ADDR,
   inout [15:0] SRAM_DQ,
   output SRAM_WE_N,
   output SRAM_OE_N,
   output SRAM_UB_N,
   output SRAM_LB_N,
   output SRAM_CE_N //
   );

// ------   Pontos do Trigulos ----- //

   reg [11:0] pToX; // Coordenadas do ponto
   reg [11:0] pToY;

   reg [11:0] p1x_1; // Coordenadas od triangulo 1
   reg [11:0] p1y_1;
   reg [11:0] p2x_1;
   reg [11:0] p2y_1;
   reg [11:0] p3x_1;
   reg [11:0] p3y_1;

   reg [11:0] p1x_2; // Coordenadas do Triangulo 2
   reg [11:0] p1y_2;
   reg [11:0] p2x_2;
   reg [11:0] p2y_2;
   reg [11:0] p3x_2;
   reg [11:0] p3y_2;

   reg [11:0] p1x_3; // Coordenadas do Triangulo 3
   reg [11:0] p1y_3;
   reg [11:0] p2x_3;
   reg [11:0] p2y_3;
   reg [11:0] p3x_3;
   reg [11:0] p3y_3;

   wire t1_1, s1_1, s2_1, s3_1; // resultado da saida do module testeTri
   wire t1_2, s1_2, s2_2, s3_2;
   wire t1_3, s1_3, s2_3, s3_3;

// ----- PROGRAMACAO MEMORIA SRAM ----- //

   reg [17:0] Waddr;
   reg [17:0] Raddr;

   wire [15:0] Rdata;
   wire [15:0] Wdata;

   reg [3:0] WRed;
   reg [3:0] WGreen;
   reg [3:0] WBlue;

   reg [3:0] RRed;
   reg [3:0] RGreen;
   reg [3:0] RBlue;

   assign Wdata [3:0] = WRed;
   assign Wdata [7:4] = WGreen;
   assign Wdata [11:8] = WBlue;

   mem_ROM A(CLOCK_50, Waddr, Wdata, Raddr, Rdata, SRAM_ADDR, SRAM_DQ, SRAM_WE_N, SRAM_OE_N, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N);


// ----- LEDS ----- //

   assign LEDR[3:0] = SRAM_DQ[11:8];
   assign LEDG[7:0] = SRAM_DQ[7:0];

// ----- Programação do VGA ----- //

   assign VGA_R = RRed;
   assign VGA_G = RGreen;
   assign VGA_B = RBlue;

   integer h_count, v_count;

   reg CLK_25;
   reg clock_state;

   assign VGA_HS = (h_count >= 660 && h_count <= 756) ? 0:1;
   assign VGA_VS = (v_count >= 494 && v_count <= 495) ? 0:1;

// ----- Clock para o VGA 25MHz ----- //

   always @(posedge CLOCK_50) begin
      if (clock_state == 0) begin
         CLK_25 = ~CLK_25;
      end
      else begin
         clock_state = ~clock_state;
      end
   end

   always @(posedge CLK_25) begin
   	if (h_count < 799) begin
   		h_count <= h_count + 1;
   	end
   	else begin
   		h_count <= 0;
   		if (v_count < 524) begin
   			v_count <= v_count + 1;
   		end
   		else begin
   			v_count <= 0;
   		end
   	end
   end

// ----- Teste do ponto no triangulo ----- //

testeTri S1_1(p1x_1, p1y_1, p2x_1, p2y_1, p3x_1, p3y_1, t1_1);
testeTri S2_1(p1x_1, p1y_1, p2x_1, p2y_1, pToX, pToY, s1_1);
testeTri S3_1(p2x_1, p2y_1, p3x_1, p3y_1, pToX, pToY, s2_1);
testeTri S4_1(p3x_1, p3y_1, p1x_1, p1y_1, pToX, pToY, s3_1);

testeTri S1_2(p1x_2, p1y_2, p2x_2, p2y_2, p3x_2, p3y_2, t1_2);
testeTri S2_2(p1x_2, p1y_2, p2x_2, p2y_2, pToX, pToY, s1_2);
testeTri S3_2(p2x_2, p2y_2, p3x_2, p3y_2, pToX, pToY, s2_2);
testeTri S4_2(p3x_2, p3y_2, p1x_2, p1y_2, pToX, pToY, s3_2);

testeTri S1_3(p1x_3, p1y_3, p2x_3, p2y_3, p3x_3, p3y_3, t1_3);
testeTri S2_3(p1x_3, p1y_3, p2x_3, p2y_3, pToX, pToY, s1_3);
testeTri S3_3(p2x_3, p2y_3, p3x_3, p3y_3, pToX, pToY, s2_3);
testeTri S4_3(p3x_3, p3y_3, p1x_3, p1y_3, pToX, pToY, s3_3);

// ----- clock principal e Circuito ----- //

   always @ ( posedge CLOCK_50 ) begin
      pToX <= h_count;
      pToY <= v_count;

      p1x_1 <= 82; // Coordenadas triangulo 1
      p1y_1 <= 104;
      p2x_1 <= 171;
      p2y_1 <= 322;
      p3x_1 <= 321;
      p3y_1 <= 69;

      p1x_2 <= 80; // Coordenadas triangulo 2
      p1y_2 <= 470;
      p2x_2 <= 80;
      p2y_2 <= 352;
      p3x_2 <= 242;
      p3y_2 <= 352;

      p1x_3 <= 301; // Coordenadas triangulo 3
      p1y_3 <= 458;
      p2x_3 <= 480;
      p2y_3 <= 458;
      p3x_3 <= 389;
      p3y_3 <= 344;

      if (SRAM_WE_N == 0) begin
   		Waddr <= Waddr + 1;
   		if (h_count < 640 && v_count < 480) begin
   			if ((t1_1 == s1_1) && (s1_1 == s2_1) && (s2_1 == s3_1)) begin
   				if (SW[0] == 1) begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b0000;
   					WBlue <= 4'b0000;
   				end
   				else begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b1111;
   				end
   			end
   			else if ((t1_2 == s1_2) && (s1_2 == s2_2) && (s2_2 == s3_2)) begin
   				if (SW[1] == 1) begin
   					WRed <= 4'b0000;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b0000;
   				end
   				else begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b1111;
   				end
   			end
   			else if ((t1_3 == s1_3) && (s1_3 == s2_3) && (s2_3 == s3_3)) begin
   				if (SW[2] == 1) begin
   					WRed <= 4'b0000;
   					WGreen <= 4'b0000;
   					WBlue <= 4'b1111;
   				end
   				else begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b1111;
   				end
   			end
   			else if ((t1_4 == s1_4) && (s1_4 == s2_4) && (s2_4 == s3_4)) begin
   				if (SW[3] == 1) begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b0000;
   					WBlue <= 4'b1111;
   				end
   				else begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b1111;
   				end
   			end
   			else if ((t1_5 == s1_5) && (s1_5 == s2_5) && (s2_5 == s3_5)) begin
   				if (SW[4] == 1) begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b0000;
   				end
   				else begin
   					WRed <= 4'b1111;
   					WGreen <= 4'b1111;
   					WBlue <= 4'b1111;
   				end
   			end
   			else begin
   				WRed <= 4'b1111;
   				WGreen <= 4'b1111;
   				WBlue <= 4'b1111;
   			end
   		end
   		else begin
   			WRed <= 4'b0000;
   			WGreen <= 4'b0000;
   			WBlue <= 4'b0000;
   		end
   	end
   end

endmodule // trianguloVGA
