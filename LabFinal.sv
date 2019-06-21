`timescale 1ns / 1ps

// LabFinal.sv
// This file and all sub modules were written by
// Trevor Jones, Aria Amini, Pavin Virdee, and Hannah Chookaszian
// This module can perform addition (A + B), subtraction (A - B),
// multipication (A * B) and squaring (A * A)
// In addition and subtraction only, the toggleSgd button
// toggles between unsigned (LED off) and signed (LED on) operations
// The result of the operation is displayed on the seven segment display

module LabFinal(
    
    //clock input
    input clk,
    
    //button inputs
    input toggleSgd,
    input add,
    input sub,
    input mult,
    input sqr,
    
    //8-bit switch inputs
    input [7:0] A,
    input [7:0] B,
    
    //display outputs
    output [7:0] seg,
    output [3:0] an,
    
    //LED outputs
    output sgd,
    output [8:0] binary
    
    //outputs for testing
    //output [7:0] value
    //output sign,
    //output valid
    
    );
    
    //intermediate variables
    logic [1:0] t1;
    logic t2, t3, t4, t8, t9, t11, t12;
    logic [7:0] t5, t6, t7, t10;
    
    //assign the testing outputs
    //assign value = t10;
    //assign sign = t11;
    //assign valid = t12;
    
    //the selector controls the inputs of the other sub modules and outputs
    Selector Selector ( .clk(clk), .toggleSgd(toggleSgd), .add(add), .sub(sub), .mult(mult), .sqr(sqr), .sel(t1), .enter(t2), .addSub(t3), .sgd(sgd) );
    
    //performs multipication and squaring
    Multiplier Multiplier ( .clk(clk), .sel(t1), .enter(t2), .A(A), .B(B), .done(t4), .P(t5) );
    
    //performs unsigned and signed addition and subtraction
    Adder Adder ( .sel(t1), .addSub(t3), .A(A), .B(B), .S(t6), .sign(t8), .valid(t9) );
    
    //outputs the result of the calculation to the seven segment display
    univ_sseg univ_sseg ( .clk(clk), .cnt1(t10), .cnt2(0), .dp_en(0), .dp_sel(0), .mod_sel(0), .sign(t11), .valid(t12), .ssegs(seg), .disp_en(an) );
    
    DFF #(8) DFF_Result ( .clk(clk), .enter(t4), .D(t7), .Q(t10) );     //stores the value of the result
    DFF #(1) DFF_Sign   ( .clk(clk), .enter(t4), .D(t8), .Q(t11) );     //stores the sign of the result
    DFF #(1) DFF_Valid  ( .clk(clk), .enter(t4), .D(t9), .Q(t12) );     //stores for validity of the result
    MUX #(8) MUX0       ( .zero(t6), .one(t5), .sel(t1[1]), .out(t7) ); //selects whether to use the add/sub or mult/sqr output
    
    //create a flasher using a clock divider
    logic flash;
    logic [25:0] count; 
    always @ (posedge clk) 
    begin 
        count <= count + 1; 
    end 
    assign flash = count[25];
    
    //show binary output when valid, flashing if invalid
    MUX #(9) LEDMUX ( .zero({9{flash}}), .one({t11,t10}), .sel(t12), .out(binary) );

endmodule
