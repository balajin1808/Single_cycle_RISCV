`timescale 1ns / 1ps

module decoder(
    input  logic [31:0] instruction,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [4:0]  rd,
    output logic [6:0]  opcode,
    output logic [6:0]  imm11_5,
    output logic [2:0]  fn3,
    output logic [11:0] imm,
    output logic [19:0] imm_ui,
    output logic [12:0] imm_b,
    output logic [20:0] imm_j,
    output logic        fn7_5
);

always_comb begin

    rs1     = 5'd0;
    rs2     = 5'd0;
    rd      = 5'd0;
    fn3     = 3'd0;
    imm     = 12'd0;
    imm_ui  = 20'd0;
    imm_b   = 13'd0;
    imm_j   = 21'd0;
    imm11_5 = 7'd0;
    fn7_5   = 1'b0;

    opcode = instruction[6:0];

    case (opcode)

        7'b0110011: begin
            rd      = instruction[11:7];
            fn3     = instruction[14:12];
            rs1     = instruction[19:15];
            rs2     = instruction[24:20];
            imm11_5 = instruction[31:25];
            fn7_5   = instruction[30];
        end

        7'b0010011: begin
            rd  = instruction[11:7];
            fn3 = instruction[14:12];
            rs1 = instruction[19:15];
            imm = instruction[31:20];
            imm11_5 = instruction[31:25];
            fn7_5 = instruction[30];
        end

        7'b0000011: begin
            rd  = instruction[11:7];
            fn3 = instruction[14:12];
            rs1 = instruction[19:15];
            imm = instruction[31:20];
        end

        7'b1100111: begin
            rd  = instruction[11:7];
            fn3 = instruction[14:12];
            rs1 = instruction[19:15];
            imm = instruction[31:20];
        end
        
        7'b1110011: begin
            rd  = instruction[11:7];
            fn3 = instruction[14:12];
            rs1 = instruction[19:15];
            imm = instruction[31:20];
        end

        7'b0100011: begin
            fn3     = instruction[14:12];
            rs1     = instruction[19:15];
            rs2     = instruction[24:20];
            imm11_5 = instruction[31:25];
            imm     = {instruction[31:25],
                       instruction[11:7]};
        end

        7'b1100011: begin
            fn3   = instruction[14:12];
            rs1   = instruction[19:15];
            rs2   = instruction[24:20];

            imm_b = {instruction[31],
                     instruction[7],
                     instruction[30:25],
                     instruction[11:8],
                     1'b0};
        end

        7'b0110111: begin
            rd     = instruction[11:7];
            imm_ui = instruction[31:12];
        end

        7'b0010111: begin
            rd     = instruction[11:7];
            imm_ui = instruction[31:12];
        end

        7'b1101111: begin
            rd = instruction[11:7];

            imm_j = {instruction[31],
                     instruction[19:12],
                     instruction[20],
                     instruction[30:21],
                     1'b0};
        end

        default: begin
        end

    endcase

end

endmodule