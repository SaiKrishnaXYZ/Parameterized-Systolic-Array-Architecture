`timescale 1ns / 1ps

module tb_systolic_array;

    // Parameters (Keeping DATA_WIDTH at 8)
    parameter DATA_WIDTH = 8;
    parameter SIZE       = 4;

    // Testbench Signals
    reg clock;
    reg rst;
    reg signed [SIZE*DATA_WIDTH-1:0] a_in;
    reg signed [SIZE*DATA_WIDTH-1:0] b_in;
    wire signed [SIZE*SIZE*DATA_WIDTH-1:0] c_out;

    // Instantiate the Unit Under Test (UUT)
    systolic_array #(
        .DATA_WIDTH(DATA_WIDTH),
        .SIZE(SIZE)
    ) uut (
        .clock(clock),
        .rst(rst),
        .a_in(a_in),
        .b_in(b_in),
        .c_out(c_out)
    );

    // Clock Generation (50MHz -> 20ns period)
    always #10 clock = ~clock;

    // Variables for formatting output display
    integer i, j;
    reg signed [DATA_WIDTH-1:0] matrix_c [0:SIZE-1][0:SIZE-1];

    initial begin
        // Initialize Signals
        clock = 0;
        rst = 1;
        a_in = 0;
        b_in = 0;

        // Hold reset active for 2 clock cycles
        repeat(2) @(posedge clock);
        #1; rst = 0;
        $display("--- Starting Safe Range Non-Symmetric Evaluation ---");

        // Cycle 0: Col 0 of A, Row 0 of B
        @(posedge clock); #1;
        a_in = {8'd4, 8'd3, 8'd2, 8'd1}; 
        b_in = {8'd0, 8'd0, 8'd0, 8'd1};

        // Cycle 1: Col 1 of A, Row 1 of B
        @(posedge clock); #1;
        a_in = {8'd5, 8'd4, 8'd3, 8'd2}; 
        b_in = {8'd0, 8'd0, 8'd0, 8'd1};

        // Cycle 2: Col 2 of A, Row 2 of B
        @(posedge clock); #1;
        a_in = {8'd6, 8'd5, 8'd4, 8'd3}; 
        b_in = {8'd0, 8'd0, 8'd0, 8'd1};

        // Cycle 3: Col 3 of A, Row 3 of B
        @(posedge clock); #1;
        a_in = {8'd7, 8'd6, 8'd5, 8'd4}; 
        b_in = {8'd0, 8'd0, 8'd0, 8'd1};

        // Pipeline Flush Phase
        @(posedge clock); #1;
        a_in = 0;
        b_in = 0;

        // Wait for final accumulation values to settle completely inside PEs
        repeat(10) @(posedge clock);

        // Unpack output bus from 1D back to a readable 2D matrix layout
        for (i = 0; i < SIZE; i = i + 1) begin
            for (j = 0; j < SIZE; j = j + 1) begin
                matrix_c[i][j] = c_out[(i*SIZE + j)*DATA_WIDTH +: DATA_WIDTH];
            end
        end

        // Display Result in Terminal Log
        $display("\n--- Final Matrix C Result (No Overflow) ---");
        for (i = 0; i < SIZE; i = i + 1) begin
            $display("[%3d, %3d, %3d, %3d]", matrix_c[i][0], matrix_c[i][1], matrix_c[i][2], matrix_c[i][3]);
        end
        $display("--------------------------------------------");

        $finish;
    end

endmodule