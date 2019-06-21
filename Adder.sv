`timescale 1ns / 1ps

// Adder.sv
// adds or subtracts two 8-bit numbers

module Adder(

    //inputs
    input [1:0] sel,    //LSB of sel indicates whether to perform a unsigned (0) or signed (1) operation
                        //MSB of sel indicates whether the adder module is being used (0) or not (1)
                        //if sel[1] is 1, the sign should always be positive (0) and valid should be 1
    input addSub,       //0 for add and 1 for subtract
    input [7:0] A,
    input [7:0] B,
    
    //outputs
    output [7:0] S,     //sum output
    output sign,        //sign output
    output valid        //validity output
    
    );
    
    //intermediate variables
    logic [7:0] t1, t2, t3, t6;
    logic t4, t5, t7, t8;
    
    assign t4 = t2[7] & sel[0] & ~sel[1];   //determines the sign
    assign sign = t4;                       //sign output
    
    RCA RCA0 ( .A(A), .B(t1), .S(t2), .Ci(addSub), .Co(t5) );       //performs the addition or subtraction
    RCA RCA1 ( .A(~t2), .B(8'b00000000), .S(t3), .Ci(1) );          //takes the twos-complement of the sum
    MUX #(8) MUX0 ( .zero(B), .one(~B), .sel(addSub), .out(t1) );   //selects operation
    MUX #(8) MUX1 ( .zero(t2), .one(t3), .sel(t4), .out(S) );       //selects whether to use the twos-complement sum 
    TripleMux #(1) MUX2 ( .zero(t8), .one(t7), .two(1), .sel(sel), .out(valid) );   //selects which validity to use
    ValiditySigned ValiditySigned ( .A(A[7]), .B(t1[7]), .S(t2[7]), .valid(t7) );   //determines valititdy for signed operation
    ValidityUnsigned ValidityUnsigned ( .Co(t5), .addSub(addSub), .valid(t8) );     //determines validitiy for unsigned operation
    
endmodule
