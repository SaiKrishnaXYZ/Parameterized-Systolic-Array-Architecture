
module sys_pe #( parameter DATA_WIDTH = 8 ) ( 
  input wire clock,
  input wire rst,
  input wire signed [DATA_WIDTH-1:0] a,
  input wire signed [DATA_WIDTH-1:0] b,
  output reg signed [DATA_WIDTH-1:0] aout,
  output reg signed [DATA_WIDTH-1:0] bout,
  output reg signed [DATA_WIDTH-1:0] cout
  );

  always @(posedge clock) begin
  if(rst) begin
   aout <= {DATA_WIDTH{1'b0}};
   bout <= {DATA_WIDTH{1'b0}};
   cout <= {DATA_WIDTH{1'b0}};
   end
  else begin
  aout <= a;
  bout <= b ;
  cout <= cout + (a*b) ;
  end
  end
  endmodule