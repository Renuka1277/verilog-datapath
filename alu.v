`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2025 17:10:17
// Design Name: 
// Module Name: alu
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
