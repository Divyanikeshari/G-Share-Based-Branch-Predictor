`timescale 1ns / 1ps

module gshare_branch_predictor_tb;
    reg clk, reset;
    reg [7:0] pc;
    reg branch_taken;
    wire predict_taken;

    gshare_branch_predictor uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .branch_taken(branch_taken),
        .predict_taken(predict_taken)
    );
    
    integer total_branches = 0;
    integer correct_predictions = 0;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with 10ns period
    end


    task test_branch;
        input [7:0] test_pc;
        input test_outcome;
        reg correct;
        reg [7:0] current_ghr;
        begin
            pc = test_pc;
            branch_taken = test_outcome;
            
            #4; 
            current_ghr = uut.GHR;
            correct = (predict_taken == test_outcome);
            
            $display("| %2h | %8b |%2h| %1b  |   %1b   |    %1s    |",
                    test_pc, current_ghr, uut.index, predict_taken, 
                    test_outcome, correct ? "Y" : "N"
                    );
                    
            #6; 
            total_branches = total_branches + 1;
            if (correct) correct_predictions = correct_predictions + 1;
        end
    endtask
    
    
    initial begin
        reset = 1;
        #10 reset = 0;

        repeat(5) test_branch(8'h10, 1);
        repeat(5) test_branch(8'h20, 0);
        repeat(5) begin
            test_branch(8'h30, 1);
            test_branch(8'h30, 0);
        end
        test_branch(8'h40, 1);  
        test_branch(8'h40, 1);   
        test_branch(8'h40, 0);  
        test_branch(8'h40, 0);  
        test_branch(8'h40, 1);  
        test_branch(8'h40, 0);  
        test_branch(8'h40, 1);  
        test_branch(8'h40, 0);  
        test_branch(8'h40, 1);  
        test_branch(8'h40, 1);  
        
        test_branch(8'h55, 1);  
        test_branch(8'hAA, 1);  
        test_branch(8'h55, 0);
        test_branch(8'hAA, 0);
        test_branch(8'h55, 1);
        test_branch(8'hAA, 1);
        test_branch(8'h55, 0);
        test_branch(8'hAA, 0);
        test_branch(8'h55, 1);
        test_branch(8'hAA, 1);
        
        test_branch(8'hC0, 1);
        test_branch(8'hD0, 0);
        test_branch(8'hE0, 1);
        test_branch(8'hF0, 1);
        test_branch(8'hC0, 0);
        test_branch(8'hD0, 1);
        test_branch(8'hE0, 0);
        test_branch(8'hF0, 1);
        test_branch(8'hC0, 1);
        test_branch(8'hD0, 0);

        #10;
        $display("Total branches    : %0d", total_branches);
        $display("Correct predictions: %0d", correct_predictions);
        
        #20 $finish;
    end
endmodule
