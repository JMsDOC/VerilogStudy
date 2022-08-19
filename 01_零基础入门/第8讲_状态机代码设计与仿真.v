//2022-08-19, Jim
//串口数据接收

module UART_RXer(
						clk,
						res,
						RX
						data_out,
						en_data_out
);

input					clk;
input					res;
input					RX;
output[7:0]				data_out;//接收字节输出
output					en_data_out;//输出使能

reg[7:0]				data_out;
reg[7:0]				state;//主状态机
reg[12:0]				con;//用于计算比特宽度
reg[3:0]				con_bit;//用于计算比特数

reg						RX_delay;//RX的延时


always@(posedge clk or negedge res)
if(~res)begin
	state<=0;con<=0;con_bits<=0;RX_delay<=0;
	data_out<=0;
end

else begin
	RX_delay<=RX;//有时钟就动

	case(state)
	0://等空闲
	begin
		if(con==4999)begin
			con<=0;
		end
		else begin
			con<=con+1;
		end

		if(con==0)begin
			if(RX)begin
				con_bits<=con_bits+1;
			end
			else begin
				con_bits<=0;
			end
		end

		if(con_bits==12)begin
			state<=1;
		end
	end

	1://等起始位
	begin
		en_data_out<=0;
		if(~RX&RX_delay)begin
				state<=2;
		end
	end

	2://收最低位b0;
	begin
		if(con==7500-1)begin
			con<=0;
			data_out[0]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	3://收最低位b1;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[1]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	4://收最低位b2;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[2]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	5://收最低位b3;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[3]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	6://收最低位b4;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[4]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	7://收最低位b5;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[5]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	8://收最低位b6;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[6]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	9://收最低位b7;
	begin
		if(con==5000-1)begin
			con<=0;
			data_out[7]<=RX;
			state<=3;
		end
		else begin
			con<=con+1;
		end
	end

	10://产生使能脉冲
	begin
		en_data_out<=1;
	end

	default:
	begin
		state<=0;
		con<=0;
		con_bits<=0;
		en_data_out<=0;
	end
	endcase

end


//--------testbench of UARTRXer--------
module UART_RXer_tb;

reg                		clk,res;
wire                		RX;
wire[7:0]				data_out;
wire					en_data_out;
reg[25:0]				RX_send;//里面装有串口字节发送数据
assign 					RX=RX_send[0];//连接RX

reg[13:0]				con;

UART_RXer UART_RXer(	//同名例化
						clk,
						res,
						RX
						data_out,
						en_data_out
						);

initial begin
				clk<=0;res<=0;RX_send<={1'b1, 8'haa, 1'b0, 16'hffff};con<=0;
	#17			res<=1;
	#1000		$stop;
end

always #5 clk<=~clk;

always@(posedge clk)begin
	if(con==5000-1)begin
		con<=0;
		end
	else begin
		con<=con+1;
	end

	if(con==0)begin
		RX_Send[24:0]<=RX_Send[25:1];
		RX_Send[25]<=RX_Send[0];
	end
end

endmodule

//串口协议
//串口模块设计

