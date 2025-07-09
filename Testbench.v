`timescale 1ns / 1ps

module gshare_branch_predictor_tb;
    reg clk, reset;
    reg [7:0] pc;
    reg branch_taken;
    wire predict_taken;

    // Track GHR for verification 
    reg [7:0] GHR_track; 

    gshare_branch_predictor uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .branch_taken(branch_taken),
        .predict_taken(predict_taken)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with 10ns period
    end

    initial begin
        reset = 1;
        GHR_track = 0; // Initialize GHR tracking
        #10 reset = 0;

        $display("\t\t\t\tTime | PC | Branch Taken | Predict Taken|  GHR     | PHT Index");
        $monitor("%4t | %h | %b            | %b            | %8b | %h",
                 $time, pc, branch_taken, predict_taken, GHR_track, pc ^ GHR_track);

        // Test sequence
        @(posedge clk);
        pc = 8'h12; branch_taken = 1; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h12; branch_taken = 1; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h34; branch_taken = 1; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h34; branch_taken = 0; #10;
        GHR_track = {GHR_track[6:0], branch_taken};

        @(posedge clk);
        pc = 8'h12; branch_taken =1 ; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10;
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; // Back to previous branch
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 1; #10; // Back to previous branch
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; // Back to previous branch
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
        @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
         @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
         @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
         @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
         @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
         @(posedge clk);
        pc = 8'h12; branch_taken = 0; #10; 
        GHR_track = {GHR_track[6:0], branch_taken};
        
        #20 $finish;
    end
endmodule
