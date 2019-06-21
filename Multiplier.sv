`timescale 1ns / 1ps

// Multiplier.sv
// multiplies two 8-bit numbers, A and B, or squares A

module Multiplier(

    //inputs
    input clk,          //clock input
    input enter,        //triggers the start of the multipication operation
    input [1:0] sel,    //LSB of sel selects whether to multiply or square
    input [7:0] A,      
    input [7:0] B,
    
    //outputs
    output [7:0] P,     //product output
    output done         //signal to save output once operation has completed
    
    );
	
	//intermediate variables
    logic [1:0] t1;
    logic t2, t3;
    logic [7:0] t4, t5;
    
    //shifts A with each successive bit of B
    ShiftRegister ShiftRegister ( .clk(clk), .CLR(0), .SEL(t1), .D(A), .Q(t4) );
    
    //accumulates the contents of the shift register if the relevant bit of B is a 1
    Accumulator Accumulator ( .clk(clk), .LD(t2), .CLR(t3), .D(t4), .Q(P) );
    
    //FSM to control the shift register and accumulator
    MultiplyFSM MultiplyFSM ( .clk(clk), .enter(enter), .A(A), .B(B), .sel(sel), .sr_sel(t1), .acc_ld(t2), .acc_clr(t3), .done(done) );
    
endmodule
