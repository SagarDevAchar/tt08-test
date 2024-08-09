module overlay_creator(
    output wire [5:0] overlay_rgb,
    output wire overlay_active,
    input wire [9:0] x, y,
    input wire frame_active, clk, rst_n
    );
    
    // TODO: QSine Stuff
    
    assign overlay_active = |(overlay_rgb);
    
    wire [9:0] x_shadow, y_shadow;
    wire text_active;
    wire text_demosiine_active, text_demosiine_main_active, text_demosiine_shadow_active;
    wire text_tt08_active, text_tt08_main_active, text_tt08_shadow_active;
    wire [5:0] demosiine_rgb, tt08_rgb;
    
    assign x_shadow = x - 4;
    assign y_shadow = y - 4;
    
    text_demosiine text_demosiine1 (
        .overlay_active(text_demosiine_main_active),
        .x(x), .y(y),
        .clk(clk)
    );
    
    text_demosiine text_demosiine2 (
        .overlay_active(text_demosiine_shadow_active),
        .x(x_shadow), .y(y_shadow),
        .clk(clk)
    );
    
    text_tt08 text_tt081 (
        .overlay_active(text_tt08_main_active),
        .x(x), .y(y),
        .clk(clk)
    );
    
    text_tt08 text_tt082 (
        .overlay_active(text_tt08_shadow_active),
        .x(x_shadow), .y(y_shadow),
        .clk(clk)
    );
    
    assign demosiine_rgb = text_demosiine_main_active ? 6'b11_11_11 : {1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active};
    assign tt08_rgb = text_tt08_main_active ? 6'b11_11_11 : {1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active};
    
    assign text_demosiine_active = text_demosiine_main_active | text_demosiine_shadow_active;
    assign text_tt08_active = text_tt08_main_active | text_tt08_shadow_active;
    assign text_active = text_demosiine_active | text_tt08_active;
    
    assign overlay_rgb = text_demosiine_active ? demosiine_rgb :
                            (text_tt08_active ? tt08_rgb : 6'd0);
    
endmodule
