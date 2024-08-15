module overlay_creator(
    output wire [5:0] overlay_rgb,
    output wire overlay_active,
    input wire [9:0] x, y,
    input wire frame_active, clk, rst_n
    );
    
    wire [9:0] x_shadow, y_shadow;
    wire text_active;
    wire text_demosiine_active, text_demosiine_main_active, text_demosiine_shadow_active;
    wire text_tt08_active, text_tt08_main_active, text_tt08_shadow_active;
    wire text_sda_active, text_sda_main_active, text_sda_shadow_active;
    wire sine_layer_active, sine_layer_v_active, sine_layer_i_active, sine_layer_b_active, sine_layer_g_active, sine_layer_y_active, sine_layer_o_active, sine_layer_r_active, sine_layer_w_active;
    wire [5:0] demosiine_rgb, tt08_rgb, sda_rgb, sine_rgb;
    
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
    
    sine_layer sine_layer_w (
        .overlay_active(sine_layer_w_active),
        .x(x), .y(y)
    );
    
    sine_layer sine_layer_r (
        .overlay_active(sine_layer_r_active),
        .x(x-1), .y(y)
    );
    
    sine_layer sine_layer_o (
        .overlay_active(sine_layer_o_active),
        .x(x-2), .y(y)
    );
    
    sine_layer sine_layer_y (
        .overlay_active(sine_layer_y_active),
        .x(x-3), .y(y)
    );
    
    sine_layer sine_layer_g (
        .overlay_active(sine_layer_g_active),
        .x(x-4), .y(y)
    );
    sine_layer sine_layer_b (
        .overlay_active(sine_layer_b_active),
        .x(x-5), .y(y)
    );
    sine_layer sine_layer_i (
        .overlay_active(sine_layer_i_active),
        .x(x-6), .y(y)
    );
    sine_layer sine_layer_v (
        .overlay_active(sine_layer_v_active),
        .x(x-7), .y(y)
    );
    
    assign demosiine_rgb = text_demosiine_main_active ? 6'b11_11_11 : {1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active, 1'b0, text_demosiine_shadow_active};
    assign tt08_rgb = text_tt08_main_active ? 6'b11_11_11 : {1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active, 1'b0, text_tt08_shadow_active};
    assign sda_rgb = text_sda_main_active ? 6'b11_11_11 : {1'b0, text_sda_shadow_active, 1'b0, text_sda_shadow_active, 1'b0, text_sda_shadow_active};
    assign sine_rgb = sine_layer_w_active ? 6'b11_11_11 : 
                        sine_layer_r_active ? 6'b11_00_00 :
                            sine_layer_o_active ? 6'b11_10_00 :
                                sine_layer_y_active ? 6'b11_11_00 :
                                    sine_layer_g_active ? 6'b00_11_00 :
                                        sine_layer_b_active ? 6'b00_10_11 :
                                            sine_layer_i_active ? 6'b00_00_11 :
                                                sine_layer_v_active ? 6'b10_00_11 : 6'b00_00_00;
    
    assign text_demosiine_active = |{text_demosiine_main_active, text_demosiine_shadow_active};
    assign text_tt08_active = |{text_tt08_main_active, text_tt08_shadow_active};
    assign text_sda_active = |{text_sda_main_active, text_sda_shadow_active};
    assign text_active = text_demosiine_active | text_tt08_active | text_sda_active;
    assign sine_layer_active = |{sine_layer_v_active, sine_layer_i_active, sine_layer_b_active, sine_layer_g_active, sine_layer_y_active, sine_layer_o_active, sine_layer_r_active, sine_layer_w_active};
    
    assign overlay_rgb = sine_layer_active ? sine_rgb :
                            (text_demosiine_active ? demosiine_rgb :
                                (text_tt08_active ? tt08_rgb : 
                                    (text_sda_active ? sda_rgb : 6'd0)));
    assign overlay_active = text_active | sine_layer_active;
    
endmodule
