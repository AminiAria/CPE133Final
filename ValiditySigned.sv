`timescale 1ns / 1ps

// ValiditySigned.sv
// determines the validity of a signed addition or subtraction operation

module ValiditySigned(

    input A,        //most significant bit of A input
    input B,        //most significant bit of B input
    input S,        //most significant bit of sum output
    output valid    //valid (1) or invalid (0)
    
    );
    
    //if A and B are positive and S is negative addition is invalid
    //if A and B are negative and S is positive addition is invalid
    //if A and B have opposite signs addition is always valid
    assign valid = ~( ~(A ^ B) & (B ^ S) );
    
endmodule
