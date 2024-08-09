module overlay_creator(
    output wire [5:0] overlay_rgb,
    output wire overlay_active,
    input wire [9:0] x, y,
    input wire frame_active, clk, rst_n
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
    
    assign overlay_active = |(overlay_rgb);
    
    wire [9:0] x_shadow, y_shadow;
    wire text_active;
    wire text_demosiine_active, text_demosiine_main_active, text_demosiine_shadow_active;
    wire text_tt08_active, text_tt08_main_active, text_tt08_shadow_active;
    wire text_sda_active, text_sda_main_active, text_sda_shadow_active;
    wire [5:0] demosiine_rgb, tt08_rgb, sda_rgb;
    
    assign x_shadow = x - 4;
    assign y_shadow = y - 4;
    
    text_demosiine text_demosiine1 (
        .overlay_active(text_demosiine_main_active),
        .x(x), .y(y)
    );
    
    text_demosiine text_demosiine2 (
        .overlay_active(text_demosiine_shadow_active),
        .x(x_shadow), .y(y_shadow)
    );
    
    text_tt08 text_tt081 (
        .overlay_active(text_tt08_main_active),
        .x(x), .y(y)
    );
    
    text_tt08 text_tt082 (
        .overlay_active(text_tt08_shadow_active),
        .x(x_shadow), .y(y_shadow)
    );
    
    text_sda text_sda1 (
        .overlay_active(text_sda_main_active),
        .x(x), .y(y)
    );
    
    text_sda text_sda2 (
        .overlay_active(text_sda_shadow_active),
        .x(x_shadow), .y(y_shadow)
    );
    
    assign demosiine_rgb = text_demosiine_main_active ? 6'b11_11_11 : {1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active};
    assign tt08_rgb = text_tt08_main_active ? 6'b11_11_11 : {1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active};
    assign sda_rgb = text_sda_main_active ? 6'b11_11_11 : {1'b0, text_sda_shadow_active, 1'b0, text_sda_shadow_active, 1'b0, text_sda_shadow_active};
    
    assign text_demosiine_active = text_demosiine_main_active | text_demosiine_shadow_active;
    assign text_tt08_active = text_tt08_main_active | text_tt08_shadow_active;
    assign text_sda_active = text_sda_main_active | text_sda_shadow_active;
    assign text_active = text_demosiine_active | text_tt08_active;
    
    assign overlay_rgb = text_demosiine_active ? demosiine_rgb :
                            (text_tt08_active ? tt08_rgb : 
                                (text_sda_active ? sda_rgb : 6'd0));
    
endmodule
