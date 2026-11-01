`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2026 15:34:19
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input logic clk ,
    input logic reset ,
    input logic [4:0] rs1_sel,
    input logic [4:0] rs2_sel,
    input logic [4:0] rd_sel,
    input logic [31:0] wb_data,
    input logic reg_write,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
    );
logic [31:0] regs [0:31];
assign rs1_data =(rs1_sel==5'd0)?32'd0:regs[rs1_sel];
assign rs2_data =(rs2_sel==5'd0)?32'd0:regs[rs2_sel];
always_ff @(posedge clk or posedge reset) begin
if (reset) begin
        for (int i = 0; i < 32; i = i + 1)
            regs[i] <= 32'd0;
            end
else if (reg_write && (rd_sel!= 5'd0)) begin
        regs[rd_sel] <= wb_data;
    end
end
    
endmodule