module text_demosiine(
    output reg overlay_active,
    input wire [9:0] x, y,
    input wire clk
    );
    
    parameter [45:0] demosiine_line0 = 46'b0000000000000000001110000000000000000000001111;
    parameter [45:0] demosiine_line1 = 46'b0000000000000000000001000000000000000000010001;
    parameter [45:0] demosiine_line2 = 46'b0000000000000000000000100000000000000000100001;
    parameter [45:0] demosiine_line3 = 46'b0000000000000000000000100000000000000000100001;
    parameter [45:0] demosiine_line4 = 46'b1111010010111011100111000110010001011110100001;
    parameter [45:0] demosiine_line5 = 46'b0001010110010001001000001001011011000010100001;
    parameter [45:0] demosiine_line6 = 46'b0111011010010001001000001001010101001110100001;
    parameter [45:0] demosiine_line7 = 46'b0001010010010001000100001001010001000010010001;
    parameter [45:0] demosiine_line8 = 46'b1111010010111011100011100110010001011110001111;
    
    wire [5:0] demosiine_off_y;
    wire [6:0] demosiine_off_x;
    
    assign demosiine_off_y = y[8:3] - 12;
    assign demosiine_off_x = x[9:3] - 18;
        
    always @(posedge clk) begin
        if (demosiine_off_x < 47) begin
            case (demosiine_off_y)
                6'd0: overlay_active <= demosiine_line0[demosiine_off_x];
                6'd1: overlay_active <= demosiine_line1[demosiine_off_x];
                6'd2: overlay_active <= demosiine_line2[demosiine_off_x];
                6'd3: overlay_active <= demosiine_line3[demosiine_off_x];
                6'd4: overlay_active <= demosiine_line4[demosiine_off_x];
                6'd5: overlay_active <= demosiine_line5[demosiine_off_x];
                6'd6: overlay_active <= demosiine_line6[demosiine_off_x];
                6'd7: overlay_active <= demosiine_line7[demosiine_off_x];
                6'd8: overlay_active <= demosiine_line8[demosiine_off_x];
                default: overlay_active <= 0;
            endcase
        end
    end
endmodule
