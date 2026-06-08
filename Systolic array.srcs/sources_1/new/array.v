module systolic_array #(
    parameter DATA_WIDTH = 8,
    parameter SIZE       = 4
) (
    input wire clock,
    input wire rst,
    input wire signed [SIZE*DATA_WIDTH-1:0] a_in,
    input wire signed [SIZE*DATA_WIDTH-1:0] b_in,
    output wire signed [SIZE*SIZE*DATA_WIDTH-1:0] c_out
);

    reg signed [DATA_WIDTH-1:0] a_delay [0:SIZE-1][0:SIZE-1];
    reg signed [DATA_WIDTH-1:0] b_delay [0:SIZE-1][0:SIZE-1];

    integer r, c;
    always @(posedge clock) begin
        if (rst) begin
            for (r = 0; r < SIZE; r = r + 1) begin
                for (c = 0; c < SIZE; c = c + 1) begin
                    a_delay[r][c] <= {DATA_WIDTH{1'b0}};
                    b_delay[r][c] <= {DATA_WIDTH{1'b0}};
                end
            end
        end else begin
            for (r = 1; r < SIZE; r = r + 1) begin
                a_delay[r][0] <= a_in[r*DATA_WIDTH +: DATA_WIDTH];
                b_delay[r][0] <= b_in[r*DATA_WIDTH +: DATA_WIDTH];
                for (c = 1; c < SIZE; c = c + 1) begin
                    a_delay[r][c] <= a_delay[r][c-1];
                    b_delay[r][c] <= b_delay[r][c-1];
                end
            end
        end
    end

    wire signed [DATA_WIDTH-1:0] a_net [0:SIZE-1][0:SIZE];
    wire signed [DATA_WIDTH-1:0] b_net [0:SIZE][0:SIZE-1];
    wire signed [DATA_WIDTH-1:0] c_net [0:SIZE-1][0:SIZE-1];

    genvar i, j;
    generate
        for (i = 0; i < SIZE; i = i + 1) begin : input_routing
            if (i == 0) begin
                assign a_net[0][0] = a_in[0 +: DATA_WIDTH];
                assign b_net[0][0] = b_in[0 +: DATA_WIDTH];
            end else begin
                assign a_net[i][0] = a_delay[i][i-1];
                assign b_net[0][i] = b_delay[i][i-1];
            end
        end
    endgenerate

    generate
        for (i = 0; i < SIZE; i = i + 1) begin : row
            for (j = 0; j < SIZE; j = j + 1) begin : col
                sys_pe #(.DATA_WIDTH(DATA_WIDTH)) pe_inst (
                    .clock(clock),
                    .rst(rst),
                    .a(a_net[i][j]),
                    .b(b_net[i][j]),
                    .aout(a_net[i][j+1]),
                    .bout(b_net[i+1][j]),
                    .cout(c_net[i][j])
                );
                assign c_out[(i*SIZE + j)*DATA_WIDTH +: DATA_WIDTH] = c_net[i][j];
            end
        end
    endgenerate

endmodule