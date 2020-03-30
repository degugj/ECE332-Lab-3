`timescale 100 ps/10 ps


// The `timescale directive specifies that
// the simulation time unit is 100 ps and
// the simulator timestep is 10 ps

module rle_testbench;
	// signal declaration
	reg clkt, rstt;
	reg recv_readyt, send_readyt;
	reg [7:0] in_datat;
	reg end_of_streamt;
	wire [23:0] out_datat;
	wire rd_reqt, wr_reqt;
   
  	integer i;
  	integer n = 5;

	// instantiate the circuit under test
	rle_enc uut
		(.clk(clkt), .rst(rstt), .recv_ready(recv_readyt), .send_ready(send_readyt), .in_data(in_datat), .end_of_stream(end_of_streamt), .out_data(out_datat), .rd_req(rd_reqt), .wr_req(wr_reqt));


	// clock running forever
	always
	begin

	// Clock signal assignment
		clkt <= 1; #5;
      		clkt <= 0; #5;
      	
      	
	end

	// reset for a few cycles
  	initial
	begin

	// Reset signal assignment
		rstt <= 1; #10;
      		rstt <= 0;    //1000 0000 0000 0000 0000 1000
      		#10;
	end

	// test vector generator
	initial
	begin
      
	
		in_datat <= 8'b11111111;			//1. Frames with all zeroes and all ones
		//in_datat <= 8'b0000000;
		
		//in_datat <= 8'b00001111;			//2. Bit transitions within a single frame
		//in_datat <= 8'b11110000;
		//in_datat <= 8'b01010101;
		
		recv_readyt <= 1;
		#40;
		recv_readyt <= 0;
		
		//run while we are not requesting to read the input, essentially deals with multiple bitstreams in a frame
		while (!rd_reqt) begin
	  
			//should be in COUNT_DONE after 200 cycles
			#200;
			
			//flag for to transition from COUNT_DONE -> WAIT_OUTPUT
			send_readyt <= 1;
			#10;
			send_readyt <= 0;

		end

		
		//2nd test vector that is used to test multiple frames
		/*in_datat <= 8'b11110000;			//3. Bit transitions between frames (both 0 to 1 and 1 to 0)
		in_datat <= 8'b00001111;			
		
		recv_readyt <= 1;
		#40;
		recv_readyt <= 0;
		
		//run while we are not requesting to read the input, essentially deals with multiple bitstreams in a frame
		while (!rd_reqt) begin
	  
			//should be in COUNT_DONE after 200 cycles
			#200;
			
			//flag for to transition from COUNT_DONE -> WAIT_OUTPUT
			send_readyt <= 1;
			#10;
			send_readyt <= 0;

		end
		*/
	
		end_of_streamt <= 0;
		end_of_streamt <= 1;
		//$display("%b", out_datat);
     
 
      		$stop;
	end
      
endmodule
