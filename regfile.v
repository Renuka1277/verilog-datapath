`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2025 17:47:42
// Design Name: 
// Module Name: regfile
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
