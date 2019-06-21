`timescale 1ns / 1ps

// Selector.sv
// selects which mathmatical operation to be carried out on the values
// and whether the values are signed or unsigned (for addition and subtraction only)
// enter output connects to input of the multiplier to initiate the multipication

module Selector(

    //inputs
    input clk,          //clock input
    input toggleSgd,    //button representing signed or unsigned values
    input add,          //button to trigger an addition operation
    input sub,          //button to trigger a subtraction operation
    input mult,         //button to trigger a multipication operation
    input sqr,          //button to trigger a squaring operation
    
    //outputs
    output enter,   //triggers the multiply module to start calculating
    output [1:0] sel,   //identifies the type of operation to perform
                        //  00: unsigned addition or subtraction
                        //  01: signed addition or subtraction
                        //  10: multipication
                        //  11: squaring
    output addSub,      //indicates whether to perform addition (0) or subtraction (1)
    output sgd          //indicates whether the adder will be performing unsigned (0) or signed (1) calculations
    
    );
    
    //intermediate variables
    logic t1, t2, t3, t4, t5, t6;
    
    assign t4 = mult | sqr;                 //a multipication or squaring operation has been requested
    assign t5 = add | sub;                  //an addition or subtraction opertion has been requested
    assign enter = mult | sqr | add | sub;  //send the enter signal if any operation is requested
    assign sel = { t3, t6 };                //combine these two bits into a single output, sel
    assign sgd = t1;                        //output of the TFF
    
    TFF TFF0 ( .clk(clk), .T(toggleSgd), .Q(t1) );              //unsigned (0) or signed (1)
    JKFF JKFF0 ( .clk(clk), .J(sqr), .K(mult), .Q(t2) );        //mult (0) or sqr (1)
    JKFF JKFF1 ( .clk(clk), .J(t4), .K(t5), .Q(t3) );           //add/sub (0) or mult/sqr (1)
    JKFF JKFF2 ( .clk(clk), .J(sub), .K(add), .Q(addSub) );     //add (0) or sub (1)
    MUX #(1) MUX0 ( .zero(t1), .one(t2), .sel(t3), .out(t6) );  //selects whether the LSB of sel is unsigned/signed or mult/sqr
    
endmodule
