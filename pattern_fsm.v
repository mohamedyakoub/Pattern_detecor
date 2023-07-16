// Code your design here
// Code your design here
module pattern(
  input clk,
  input rst,
  input in1,
  output reg ind
);
	parameter state_reg_width=3;
	parameter [state_reg_width-1:0] state0= 4'b00,
							         state1= 3'b001,
  								  	 state2= 3'b010,
								  	 state3= 3'b011,
									 state4= 3'b100,
									 state5= 3'b101;
	reg [state_reg_width-1:0] curr_state,next_state;
	always @(posedge clk) begin 
		if(rst)begin 
			curr_state<=state0;
		end
		else begin
			curr_state<=next_state;
		end
	end
	always @(*) begin
	 ind=0;
	 case(curr_state)
	  state0: begin
        if(in1==1)
		  next_state=state1;
		 else next_state=state0;
	  end
	  state1: begin
        if(in1==1)
		  next_state=state2;
		 else next_state=state0;	  
	  end
	  state2: begin
        if(in1==0)
		  next_state=state3;
		 else next_state=state2;
	  end
	  state3: begin
        if(in1==1)
		  next_state=state4;
		 else next_state=state0;
	  end
	  state4: begin
        if(in1==0)
		  next_state=state5;
		 else next_state=state2;
	  end
	  state5: begin
	    ind=1;
        if(in1==1)
		  next_state=state1;
		 else next_state=state0;
	  end
	  
	 endcase
    end
      endmodule
	 
module pattern_tb;
   parameter clk_period= 10ns;
   

   reg clk_tb=0;
   always #(clk_period/2) clk_tb= ~clk_tb;
     reg clk_tb, reset_tb;
	 
     reg in1;

     reg ind;

    pattern dut(clk_tb,reset_tb,in1,ind);
  
  
  
  	 initial begin
        reset_tb=1;
       #(clk_period);
       reset_tb=0;
       #(clk_period);
       $display( "ind = %d", ind);
       in1=1;
       #(clk_period);
       #(clk_period);
              #(clk_period);

       in1=0;

       #(clk_period);
       in1=1;
       #(clk_period);

       #(clk_period);
       in1=0;
	   #(clk_period);
       in1=1;
       #(clk_period);
       in1=0;
       #(clk_period);

     $display( "written memory value = %d", ind);
       $finish;

     end 
  
 endmodule