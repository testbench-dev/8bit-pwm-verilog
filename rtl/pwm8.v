// pwm8.v  –  8-bit PWM, pure Verilog-2001
module pwm8
  #(parameter WIDTH = 8)
(
    input               clk,
    input               rst_n,     // async active-low reset
    input  [WIDTH-1:0]  duty_in,   // 0-255 duty
    input               duty_we,   // write-enable (1-cycle pulse)
    output              pwm_out
);

    // ------------------------------------------------------------
    // 8-bit free-running counter 0-255
    // ------------------------------------------------------------
    reg [WIDTH-1:0] ctr;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            ctr <= {WIDTH{1'b0}};
        else
            ctr <= ctr + 1'b1;      // wraps automatically

    // ------------------------------------------------------------
    // Double-buffered duty registers (glitch-free update)
    // ------------------------------------------------------------
    reg [WIDTH-1:0] duty_next, duty_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            duty_next <= {WIDTH{1'b0}};
            duty_reg  <= {WIDTH{1'b0}};
        end else begin
            if (duty_we)          duty_next <= duty_in;   // capture any time
            if (ctr == {WIDTH{1'b1}})  // ctr == 255
                duty_reg <= duty_next;                    // load on frame edge
        end
    end

    // ------------------------------------------------------------
    // Comparator produces PWM
    // ------------------------------------------------------------
    assign pwm_out = (ctr < duty_reg);

endmodule
