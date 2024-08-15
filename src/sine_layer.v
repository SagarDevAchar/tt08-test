module sine_layer(
    output wire overlay_active,
    input wire [9:0] x, y
    );
    
    parameter [15:0] qsine_line00 = 16'b1100000000000000;
    parameter [15:0] qsine_line01 = 16'b0011100000000000;
    parameter [15:0] qsine_line02 = 16'b0000011000000000;
    parameter [15:0] qsine_line03 = 16'b0000000110000000;
    parameter [15:0] qsine_line04 = 16'b0000000001000000;
    parameter [15:0] qsine_line05 = 16'b0000000000100000;
    parameter [15:0] qsine_line06 = 16'b0000000000010000;
    parameter [15:0] qsine_line07 = 16'b0000000000001000;
    parameter [15:0] qsine_line08 = 16'b0000000000000100;
    parameter [15:0] qsine_line09 = 16'b0000000000000010;
    parameter [15:0] qsine_line10 = 16'b0000000000000001;
    parameter [15:0] qsine_line11 = 16'b0000000000000001;
    
    wire [9:0] qsine_off_x;
    wire [8:0] qsine_off_y;
    
    reg qsine_active;
    
    assign qsine_off_x = x - 374;
    assign qsine_off_y = y[8:0] - 96;
    
    always @(*) begin
        case (qsine_off_x[5] ? 24 - qsine_off_y : qsine_off_y)
            9'h0: qsine_active = qsine_line00[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h1: qsine_active = qsine_line01[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h2: qsine_active = qsine_line02[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h3: qsine_active = qsine_line03[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h4: qsine_active = qsine_line04[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h5: qsine_active = qsine_line05[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h6: qsine_active = qsine_line06[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h7: qsine_active = qsine_line07[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h8: qsine_active = qsine_line08[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'h9: qsine_active = qsine_line09[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'hA: qsine_active = qsine_line10[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];
            9'hB: qsine_active = qsine_line11[qsine_off_x[4] ? 31 - qsine_off_x[5:0] : qsine_off_x[5:0]];   
            default: qsine_active = 0;
        endcase
    end
    
    // TODO: 128, so optimizable by binary
    assign overlay_active = (qsine_off_x < 128) & qsine_active;
endmodule
