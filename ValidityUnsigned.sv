`timescale 1ns / 1ps

// ValidityUnsigned.sv
// determines the validity of an unsigned addition or subtraction operation

module ValidityUnsigned(

    input addSub,       //addition (0) or subtraction (1)
    input Co,           //Co of RCA0
    output logic valid  //output
    
    );
    
    always_comb
    begin
        if (addSub && Co) //if you are subtracting and there is a carry out, then valid
            begin
                valid = 1;
            end
        else if (addSub == 0 && Co == 0) //if you are adding and there is no carry out, then valid
            begin
                valid = 1;
            end
        else //other cases are invalid, eg. subtracting and no carry out or adding and a carry out
            begin
                valid =0;
            end
    end
    
endmodule
