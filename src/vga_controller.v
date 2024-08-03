module vga_controller (
    output reg [9:0] x, y,
    output reg h_sync, v_sync,
    output reg frame_active,
    input wire clk, rst_n
    );

    always @ (posedge clk) begin
        if (~rst_n) begin
            x <= 10'b0;
            y <= 10'b0;
        end
        else begin
            if (x < 10'd656)
                h_sync <= 1;
            else if (x < 10'd752)
                h_sync <= 0;
            else
                h_sync <= 1;
                
            if (y < 10'd490)
                v_sync <= 1;
            else if (y < 10'd492)
                v_sync <= 0;
            else
                v_sync <= 1;
            
            if (x == 10'd799) begin
                x <= 10'b0;
                y <= (y == 10'd520) ? 10'b0 : y + 10'b1;
            end
            else
                x <= x + 10'b1;
            
            frame_active <= (x < 640 && y < 480) ? 1 : 0;
        end
    end

endmodule
