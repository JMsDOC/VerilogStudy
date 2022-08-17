//2022-08-17， Jim
//相邻16点相加输出
`timescale 1ns/10ps
module sigma_16p(
	
	);

input			clk;
input			res;
input[7:0]		data_in;//采样信号
input			syn_in;//采样时钟
output[11:0]	data_out;//累加结果输出
output			syn_out;//累加结果同步脉冲

reg				syn_in_n1;//syn_in反向延时
wire			syn_pulse;//采样时钟上升沿识别脉冲
assign  		syn_pulse=syn_in&syn_in_n1;
reg[3:0]		con_syn;//采样时钟循环计数器

wire[7:0]		comp_8;//补码
wire[11:0]		d_12;//升位
assign			comp_8=data_in[7]?{data_in[7], ~data_in[6:0]+1}:data_in;
assign			d_12={comp_8[7],comp_8[7],comp_8[7],comp_8[7],comp_8};
reg[11:0]		sigma;//累加计算
reg[11:0]		data_out;
reg				syn_out;


always@(posedge clk or negedge res)
if(~res)begin
	syn_in_n1<=0;con_syn<=0;sigma<=0;data_out<=0;
	syn_out<=0;
end
else begin
	syn_in_n1<=syn_in;
	if(syn_pulse)begin
		con_syn<=con_syn+1;
	end

	if(syn_pulse)begin
		if(con_syn==15)begin
			sigma<=d_12;
			data_out<=sigma;
			syn_out<=1;
		end
		else begin
			sigma<=sigma+d_12;
		end
	end
	else begin
		syn_out<=0;
	end

end

endmodule


//------testbench of sigma_16p------
module sigma_16p_tb;

reg					clk;
reg					res;
reg					syn_in;
wire[11:0]			data_out;
wire				syn_out;

sigma_16p sigma_16p(
					.clk(clk),
					.res(res),
					.data_in(data_in),
					.syn_in(syn_in),
					.data_out(data_out),
					.syn_out(syn_out)
	);

initial begin
				clk<=0;res<=0;data_in=1;syn_in<=0;//若是-1, 8'b1000_0001
		#17		res<=1;
		#1000	$stop;

always  #5 		clk<=~clk;
always  #1000	syn_in<=~syn_in;
end

endmodule

//补码升位
//上升沿识别
//数据和同步脉冲产生方法
