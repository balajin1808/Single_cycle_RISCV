`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 02:44:17 PM
// Design Name: 
// Module Name: ALU_Ctrl
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


module ALU_Ctrl (
    input  logic [2:0] aluop,
    input  logic [2:0] fn3,
    input  logic       fn7_5,
    output logic [3:0] alu_control
);

    always_comb begin
        case (aluop)

            3'b000: begin  // R-type
                case (fn3)
                    3'b000: alu_control = fn7_5 ? 4'b0001 : 4'b0000;
                    3'b001: alu_control = 4'b0101;
                    3'b010: alu_control = 4'b1000;
                    3'b011: alu_control = 4'b1001;
                    3'b100: alu_control = 4'b0100;
                    3'b101: alu_control = fn7_5 ? 4'b0111 : 4'b0110;
                    3'b110: alu_control = 4'b0011;
                    3'b111: alu_control = 4'b0010;
                    default: alu_control = 4'b0000;
                endcase
            end

            3'b001: begin  // I-type ALU operations
                case (fn3)
                    3'b000: alu_control = 4'b0000; // ADDI
                    3'b010: alu_control = 4'b1000; // SLTI
                    3'b011: alu_control = 4'b1001; // SLTIU
                    3'b100: alu_control = 4'b0100; // XORI
                    3'b110: alu_control = 4'b0011; // ORI
                    3'b111: alu_control = 4'b0010; // ANDI
                    3'b001: alu_control = 4'b0101; // SLLI
                    3'b101: alu_control = fn7_5 ? 4'b0111 : 4'b0110;
                    default: alu_control = 4'b0000;
                endcase
            end

            3'b010: alu_control = 4'b0000; // Load: address calculation
            3'b011: alu_control = 4'b0000; // Store: address calculation
            3'b100: alu_control = 4'b0001; // Branch: subtraction
            3'b101: alu_control = 4'b0000; // JAL/JALR address calculation
            3'b110: alu_control = 4'b1010; // LUI: pass B

            default: alu_control = 4'b0000;

        endcase
    end

endmodule
