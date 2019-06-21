`timescale 1ns / 1ps

// MultipyFSM.sv
// Finite state machine for the multiplier
// Can multiply or square depending on the selector

module MultiplyFSM(

    //inputs
    input clk,                  //clock input
    input enter,                //trigger to start the multipication
    input [1:0] sel,            //sel[0] determines whether to multiply A * B (0) or square A (1)
    input [7:0] A,              //A input is passed in to replace B if squaring
    input [7:0] B,              //B is used in multipication
    
    //outputs
    output logic [1:0] sr_sel,  //controls the shift register
    output logic acc_ld,        //signals the accumulator to add the contents of the shift register
    output logic acc_clr,       //clears the accumulator
    output logic done           //signals the value DFF to save the output of the operation
    
    );
   
    //Bo is the number that A will be multiplied by
    //In multiplication mode, Bo is set to B, the second input
    //In squaring mode, Bo is set to A, so that A will be multiplied by itself
    logic [7:0] Bo = B;
   
    //assign bit values to your states
    //again the size should be log2(number of states)
    parameter [3:0]
    HOLD  = 4'b0000,
    START = 4'b0001,
    BIT0  = 4'b0010,
    BIT1  = 4'b0011,
    BIT2  = 4'b0100,
    BIT3  = 4'b0101,
    BIT4  = 4'b0110,
    BIT5  = 4'b0111,
    BIT6  = 4'b1000,
    BIT7  = 4'b1001,
    DONE  = 4'b1010;
   
    //declare present state (PS) and next state (NS) variables to
    //be the size of log2(number of states)
    //initialize PS to the beginning state
    logic [3:0] NS;
    logic [3:0] PS = HOLD;
   
    //sequential logic to change states
    always_ff @ (posedge clk)
    begin
        PS = NS;
    end
   
   
    //combinatorial logic
    always_comb
    begin
   
    //initialze all outputs to zero
    sr_sel = 0;
    acc_ld = 0;
    acc_clr = 0;
    done = 0;
   
    case (PS)
        
        
        HOLD: //the multiplier is not performing a calculation
        begin
            //reset all outputs to zero
            sr_sel = 0;
            acc_ld = 0;
            acc_clr = 0;
            done = 0;
            
            //only exit the hold state if the enter key is being pressed
            if (enter)
                if (sel[1]) //only perform the operation if mult or sqr was pressed
                    NS = START;
                else //if add or sub was pressed, then send the done signal to save the output of the adder
                    NS = DONE;
            else
                NS = HOLD;
        end
   
        START: //initializes the shift register, the accumulator, and Bo
        begin
            sr_sel = 1;     //load A into the shift register
            acc_ld = 0;     //the accumulator is not loaded yet
            acc_clr = 1;    //clear the accumulator
            done = 0;       //the calculation has not been completed
            NS = BIT0;      //begin multiplying by the first bit of the second operand
            
            //use A as the second operand if squaring, B if multiplying
            if (sel[0])
                Bo = A;
            else
                Bo = B;
        end
        
        BIT0: //performs multipication of A times the 0th bit of Bo
        begin
            sr_sel = 2;     //shift the contents of the register to the left
            acc_ld = Bo[0]; //only load the accumulator if this bit of Bo is a 1
            acc_clr = 0;
            done = 0;
            NS = BIT1;
        end
       
        BIT1: //performs multipication of A times the 1st bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[1];
            acc_clr = 0;
            done = 0;
            NS = BIT2;
        end
       
        BIT2: //performs multipication of A times the 2nd bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[2];
            acc_clr = 0;
            done = 0;
            NS = BIT3;
        end
       
        BIT3: //performs multipication of A times the 3rd bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[3];
            acc_clr = 0;
            done = 0;
            NS = BIT4;
        end
        
        BIT4: //performs multipication of A times the 4th bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[4];
            acc_clr = 0;
            done = 0;
            NS = BIT5;
        end
        
        BIT5: //performs multipication of A times the 5th bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[5];
            acc_clr = 0;
            done = 0;
            NS = BIT6;
        end
        
        BIT6: //performs multipication of A times the 6th bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[6];
            acc_clr = 0;
            done = 0;
            NS = BIT7;
        end
        
        BIT7: //performs multipication of A times the 7th bit of Bo
        begin
            sr_sel = 2;
            acc_ld = Bo[7];
            acc_clr = 0;
            done = 0;
            NS = DONE;
        end
       
        DONE: //send out signal that the operation has been completed
              //so that the result can be saved in a register
        begin
            sr_sel = 0;
            acc_ld = 0;
            acc_clr = 0;
            done = 1;
            NS = HOLD;
        end
        
        default:
            NS = HOLD;
            
    endcase     
    end      
endmodule