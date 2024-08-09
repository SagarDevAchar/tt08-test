module graphics_engine(
    output wire [1:0] r, g, b,
    input wire [9:0] x, y,
    input wire frame_active, clk, rst_n
    );
    
    wire [5:0] overlay_rgb;
    wire overlay_active;
    
    assign r = overlay_rgb[5:4];
    assign g = overlay_rgb[3:2];
    assign b = overlay_rgb[1:0];
    
    overlay_creator overlay_creator_1 (
        .overlay_rgb(overlay_rgb),
        .overlay_active(overlay_active),
        .x(x), .y(y),
        .frame_active(frame_active), .clk(clk), .rst_n(rst_n)
    );
    
    // List all unused inputs to prevent warnings
    wire _unused = &{x[7:0], y[7:0], rst_n, 1'b0};
endmodule
