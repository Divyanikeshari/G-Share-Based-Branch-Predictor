// Code your design here
module gshare_branch_predictor (
    input clk,
    input reset,
    input [7:0] pc,           // 8-bit Program Counter
    input branch_taken,       // Actual branch outcome
    output reg predict_taken  // Predicted outcome
);
    
    parameter GHR_WIDTH = 8;  // Number of bits in Global History Register
    parameter PHT_SIZE = 256; // Pattern History Table (2^8 entries)

    reg [GHR_WIDTH-1:0] GHR;    // Global History Register
    reg [1:0] PHT [PHT_SIZE-1:0]; // 2-bit saturating counter table

    wire [7:0] index;
    integer i;
    // XOR PC with GHR to generate PHT index
    assign index = pc ^ GHR;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            
            GHR <= 0;
            for (i = 0; i < PHT_SIZE; i = i + 1) 
                PHT[i] <= 2'b10; // Initialize to Weakly Taken
        end 
        else begin
            case (PHT[index]) 
                2'b00: predict_taken <= 0; // Strongly Not Taken
                2'b01: predict_taken <= 0; // Weakly Not Taken
                2'b10: predict_taken <= 1; // Weakly Taken
                2'b11: predict_taken <= 1; // Strongly Taken
            endcase

            // Update logic based on actual branch outcome
            if (branch_taken) begin
                if (PHT[index] != 2'b11) 
                    PHT[index] <= PHT[index] + 1; // move toward Taken
            end 
            else begin
                if (PHT[index] != 2'b00) 
                    PHT[index] <= PHT[index] - 1; // move toward Not Taken
            end

            // Update GHR (shift left and insert new outcome)
            GHR <= {GHR[GHR_WIDTH-2:0], branch_taken};
        end
    end
endmodule
