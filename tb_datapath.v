`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2026 14:04:01
// Design Name: 
// Module Name: tb_datapath
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


module tb_datapath;

    reg         clk;
    reg         rst;
    reg         wen;
    reg  [2:0]  waddr;
    reg  [7:0]  wdata;
    reg  [2:0]  raddr1;
    reg  [2:0]  raddr2;
    reg  [2:0]  alu_ctrl;

    wire [7:0]  alu_result;
    wire        zero;
    wire        carry;
    wire        overflow;

    // Instantiate DUT
    datapath_top dut (
        .clk(clk),
        .rst(rst),
        .wen(wen),
        .waddr(waddr),
        .wdata(wdata),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        wen  = 0;

        waddr = 0;
        wdata = 0;
        raddr1 = 0;
        raddr2 = 0;
        alu_ctrl = 0;

        // Reset
        #10 rst = 0;

        // Write R1 = 10
        @(posedge clk);
        wen = 1;
        waddr = 3'd1;
        wdata = 8'd10;

        // Write R2 = 5
        @(posedge clk);
        waddr = 3'd2;
        wdata = 8'd5;

        // Disable write
        @(posedge clk);
        wen = 0;

        // Read R1 and R2
        raddr1 = 3'd1;
        raddr2 = 3'd2;

        // ALU ADD
        alu_ctrl = 3'b000;
        #10;

        // ALU SUB
        alu_ctrl = 3'b001;
        #10;

        $finish;
    end

endmodule

