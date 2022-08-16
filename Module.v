//modules
module top_module ( input a, input b, output out );
	mod_a ma1( .in1(a), .in2(b), .out(out));
endmodule


//module ports
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a ma1(out1, out2, a, b, c, d);
endmodule

//module name
module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
	
	mod_a ma1(.out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c), .in4(d));
endmodule

//Three Modules
module top_module ( input clk, input d, output q );

endmodule

//Module Shift
module top_module ( input clk, input d, output q );
	
	wire q1, q2;

    my_dff d1(.clk(clk), .d(d), .q(q1));
    my_dff d2(.clk(clk), .d(q1), .q(q2));
    my_dff d3(.clk(clk), .d(q2), .q(q));
  
endmodule

//Module & Vectors
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
	
	wire [7:0]q1;
	wire [7:0]q2;
	wire [7:0]q3;

	my_dff8 d1(.clk(clk), .d(d), .q(q1));
	my_dff8 d2(.clk(clk), .d(q1), .q(q2));
	my_dff8 d3(.clk(clk), .d(q2), .q(q3));

	always @ (*)
	begin
		case(sel)
			2'b00:begin
				assign q = d ;
			end

			2'b01:begin
				assign q = q1 ;
			end

			2'b10:begin
				assign q = q2 ;
			end

			2'b11:begin
				assign q = q3 ;
			end
		endcase 
	end

endmodule


//Adder1
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire [15:0] sum_low;
    wire [15:0] sum_hi;
    wire cout1;
    add16 add16_num1(.a(a[15:0]), .b(b[15:0]), .cin(0), .sum(sum_low), .cout(cout1));
    add16 add16_num2(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .sum(sum_hi));

    assign sum[31:16] = sum_hi;
    assign sum[15:0] = sum_low;

endmodule

//Adder2
module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
// sum = a ^ b ^ cin
// cout = (a ^ b) & cin + a & b

endmodule