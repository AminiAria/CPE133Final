`timescale 1ns / 1ps

// DFF.sv
// D Flip-Flop register of variable size

module DFF # (parameter SIZE = 1) (

    input clk,                          //clock input
    input enter,                        //set Q to D
    input clr,                          //clear Q
    input [SIZE - 1:0] D,               //input
    input set,                          //set Q to all 1s
    output logic [SIZE - 1:0] Q = '0    //output
    
    );
    
    always_ff @ (posedge clk) //executes the following code on the positive edge of the clock
    
    begin
        
        if (clr)        //if clear is pressed, Q output is set to 0 (not used for the lab final)
            Q = '0;
        else if (set)   //if set is pressed, Q output set to 1 (not used for the lab final)
            Q = '1;
        else if (enter) //if enter pressed, D is set equal to Q
            Q = D;
            
    end
    
endmodule
