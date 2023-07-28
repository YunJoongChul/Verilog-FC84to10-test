`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/28 13:47:50
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(clk, rst, start ,dout);
input clk, rst, start;
output [15:0] dout;
reg [9:0] addr_in, addr_w;
wire [15:0] dout_in, dout_w;
wire [31:0] data_out;
reg [31:0] dout_mul;
reg wea_w;
reg [9:0] addr_mul;
reg [15:0] din_mul;
blk_mem_gen_0 u0(.clka(clk), .addra(addr_in), .douta(dout_in));
blk_mem_gen_1 u1(.clka(clk), .addra(addr_w), .douta(dout_w));
mult_gen_0 u2(.CLK(clk), .A(dout_in), .B(dout_w), .P(data_out));
blk_mem_gen_2 u3(.clka(clk), .wea(wea_w), .addra(addr_mul), .dina(data_out), .douta(dout));
reg [2:0] state;
localparam IDLE = 3'd0, FC_1 = 3'd1, BIAS = 3'd2, DONE = 3'd3;
reg bias [3:0];
assign bias1 = 1;
assign bais2 = 1;
assign bais3 = 1;
assign bais4 = 1;
always@(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
        case(state)
             IDLE : if(start) state <= FC_1; else state <= IDLE;
             FC_1 :if(addr_mul == 22) state <= IDLE; else state <= FC_1;
             //BIAS : if(addr_mul == 22) state <= DONE;
             DONE : state <= IDLE;
             default : state <= IDLE;
             endcase
 end
 
 
 always@(posedge clk or posedge rst)
begin
    if(rst)
        addr_in <= 10'd0;
    else
        case(state)
            FC_1 :if(addr_in == 4) addr_in <= 0; else addr_in <= addr_in + 1'd1;
            default : addr_in <= 0;
            endcase
end

always@(posedge clk or posedge rst)
begin
    if(rst)
        addr_w <= 10'd0;
    else
        case(state)
            FC_1 :if(addr_w == 19) addr_w <= 0; else addr_w <= addr_w + 1'd1;
            default : addr_w <= 0;
            endcase
end




always@(posedge clk or posedge rst)
begin
    if(rst)
        addr_mul <= 10'd0;
    else
      case(state)
            FC_1 :if(addr_mul == 22) addr_mul <= 0;  else addr_mul <= addr_mul + 1'd1;
            default : addr_mul <= 0;
            endcase
end


always@(posedge clk or posedge rst)
begin
    if(rst)
        wea_w <= 0;
    else
        case(state)
            FC_1 : if(addr_mul == 22) wea_w <= 0; else wea_w <= 1;
            default : wea_w <= 0;
            endcase
end


endmodule
