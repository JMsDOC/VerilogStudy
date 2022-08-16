//Vectors
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
    
    assign outv[0] = vec[0];
    assign outv[1] = vec[1];
    assign outv[2] = vec[2];
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];

endmodule

//Vector1
`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    
    assign out_hi[7:0] = in[15:8];
    assign out_lo[7:0] = in[7:0];
endmodule

//Vector2
//ttle-endian x86 systems and the big-endian formats used in many Internet protocols
module top_module( 
    input [31:0] in,
    output [31:0] out);//

    assign out[7:0] = in[31:24];
    assign out[15:8] = in[23:16];
    assign out[23:16] = in[15:8];
    assign out[31:24] = in[7:0];

endmodule

//Vectorgates(向量门)
//bitwise-OR 按位或 只要其中有一个二进制位值为1，结果就为真
//logical-OR 逻辑或 只获得一个bool值
module top_module( 
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not);

    assign out_or_bitwise[2:0] = a[2:0] | b[2:0];
    assign out_or_logical = a || b;

    assign out_not[5:3] = ~b[2:0];
    assign out_not[2:0] = ~a[2:0];
endmodule

//Gates4
module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    assign out_and = in[3] & in[2] & in[1] & in[0];
    assign out_or = in[3] | in[2] | in[1] | in[0];
    assign out_xor = in[3] ^ in[2] ^ in[1] ^ in[0];

endmodule


//Vector3 {}
//3'b111, 3'b000} => 6'b111000
module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );

    assign {w[7:0], x[7:0], y[7:0], z[7:0]} = {{a[4:0], b[4:0]}, {c[4:0], d[4:0]}, {e[4:0], f[4:0]}, 2'b11};

endmodule

//Vectorr
module top_module( 
    input [7:0] in,
    output [7:0] out
);
    genvar loop;
    generate
        for(loop = 0; loop < 8; loop = loop + 1)
        begin:gene_data
            assign out[7-loop] = in[loop];
        end
    endgenerate
endmodule


//Vector4
//replication operator
module top_module (
    input [7:0] in,
    output [31:0] out );

    assign out = {{24{in[7]}}, in[7:0]};

endmodule

//Vector5
module top_module (
    input a, b, c, d, e,
    output [24:0] out );

    assign out = ~ {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}} ^ {5{a, b, c, d, e}};

endmodule