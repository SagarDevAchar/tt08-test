module graphics_engine(
    output wire [1:0] r, g, b,
    input wire [9:0] x, y,
    input wire frame_active, clk, rst_n
    );
    
    parameter [0:21] tt08_line0 = 22'b0011111000000000000000;
    parameter [0:21] tt08_line1 = 22'b0100000100000000000000;
    parameter [0:21] tt08_line2 = 22'b1111100010001110001110;
    parameter [0:21] tt08_line3 = 22'b0001000010011001010001;
    parameter [0:21] tt08_line4 = 22'b1001111010010101001110;
    parameter [0:21] tt08_line5 = 22'b1001010010010011010001;
    parameter [0:21] tt08_line6 = 22'b1000010010001110001110;
    parameter [0:21] tt08_line7 = 22'b0100010100000000000000;
    parameter [0:21] tt08_line8 = 22'b0011110000000000000000;
    
    wire [7:0] tt08_off_y, tt08_off_x;
    
    assign off_y = y[9:2] - 10;
    assign off_x = x[9:2] - 8;
    
    reg [5:0] rgb;
    assign r = rgb[5:4];
    assign g = rgb[3:2];
    assign b = rgb[1:0];
        
    always @(posedge clk) begin
        case (tt08_off_y)
            8'd0: rgb <= { 6{tt08_line0[tt08_off_x]} };
            8'd1: rgb <= { 6{tt08_line1[tt08_off_x]} };
            8'd2: rgb <= { 6{tt08_line2[tt08_off_x]} };
            8'd3: rgb <= { 6{tt08_line3[tt08_off_x]} };
            8'd4: rgb <= { 6{tt08_line4[tt08_off_x]} };
            8'd5: rgb <= { 6{tt08_line5[tt08_off_x]} };
            8'd6: rgb <= { 6{tt08_line6[tt08_off_x]} };
            8'd7: rgb <= { 6{tt08_line7[tt08_off_x]} };
            8'd8: rgb <= { 6{tt08_line8[tt08_off_x]} };
            default: rgb <= 0;
        endcase
    end
    
    // List all unused inputs to prevent warnings
    wire _unused = &{x[7:0], y[7:0], rst_n, 1'b0};
endmodule
