//2020-08-15, Jim
//计数器
`timescale 1ns/10ps
module con( 
			clk, 
			res, 
			y);

input		clk;
input		res;
output[7:0] y;

reg[7:0]	y;

wire[7:0]	sum;//+1运算的结果
assign sum = y+1;//组合逻辑部分

always@(posedge clk or negedge res)
if(~res)begin
	y<=0;
end
else begin
	y<=sum;
end

endmodule

//---------testbench of counter--------
module counter_tb;

reg			clk,res;
wire[7:0]	y;

counter counter(
					.clk(clk),
					.res(res),
					.y(y)
	);
initial begin
				clk<=0;res<=0;
	#17		res<=1;
	#6000 	$stop;
end

always #5 clk<=~clk;

endmodule


//===================================================================
//2022-08-15
//4级别伪随机码发生器
`timescale 1ns/10ps
module m_gen( clk, res, y);
input		clk;
input		res;
output		y;

reg[3:0];				//定义4位寄存器
assign y = d[0];		//输出连接

always@(posedge clk or negedge res)
if(~res)begin
	d<=4'b1111;			//不能复位成全0
end
else begin
	d[2:0]<=d[3:1];		//右移一位
	d[3]<=d[3]+d[0]; 	//模2加,自动舍去进位
end
endmodule


//---------testbench of m_gen--------
module m_gen_tb;

reg				clk,res;
wire			y;

m_gen m_gen(
				.clk(clk),
				.res(res),
				.y(y)
	);

initial begin
				clk<=0;res<=0;
	#17		res<=1;
	#600 	$stop;
end

endmodule 

//计数器设计/
//伪随机码发生器设计
//触发器的敏感变量为时钟沿和复位沿
//时序逻辑的代码结构
//寄存器右移
//模2加

