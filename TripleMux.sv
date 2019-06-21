`timescale 1ns / 1ps

// TripleMux.sv
// three option MUX with inputs and outputs of variable width

module TripleMux # (parameter WIDTH = 4) (

    input [1:0] sel,                //selector
    input [WIDTH - 1:0] zero,       //first input
    input [WIDTH - 1:0] one,        //second input
    input [WIDTH - 1:0] two,        //third input
    output logic [WIDTH - 1:0] out  //output
    
    );
    
    always_comb
    
    begin
        
        if (sel == 2'b00) //if sel is 0, then output of mux will be the 0 input which is validity for unsigned numbers
            begin
                out = zero;
            end
        
        else if (sel == 2'b01) //if sel is 1, then output of mux will be the 1 input which is validity for signed numbers
            begin
                out = one;
            end
            
        else //else (2 or 3), output of mux will be the 2 input, which is always 1 in the Adder module
            begin
                out = two;
            end
       
    end
    
endmodule
