module text_sda(
    output reg overlay_active,
    input wire [9:0] x, y,
    input wire clk
    );
    
    parameter [59:0] sda_line0 = 60'b000000000001000000100000000000110000000000000000001100011100;
    parameter [59:0] sda_line1 = 60'b000000000001000001010000000001010000000000000000000010100010;
    parameter [59:0] sda_line2 = 60'b000000000001000001010000000001010000000000000000000010101001;
    parameter [59:0] sda_line3 = 60'b101001100111011001110101011001010101001100110011000100110101;
    parameter [59:0] sda_line4 = 60'b011001010101000101010101010101010011001010101010101000001001;
    parameter [59:0] sda_line5 = 60'b001001010101000101010101000101010001001010101010101000100010;
    parameter [59:0] sda_line6 = 60'b001011100101011001010010011000110001011100110111000110011100;
    parameter [59:0] sda_line7 = 60'b000000000000000000000000000000000000000000100000000000000000;
    parameter [59:0] sda_line8 = 60'b000000000000000000000000000000000000000000101000000000000000;
    parameter [59:0] sda_line9 = 60'b000000000000000000000000000000000000000000010000000000000000;
    
    wire [6:0] sda_off_x;
    wire [5:0] sda_off_y;
    
    assign sda_off_x = x[9:3] - 11;
    assign sda_off_y = y[8:3] - 38;
    
    always @(posedge clk) begin
        if (sda_off_x < 61) begin
            case (sda_off_y)
                6'd0: overlay_active <= sda_line0[sda_off_x];
                6'd1: overlay_active <= sda_line1[sda_off_x];
                6'd2: overlay_active <= sda_line2[sda_off_x];
                6'd3: overlay_active <= sda_line3[sda_off_x];
                6'd4: overlay_active <= sda_line4[sda_off_x];
                6'd5: overlay_active <= sda_line5[sda_off_x];
                6'd6: overlay_active <= sda_line6[sda_off_x];
                6'd7: overlay_active <= sda_line7[sda_off_x];
                6'd8: overlay_active <= sda_line8[sda_off_x];
                6'd9: overlay_active <= sda_line9[sda_off_x];
                default: overlay_active <= 0;
            endcase
        end
    end
endmodule
