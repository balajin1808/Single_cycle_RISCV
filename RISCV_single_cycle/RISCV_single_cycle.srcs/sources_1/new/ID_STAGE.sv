`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 02:02:07 PM
// Design Name: 
// Module Name: ID_STAGE
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


`timescale 1ns / 1ps

module ID_STAGE (
    input logic clk,
    input logic reset,

    input logic [31:0] instruction,

    // Writeback inputs from later pipeline stages
    input logic [4:0] wb_rd_sel,
    input logic [31:0] wb_data,
    input logic wb_reg_write,

    // Register file outputs
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data,

    // Decoded fields
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [31:0] imm_output,

    // Control signals
    output logic branch,
    output logic mux_inp,
    output logic memread,
    output logic [1:0] memtoreg,
    output logic memwrite,
    output logic alusrc,
    output logic reg_write,
    output logic [2:0] aluop
);

    logic [6:0] opcode;
    logic [6:0] imm11_5;
    logic [2:0] fn3;
    logic [11:0] imm;
    logic [19:0] imm_ui;
    logic fn7_5;

    // 1. Instruction Decoder
    decoder D1 (
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .imm11_5(imm11_5),
        .fn3(fn3),
        .imm(imm),
        .imm_ui(imm_ui),
        .fn7_5(fn7_5)
    );

    // 2. Register File
    reg_file R1 (
        .clk(clk),
        .reset(reset),
        .rs1_sel(rs1),
        .rs2_sel(rs2),
        .rd_sel(wb_rd_sel),
        .wb_data(wb_data),
        .reg_write(wb_reg_write),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // 3. Immediate Generator
    imm_generator I1 (
        .imm_input(imm),
        .imm_output(imm_output),
        .opcode(opcode),
        .imm_input_uj(imm_ui),
        .fn3(fn3)
    );

    // 4. Control Unit
    Main_Control C1 (
        .opcode(opcode),
        .branch(branch),
        .mux_inp(mux_inp),
        .memread(memread),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .reg_write(reg_write),
        .aluop(aluop)
    );

endmodule
