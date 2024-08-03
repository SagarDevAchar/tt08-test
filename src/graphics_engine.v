module graphics_engine(
    output [1:0] r, g, b,
    input wire [9:0] x, y,
    input wire frame_active, rst_n
    );
    
    assign r = x[9:8] & {2{frame_active}};
    assign g = y[9:8] & {2{frame_active}};
    assign b = x[9:8] & {2{frame_active}};
    
    
endmodule
