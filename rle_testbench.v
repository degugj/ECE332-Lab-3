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
      	rstt <= 0; in_datat <= 8'b11111111;   //1000 0000 0000 0000 0000 1000
      	#10;
	end

	// test vector generator
	initial
	begin
      
      // test vector 1
    
      
     
		
 
      
      
      
      
      
      
      
	  // test vector 2
 	  // test vector n
     
      for (i = 0; i < n; i = i +1) begin
        
        recv_readyt <= 1;			//lock(recv_read)
        #200;
        recv_readyt <= 0;
        send_readyt <= 1;
        #5;
        end_of_streamt <= 1;
        send_readyt <= 0;
        $display("%b", out_datat);
        #10;
        end_of_streamt <= 0;
      	#20;
        
      end
      
		$stop;
	end
endmodule
