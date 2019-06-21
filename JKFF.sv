`timescale 1ns / 1ps

// JKFF.sv
// JK Flip-Flop that sets Q to 1 if J is 1 and Q to 0 is K is 1

module JKFF(

    input clk,          //clock input
    input J,            //input that makes Q 1
    input K,            //input that makes Q 0
    output logic Q = 0  //output
    
    );
    
    always_ff @ (posedge clk)
    
    begin
        
        if (J)
            Q = 1;
        else if (K)
            Q = 0;
            
    end
    
endmodule
