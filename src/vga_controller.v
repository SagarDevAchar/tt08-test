// Derived from TinyTapeout/vga-playground/blob/main/src/examples/common/hvsync_generator.v
// Just some refactoring to maintain coding style

`ifndef VGA_CONTROLLER_H
`define VGA_CONTROLLER_H

module vga_controller (
    output reg [9:0] x, y,
    output reg h_sync, v_sync,
    output reg frame_active,
    input wire clk, rst_n
    );

    // declarations for TV-simulator sync parameters
    // horizontal constants
    parameter W_DISPLAY       = 640; // horizontal display width
    parameter W_BACK          =  48; // horizontal left border (back porch)
    parameter W_FRONT         =  16; // horizontal right border (front porch)
    parameter W_SYNC          =  96; // horizontal sync width
    // vertical constants
    parameter H_DISPLAY       = 480; // vertical display height
    parameter H_TOP           =  33; // vertical top border
    parameter H_BOTTOM        =  10; // vertical bottom border
    parameter H_SYNC          =   2; // vertical sync # lines
    // derived constants
    parameter W_SYNC_START    = W_DISPLAY + W_FRONT;
    parameter W_SYNC_END      = W_DISPLAY + W_FRONT + W_SYNC - 1;
    parameter W_MAX           = W_DISPLAY + W_BACK + W_FRONT + W_SYNC - 1;
    parameter H_SYNC_START    = H_DISPLAY + H_BOTTOM;
    parameter H_SYNC_END      = H_DISPLAY + H_BOTTOM + H_SYNC - 1;
    parameter H_MAX           = H_DISPLAY + H_TOP + H_BOTTOM + H_SYNC - 1;
    
    wire hmaxxed = (x == W_MAX) || rst_n;	// set when x is maximum
    wire vmaxxed = (y == H_MAX) || rst_n;	// set when y is maximum
    
    // horizontal position counter
    always @(posedge clk) begin
        h_sync <= (x >= W_SYNC_START && x <= W_SYNC_END);
        if(hmaxxed)
            x <= 0;
        else
            x <= x + 1;
    end
    
    // vertical position counter
    always @(posedge clk) begin
        v_sync <= (y >= H_SYNC_START && y <= H_SYNC_END);
        if(hmaxxed)
            if (vmaxxed)
                y <= 0;
            else
                y <= y + 1;
    end
    
    // frame_active is set when beam is in "safe" visible frame
    assign frame_active = (x < W_DISPLAY) && (y < H_DISPLAY);

endmodule

`endif
