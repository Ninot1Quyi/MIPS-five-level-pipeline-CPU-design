//最小片上系统

`include "defines.v"

module openmips_min_sopc(

	clk, 	//时钟信号
	rst,	//复位信号

	//led
	//分别反应r1,r2,r3,r4的第0位的情况
	led0_o,  //led0
	led1_o,  //led1
	led2_o,  //led2
	led3_o   //led3
);
input	wire	clk;	//时钟信号
input 	wire	rst;	//复位信号

output wire 	led0_o;   //led0
output wire    led1_o;   //led1
output wire    led2_o;   //led2
output wire    led3_o;   //led3
//将openmips和指令存储器连接起来
//定义连线
//led的数据线
wire 	led0_i;   //led0
wire    led1_i;   //led1
wire    led2_i;   //led2
wire    led3_i;   //led3
//延迟时钟
wire  delayclk; 

wire[`InstAddrBus] inst_addr;
wire[`InstBus] inst;
wire rom_ce;
//实例化delay_clk
delay_clk delay_clk0(
    .clk_i(clk),
    .clk_o(delayclk)
);

//实例化openmips
openmips openmips0(
	.clk(delayclk),
	.rst(rst),

	.rom_addr_o(inst_addr),
	.rom_data_i(inst),
	.rom_ce_o(rom_ce),
	//led
    .led0_o(led0_i),
    .led1_o(led1_i),
    .led2_o(led2_i),
    .led3_o(led3_i)
);
//实例化”指令存储器“
inst_rom inst_rom0(
	.ce(rom_ce),
	.addr(inst_addr),
	.inst(inst)	
);
assign led0_o = led0_i;
assign led1_o = led1_i;
assign led2_o = led2_i;
assign led3_o = led3_i;

endmodule