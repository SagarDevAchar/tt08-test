module text_tt08(
    output reg overlay_active,
    input wire [9:0] x, y,
    input wire clk
    );
    
    parameter [21:0] tt08_line0 = 22'b0000000000000001111100;
    parameter [21:0] tt08_line1 = 22'b0000000000000010000010;
    parameter [21:0] tt08_line2 = 22'b0111000111000100011111;
    parameter [21:0] tt08_line3 = 22'b1000101001100100001000;
    parameter [21:0] tt08_line4 = 22'b0111001010100101111001;
    parameter [21:0] tt08_line5 = 22'b1000101100100100101001;
    parameter [21:0] tt08_line6 = 22'b0111000111000100100001;
    parameter [21:0] tt08_line7 = 22'b0000000000000010100010;
    parameter [21:0] tt08_line8 = 22'b0000000000000000111100;
    
    wire [5:0] tt08_off_y;
    wire [6:0] tt08_off_x;
    
    assign tt08_off_y = y[8:3] - 24;
    assign tt08_off_x = x[9:3] - 30;
        
    always @(posedge clk) begin
        if (tt08_off_x < 23) begin
            case (tt08_off_y)
                6'd0: overlay_active <= tt08_line0[tt08_off_x];
                6'd1: overlay_active <= tt08_line1[tt08_off_x];
                6'd2: overlay_active <= tt08_line2[tt08_off_x];
                6'd3: overlay_active <= tt08_line3[tt08_off_x];
                6'd4: overlay_active <= tt08_line4[tt08_off_x];
                6'd5: overlay_active <= tt08_line5[tt08_off_x];
                6'd6: overlay_active <= tt08_line6[tt08_off_x];
                6'd7: overlay_active <= tt08_line7[tt08_off_x];
                6'd8: overlay_active <= tt08_line8[tt08_off_x];
                default: overlay_active <= 0;
            endcase
        end
    end
endmodule
