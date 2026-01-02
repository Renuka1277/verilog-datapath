`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2026 13:50:30
// Design Name: 
// Module Name: datapath_top
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


module datapath_top (
    input  wire        clk,
    input  wire        rst,
    input  wire        wen,
    input  wire [2:0]  waddr,
    input  wire [7:0]  wdata,
    input  wire [2:0]  raddr1,
    input  wire [2:0]  raddr2,
    input  wire [2:0]  alu_ctrl,
    output wire [7:0]  alu_result,
    output wire        zero,
    output wire        carry,
    output wire        overflow
);

    wire [7:0] reg_rdata1;
    wire [7:0] reg_rdata2;

    // Register File
    regfile rf (
        .clk(clk),
        .rst(rst),
        .wen(wen),
        .waddr(waddr),
        .wdata(wdata),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );

    // ALU
    alu alu_inst (
        .A(reg_rdata1),
        .B(reg_rdata2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );

endmodule



module alu #(
   parameter width = 8
    )(
    input wire [width-1:0] A,B,
    input wire [2:0] alu_ctrl,
    output reg [width-1:0] result,
    output wire zero,
    output reg carry,
    output reg overflow

    );
    wire [width:0] sum;
    wire [width:0] diff;
     assign sum = {1'b0,A} + {1'b0,B};
     assign diff = {1'b0,A} - {1'b0,B}; 
     
    always @(*) begin
      result = {width{1'b0}};
      carry = 1'b0;
      overflow = 1'b0;
    case (alu_ctrl)
       3'b000: begin
       result = sum[width-1:0];
       carry = sum[width];
       overflow = (~A[width-1] & ~B[width-1] & result[width-1] ) | (A[width-1] & B[width-1] & ~result[width-1]);
       end
       3'b001: begin
       result = diff[width-1:0];
       carry = ~diff[width];
       overflow = (~A[width-1] & B[width-1] & result[width-1] ) | (A[width-1] & ~B[width-1] & ~result[width-1]);
       end
       3'b010: result = A&B;
       3'b011: result = A|B;
       3'b100: result = A^B;
       3'b101: result = A<<B;
       3'b110: result = A>>B;
       3'b111: result = (A<B)? 1:0;
       default: result = {width{1'b0}};
    endcase
    end
    assign zero = (result == {width{1'b0}});
endmodule


module regfile #(
   parameter width = 8,
   parameter depth = 8,
   parameter addr = 3
    )(
    input wire  clk,
    input  wire rst,
    input wire wen,
    input wire [addr-1:0] waddr,
    input wire [width-1:0] wdata,
    input wire [addr-1:0] raddr1,
    output wire [width-1:0] rdata1,
    input wire [addr-1:0] raddr2,
    output wire [width-1:0] rdata2
     );
     
     reg [width-1:0] reg_mem [0: depth-1];
     
     integer i;
     
     always @(posedge clk) begin
         if(rst) begin
            for(i=0; i<depth; i=i+1)
                 reg_mem[i] <= {width{1'b0}};
         end   
         else if (wen) begin
            reg_mem[waddr] <= wdata;
         end
     end
     
     assign rdata1 = reg_mem[raddr1];
     assign rdata2 = reg_mem[raddr2];
endmodule