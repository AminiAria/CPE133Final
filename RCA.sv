`timescale 1ns / 1ps

// RCA.sv
// adds two 8-bit numbers using full adders

module RCA(

    input [7:0] A,  //first operand
    input [7:0] B,  //second operand
    input Ci,       //carry in 
    output [7:0] S, //sum
    output Co       //carry out
    
    );
    
    //intermediate variables
    logic t1, t2, t3, t4, t5, t6, t7;
    
	// the carry out of one full adder is the carry in of the next one
    FA FA0 ( .A(A[0]), .B(B[0]), .S(S[0]), .Co(t1), .Ci(Ci) );
    FA FA1 ( .A(A[1]), .B(B[1]), .S(S[1]), .Co(t2), .Ci(t1) );
    FA FA2 ( .A(A[2]), .B(B[2]), .S(S[2]), .Co(t3), .Ci(t2) );
    FA FA3 ( .A(A[3]), .B(B[3]), .S(S[3]), .Co(t4), .Ci(t3) );
    FA FA4 ( .A(A[4]), .B(B[4]), .S(S[4]), .Co(t5), .Ci(t4) );
    FA FA5 ( .A(A[5]), .B(B[5]), .S(S[5]), .Co(t6), .Ci(t5) );
    FA FA6 ( .A(A[6]), .B(B[6]), .S(S[6]), .Co(t7), .Ci(t6) );
    FA FA7 ( .A(A[7]), .B(B[7]), .S(S[7]), .Co(Co), .Ci(t7) );
    
endmodule
