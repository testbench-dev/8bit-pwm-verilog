`timescale 1ns/1ps
module tb_pwm8;

    // Clock generation (100 MHz)
    reg clk = 1'b0;
    always #5 clk = ~clk;

    // DUT I/O
    reg  rst_n;
    reg  [7:0] duty_in;
    reg  duty_we;
    wire pwm_out;
    wire [7:0] ctr = uut.ctr; // expose counter for alignment

    // Instantiate the PWM (from rtl/pwm8.v)
    pwm8 uut (
        .clk    (clk),
        .rst_n  (rst_n),
        .duty_in(duty_in),
        .duty_we(duty_we),
        .pwm_out(pwm_out)
    );

    // helper task: advance one clock
    task step; @(posedge clk); endtask

    integer hi, i;

    initial begin
        // Reset
        rst_n    = 0;
        duty_we  = 0;
        duty_in  = 0;
        step; step;
        rst_n    = 1;

        // ------ 25% duty (64/256) ------
        duty_in = 8'd64; duty_we = 1; step; duty_we = 0;
        // wait for counter to wrap to 0
        while (ctr != 8'd0) step;
        // count high cycles for one full frame
        hi = 0;
        for (i = 0; i < 256; i = i + 1) begin
            if (pwm_out) hi = hi + 1;
            step;
        end
        if (hi !== 64) $fatal("FAIL: 25%% duty expected=64 got=%0d", hi);

        // ------ 50% duty (128/256) ------
        duty_in = 8'd128; duty_we = 1; step; duty_we = 0;
        while (ctr != 8'd0) step;
        hi = 0;
        for (i = 0; i < 256; i = i + 1) begin
            if (pwm_out) hi = hi + 1;
            step;
        end
        if (hi !== 128) $fatal("FAIL: 50%% duty expected=128 got=%0d", hi);

        // ------ 90% duty (230/256) ------
        duty_in = 8'd230; duty_we = 1; step; duty_we = 0;
        while (ctr != 8'd0) step;
        hi = 0;
        for (i = 0; i < 256; i = i + 1) begin
            if (pwm_out) hi = hi + 1;
            step;
        end
        if (hi !== 230) $fatal("FAIL: 90%% duty expected=230 got=%0d", hi);

        $display("\nPWM TEST PASSED.");
        #20 $finish;
    end
endmodule
