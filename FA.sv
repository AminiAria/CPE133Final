`timescale 1ns / 1ps

// FA.sv
// Adds three bits A, B, and Ci and outputs 
// a two bit number where the MSB is Co and LSB is S

module FA(

    input A,        //first operand
    input B,        //second operand
    input Ci,       //carry in 
    output S,       //sum
    output Co       //carry out
    
    );
    
    assign S =  A ^ (B ^ Ci);                   //calculate S
    assign Co = (A & B) | (A & Ci) | (B * Ci);  //calculate Co
    
endmodule
