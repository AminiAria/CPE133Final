`timescale 1ns / 1ps

// TFF.sv
// T Flip-Flop that is designed to be used with a button
// Every time the button (T) is pressed, the output Q is toggled
// it remembers the previous state so that Q will on be
// changed once if the button is held down

module TFF(

    input clk,          //clock input
    input T,            //toggle input
    output logic Q = 0  //output
    
    );
    
    logic S;            //stores the previous state of T
    
    always_ff @ (posedge clk)
    begin
        if (T && !S)    //only toggle Q if T is pressed and the previous state of T was 0
            Q = !Q;
        S = T;
    end
    
endmodule