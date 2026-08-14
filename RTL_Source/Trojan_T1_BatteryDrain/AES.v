module AES(
    input clk,
    input rst,
    input start,
    input key_valid,
    input data_valid,
    input [127:0] in,
    input [255:0] key256,
    output reg [127:0] e256,
    output reg [127:0] d256,
    output wire signal
);

    // Intermediate combinational wires
    wire [127:0] encrypted256;
    wire [127:0] decrypted256;

    // Instantiate combinational AES Encrypt and Decrypt modules
    AES_Encrypt #(256,14,8) c(in, key256, encrypted256);
    AES_Decrypt #(256,14,8) c2(encrypted256, key256, decrypted256);

    // Register the outputs
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            e256 <= 0;
            d256 <= 0;
        end 
        else if (start && key_valid && data_valid) begin
            e256 <= encrypted256;
            d256 <= decrypted256;
        end
    end

    // Match logic - combinational
    assign signal = (in == d256);

endmodule
