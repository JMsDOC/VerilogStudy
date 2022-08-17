//2022-08-17, Jim
//秒计数器 0-9循环
`timescale 1ns/10ps
module s_counter(
    clk,
	rst,
	s_num
	);

input		clk;
input		rst;
output[3:0]	s_num;

parameter 	freqency_clk=24;	//24MHz

reg[24:0]	con_t;	//秒脉冲分频计数器
reg			s_pulse;//秒脉冲尖
reg[3:0]	s_num;

always@(posedge clk or negedge rst)
	if(~rst)begin
		con_t<=0;s_pulse<=0;s_num<=0;
	end
	else begin
		if(con_t==freqency_clk*1000000-1)begin
			con_t<=0;
		end
		else begin
			con_t<=con_t+1;
		end
		
        if(con_t==0)begin
		  s_pulse<=1;
	    end
	    else begin
		  s_pulse<=0;
	   end
	   
	   if(s_pulse)begin
		  if(s_num==9)begin
			 s_num<=0;
          end
		  else begin
		      s_num<=s_num+1;
          end
        end
	end
endmodule

//-----testbench of s_counter-----
module s_counter_tb;
reg                 clk,rst;
wire[3:0]           s_num;
s_counter s_counter(
					.clk(clk),
					.rst(rst),
					.s_num(s_num)
	                );
initial begin
			clk<=0;rst<=0;
	#17 	rst<=1;
	#1000   $stop;
end

always #5 clk<=~clk;

endmodule

//数码管0-9秒循环显示
module top(clk, res, a_g);
input			clk;
input			res;
output[6:0]		a_g;
wire[3:0]		s_num;

s_counter U1(
		.clk(clk),
		.rst(rst),
		.s_sum(s_num)
	);

seg_dec U2(
		.s_num(s_num),
		.a_g(a_g)
	);


//秒分频计数
//参数设置
//秒脉冲尖产生方法
//基于秒脉冲的0~9循环计数
//异名例化实用举例