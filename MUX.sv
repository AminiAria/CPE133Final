`timescale 1ns / 1ps

// MUX.sv
// two option MUX with inputs and outputs of variable width

module MUX # (parameter WIDTH = 4) (

    input sel,                      //selector
    input [WIDTH - 1:0] zero,       //first input
    input [WIDTH - 1:0] one,        //second input
    output logic [WIDTH - 1:0] out  //output
    
    );
    
    always_comb 
    
    begin
        
        if (sel)
            begin
                out = one;  //selector input will output the one output
            end
        else
            begin
                out = zero; //selector input will output the zero output
            end
       
    end
    
endmodule
