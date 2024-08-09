module graphics_engine(
    output wire [1:0] r, g, b,
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
