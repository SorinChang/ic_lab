

module iic_top(
  clk,rst_n,REG_WR,IDAT,addr,
  sw1,sw2,sw3,sw4,
  scl,sda,
  ackflag,
//  sda_link,
  outdata

);

input clk,rst_n,REG_WR;
input [7:0]IDAT;
input [2:0]addr;
input sw1,sw2,sw3,sw4;
output [7:0]outdata;
output [2:0]ackflag;
inout sda;
output scl;

wire net_sda_link;
wire net_clk,net_rst_n,net_reg_wr;
wire [7:0]net_IDAT;
wire [2:0]net_addr;
wire net_sw1,net_sw2,net_sw3,net_sw4;
wire [7:0]net_outdata;
wire [2:0]net_ackflag;
wire net_sda_i,net_sda_o,net_sda;
wire net_scl;
//insert top module

iic iic_instance(
 .clk(net_clk),.rst_n(net_rst_n),.REG_WR(net_reg_wr),
 .IDAT(net_IDAT),.addr(net_addr),
 .sw1(net_sw1),.sw2(net_sw2),.sw3(net_sw3),.sw4(net_sw4),
 .scl(net_scl),.sda(net_sda),.ackflag(net_ackflag),
 .sda_link(net_sda_link),.outdata(net_outdata)

);
//insert io pad
pc3d01 clk_pad(.PAD(clk),.CIN(net_clk));
pc3d01 rst_n_pad(.PAD(rst_n),.CIN(net_rst_n));
pc3d01 REG_WR_pad(.PAD(REG_WR),.CIN(net_reg_wr));

pc3d01 IDAT_pad_0(.PAD(IDAT[0]),.CIN(net_IDAT[0]));
pc3d01 IDAT_pad_1(.PAD(IDAT[1]),.CIN(net_IDAT[1]));
pc3d01 IDAT_pad_2(.PAD(IDAT[2]),.CIN(net_IDAT[2]));
pc3d01 IDAT_pad_3(.PAD(IDAT[3]),.CIN(net_IDAT[3]));
pc3d01 IDAT_pad_4(.PAD(IDAT[4]),.CIN(net_IDAT[4]));
pc3d01 IDAT_pad_5(.PAD(IDAT[5]),.CIN(net_IDAT[5]));
pc3d01 IDAT_pad_6(.PAD(IDAT[6]),.CIN(net_IDAT[6]));
pc3d01 IDAT_pad_7(.PAD(IDAT[7]),.CIN(net_IDAT[7]));

pc3d01 addr_pad_0(.PAD(addr[0]),.CIN(net_addr[0]));
pc3d01 addr_pad_1(.PAD(addr[1]),.CIN(net_addr[1]));
pc3d01 addr_pad_2(.PAD(addr[2]),.CIN(net_addr[2]));

pc3d01 sw1_pad(.PAD(sw1),.CIN(net_sw1));
pc3d01 sw2_pad(.PAD(sw2),.CIN(net_sw2));
pc3d01 sw3_pad(.PAD(sw3),.CIN(net_sw3));
pc3d01 sw4_pad(.PAD(sw4),.CIN(net_sw4));

pc3o05 outdata_pad_0(.I(net_outdata[0]),.PAD(outdata[0]));
pc3o05 outdata_pad_1(.I(net_outdata[1]),.PAD(outdata[1]));
pc3o05 outdata_pad_2(.I(net_outdata[2]),.PAD(outdata[2]));
pc3o05 outdata_pad_3(.I(net_outdata[3]),.PAD(outdata[3]));
pc3o05 outdata_pad_4(.I(net_outdata[4]),.PAD(outdata[4]));
pc3o05 outdata_pad_5(.I(net_outdata[5]),.PAD(outdata[5]));
pc3o05 outdata_pad_6(.I(net_outdata[6]),.PAD(outdata[6]));
pc3o05 outdata_pad_7(.I(net_outdata[7]),.PAD(outdata[7]));

pc3o05 ackflag_pad_0(.I(net_ackflag[0]),.PAD(ackflag[0]));
pc3o05 ackflag_pad_1(.I(net_ackflag[1]),.PAD(ackflag[1]));
pc3o05 ackflag_pad_2(.I(net_ackflag[2]),.PAD(ackflag[2]));

pc3o05 scl_pad(.I(net_scl),.PAD(scl));
assign net_sda=net_sda_link?'bz:net_sda_i;
assign net_sda_o=net_sda_link?net_sda:'bz;
pc3b03 sda_pad(.I(net_sda_o),.OEN(net_sda_link),.CIN(net_sda_i),.PAD(sda));
endmodule 




module iic( 

        clk,
		rst_n, 
	    REG_WR,
		IDAT,             //数据端口
		addr,
        sw1,sw2,sw3,sw4,  //读写选择,低有效，不能同时置数
	    scl,
		sda, 
        ackflag, 
		sda_link,//用作仿真时候使用，表示sda状态位
        outdata 
        ); 
//			    DEVICE,//      //被寻址器件地址
//				WRITE_DATA0,//       单写的数据,连写时不必注意
//				WRITE_DATA1,//         //连写的数据 支持最大四个数据
//				WRITE_DATA2,    //
//				WRITE_DATA3,   // 
//				WRITE_DATA4,  //
//				PAGEDATA_NUM, //  		页读页写数据个数
//				BYTE_ADDR,//   //写入EEPROM的地址寄存器  
//              BYTE_WRADDR      

  
input REG_WR;
input [7:0]IDAT;
input [2:0]addr;
input clk;      // 1MHz 

input rst_n;    //复位信号，低有效 

input sw1,sw2,sw3,sw4;  //按键,(1按下执行写入操作，2按下执行读操作，3按下执行连写操作，4按下执行连读操作) 

output scl;     //时钟端口 

output [2:0]ackflag;//后面显示接收到数据的标准 

inout sda;      //数据端口 

output [7:0] outdata;   //数码管显示的数据 

 


//--------------------------------------------- 

        //分频部分 

reg[2:0] cnt;   // cnt=0:scl上升沿，cnt=1:scl高电平中间，cnt=2:scl下降沿，cnt=3:scl低电平中间 

reg[8:0] cnt_delay; //500循环计数，产生iic所需要的时钟 

reg scl_r;      //时钟脉冲寄存器 

  

always @ (posedge clk or negedge rst_n) 

    if(!rst_n) cnt_delay <= 9'd0; 

    else if(cnt_delay == 9'd99) cnt_delay <= 9'd0;  //计数到10us为scl的周期，即100KHz 

    else cnt_delay <= cnt_delay+1'b1;    //时钟计数 

  

always @ (posedge clk or negedge rst_n) begin 

    if(!rst_n) cnt <= 3'd5; 

    else begin 

        case (cnt_delay) 

            9'd25: cnt <= 3'd1; //cnt=1:scl高电平中间,用于数据采样 

            9'd52: cnt <= 3'd2; //cnt=2:scl下降沿后面点 

            9'd76: cnt <= 3'd3; //cnt=3:scl低电平中间,用于数据变化 

            9'd98: cnt <= 3'd0; //cnt=0:scl上升沿前面点 

            default: cnt <= 3'd5; 

            endcase 

        end 

end 

  

  

`define SCL_POS     (cnt==3'd0)     //cnt=0:scl上升沿前面点 

`define SCL_HIG     (cnt==3'd1)     //cnt=1:scl高电平中间,用于数据采样 

`define SCL_NEG     (cnt==3'd2)     //cnt=2:scl下降沿后面点 

`define SCL_LOW     (cnt==3'd3)     //cnt=3:scl低电平中间,用于数据变化 

  

  

always @ (posedge clk or negedge rst_n) 

    if(!rst_n) scl_r <= 1'b0; 

    else if(cnt_delay==9'd99) scl_r <= 1'b1;    //scl信号上升沿 

    else if(cnt_delay==9'd49) scl_r <= 1'b0;    //scl信号下降沿 

  

assign scl = scl_r; //产生iic所需要的时钟 

//--------------------------------------------- 

reg [6:0] DEVICE;//     //被寻址器件地址（写操作） 
reg [7:0]DEVICE_WRITE;
reg [7:0] WRITE_DATA0;//     8'b1000_1000     

reg [7:0] WRITE_DATA1;//     8'b0010_0001    //写入的数据 
reg [7:0] WRITE_DATA2;     //8'b0100_0011 

reg [7:0] WRITE_DATA3;    //8'b0110_0101 

reg [7:0] WRITE_DATA4;   //8'b1000_0111 
reg [7:0] BYTE_ADDR;//  8'b0000_0100    //写入的地址寄存器  

reg [4:0]   PAGEDATA_NUM;        //页读页写数据个数 
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		DEVICE<=0;
		PAGEDATA_NUM<=0;
		WRITE_DATA0<=0;
		WRITE_DATA1<=0;
		WRITE_DATA2<=0;
		WRITE_DATA3<=0;
		WRITE_DATA4<=0;
		BYTE_ADDR<=0;
	end
	else
	begin
		if(REG_WR)
		begin
		case(addr)
		3'b000:
		DEVICE<=IDAT[6:0];
		3'b001:
		BYTE_ADDR<=IDAT;
		3'b010:
		PAGEDATA_NUM<=IDAT;
		3'b011:
		WRITE_DATA0<=IDAT;
		3'b100:
		WRITE_DATA1<=IDAT;
		
		3'b101:
		WRITE_DATA2<=IDAT;
		
		3'b110:
		WRITE_DATA3<=IDAT;
		
		3'b111:
		WRITE_DATA4<=IDAT;
		
		endcase	
		end
	end

end

reg[7:0] db_r;      //在IIC上传送的数据寄存器 

reg[7:0] read_data; //读出EEPROM的数据寄存器 

reg[7:0] outdata_r; //输出数据贮存器 



//--------------------------------------------- 

        //读、写时序 

parameter   IDLE    = 17'b0_0000_0000_0000_0001;//初始态 

parameter   START1  = 17'b0_0000_0000_0000_0010;//起始信号 

parameter   ADD1    = 17'b0_0000_0000_0000_0100;//写入器件地址 

parameter   ACK1    = 17'b0_0000_0000_0000_1000;//应答 

parameter   ADD2    = 17'b0_0000_0000_0001_0000;//写入字节地址 

parameter   ACK2    = 17'b0_0000_0000_0010_0000;//应答 

parameter   START2  = 17'b0_0000_0000_0100_0000;//读操作开始前的起始信号 

parameter   ADD3    = 17'b0_0000_0000_1000_0000;//写入器件地址 

parameter   ACK3    = 17'b0_0000_0001_0000_0000;//应答 

parameter   ACKR    = 17'b1_0000_0000_0000_0000;//fpga给应答 

parameter   DATA    = 17'b0_0000_0010_0000_0000;//字节读写 

parameter   PAGER   = 17'b0_0000_0100_0000_0000;//页读 

parameter   PAGEW   = 17'b0_0000_1000_0000_0000;//页写 

parameter   ACK4    = 17'b0_0001_0000_0000_0000;//应答 

parameter   HIGH    = 17'b0_0010_0000_0000_0000;//高电平 

parameter   STOP1   = 17'b0_0100_0000_0000_0000;//停止位 

parameter   STOP2   = 17'b0_1000_0000_0000_0000;//延时同步 

  

  

reg[16:0] cstate;   //状态寄存器 

reg sda_r;      //输出数据寄存器 

output reg sda_link;   //输出数据sda信号inout方向控制位        

reg[3:0] num;   //读写的字节计数 

reg[2:0] ackflag;//连读时的数据标志 

reg[2:0] pagecnt;//连读连写时的数据计数器 

reg[7:0] pagedata_r;//连读储存器 

  

always @ (posedge clk or negedge rst_n) begin 

    if(!rst_n) begin 

            pagedata_r <= 8'd0; 

                end 

    else begin 

            case(pagecnt) 

                3'd0:   pagedata_r <= WRITE_DATA1; 

                3'd1:   pagedata_r <= WRITE_DATA2; 

                3'd2:   pagedata_r <= WRITE_DATA3; 

                3'd3:   pagedata_r <= WRITE_DATA4; 

                default:; 

            endcase 

         end 

end 

//---------------------------------------状态机---------------------------------------------// 

always@(posedge clk or negedge rst_n) begin 

    if(!rst_n) begin 

            cstate <= IDLE; 

            sda_r <= 1'b1; 

            sda_link <= 1'b0; 

            num <= 4'd0; 

            ackflag <= 3'd0; 

            pagecnt <= 3'd0; 

            read_data <= 8'b0000_0000; 

            outdata_r <= 8'b0000_0000; 
				DEVICE_WRITE <= 0;

        end 

    else      

        case (cstate) 

            IDLE:   begin 

                    sda_link <= 1'b1;            //数据线sda为input 

                    sda_r <= 1'b1; 

                    read_data <= 8'b0000_0000; 

                    //ackflag <= 3'd0; 
						  if(!sw1 || !sw3)
						  DEVICE_WRITE <= {DEVICE,1'b0};
						  if(!sw2 || !sw4)
						  DEVICE_WRITE <= {DEVICE,1'b1};

                    if(!sw1 || !sw2 || !sw3 || !sw4) begin    //SW1,SW2,SW3,SW4键有一个被按下           

                        db_r <= DEVICE_WRITE;                       //送器件地址（写操作） 

                        cstate <= START1;         

                        end 

                    else cstate <= IDLE; //没有任何键被按下 

                end 

            START1: begin 

                    if(`SCL_HIG) begin      //scl为高电平期间 

                        sda_link <= 1'b1;    //数据线sda为output 

                        sda_r <= 1'b0;       //拉低数据线sda，产生起始位信号 

                        cstate <= ADD1; 

                        ackflag <= 1'b0; 

                        num <= 4'd0;     //num计数清零 

                        end 

                    else cstate <= START1; //等待scl高电平中间位置到来 

                end 

            ADD1:   begin 

                    if(`SCL_LOW) begin 

                            if(num == 4'd8) begin    

                                    num <= 4'd0;         //num计数清零 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda置为高阻态(input) 

                                    cstate <= ACK1; 

                                end 

                            else begin 

                                    cstate <= ADD1; 

                                    num <= num+1'b1; 

                                    case (num) 

                                        4'd0: sda_r <= db_r[7]; 

                                        4'd1: sda_r <= db_r[6]; 

                                        4'd2: sda_r <= db_r[5]; 

                                        4'd3: sda_r <= db_r[4]; 

                                        4'd4: sda_r <= db_r[3]; 

                                        4'd5: sda_r <= db_r[2]; 

                                        4'd6: sda_r <= db_r[1]; 

                                        4'd7: sda_r <= db_r[0]; 

                                        default: ; 

                                        endcase 

                                end 

                        end 

                    else cstate <= ADD1; 

                end 

            ACK1:   begin 

                    if(`SCL_NEG) begin   

                            cstate <= ADD2;  //从机响应信号 

                            db_r <= BYTE_ADDR;  // 1地址       

                        end 

                    else cstate <= ACK1;     //等待从机响应 

                end  

            ADD2:   begin 

                    if(`SCL_LOW) begin 

                            if(num==4'd8) begin  

                                    num <= 4'd0;         //num计数清零 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda置为高阻态(input) 

                                    cstate <= ACK2; 

                                end 

                            else begin 

                                    sda_link <= 1'b1;        //sda作为output 

                                    num <= num+1'b1; 

                                    case (num) 

                                        4'd0: sda_r <= db_r[7]; 

                                        4'd1: sda_r <= db_r[6]; 

                                        4'd2: sda_r <= db_r[5]; 

                                        4'd3: sda_r <= db_r[4]; 

                                        4'd4: sda_r <= db_r[3]; 

                                        4'd5: sda_r <= db_r[2]; 

                                        4'd6: sda_r <= db_r[1]; 

                                        4'd7: sda_r <= db_r[0]; 

                                        default: ; 

                                        endcase  

                                    cstate <= ADD2;                   

                                end 

                        end 

                    else cstate <= ADD2;              

                end 

            ACK2:   begin 

                    if(`SCL_NEG) begin      //从机响应信号 

                        if(!sw1) begin 

                                cstate <= DATA;  //写操作 

                                db_r <= WRITE_DATA0;    //写入的数据1                             

                            end  
								else if(!sw2) begin 

                            cstate <= DATA;  //从机响应信号 

                            sda_link <= 1'b0; 

                        end 

								else if(!sw4) begin 

                            cstate <= PAGER; //从机响应信号 

                            ackflag <= ackflag +1'd1; 

                            sda_link <= 1'b0; 

                        end 
                        else if(!sw3) begin       //连写 


                                cstate <= PAGEW; 

                        end 

                    else cstate <= ACK2; //等待从机响应 

                    end 

                    end 

            ACKR:   begin 

                    sda_r <= 0;      //主控制器应答 

                    if(`SCL_NEG && !sw4) begin 

                            cstate <= PAGER; 

                            ackflag <= ackflag +1'd1; 

                            sda_link <= 1'b0; 

                    end 

                    else cstate <= ACKR;      

                    end  

            DATA:   begin 

                    if(!sw2) begin     //读操作 

                            if(num<=4'd7) begin 

                                cstate <= DATA; 

                                if(`SCL_HIG) begin   

                                    num <= num+1'b1;  

                                    case (num) 

                                        4'd0: read_data[7] <= sda; 

                                        4'd1: read_data[6] <= sda;   

                                        4'd2: read_data[5] <= sda;  

                                        4'd3: read_data[4] <= sda;  

                                        4'd4: read_data[3] <= sda;  

                                        4'd5: read_data[2] <= sda;  

                                        4'd6: read_data[1] <= sda;  

                                        4'd7: read_data[0] <= sda;  

                                        default: ; 

                                        endcase                                                                      

                                    end 

                                end 

                            else if((`SCL_LOW) && (num==4'd8)) begin 

                                num <= 4'd0;         //num计数清零 

                                //cstate <= ACK4; 

                                sda_link <= 1'b1;        //无应答 

                                outdata_r <= read_data; 

                                ackflag <= 3'd1;     //1个数 

                                cstate <= HIGH; 

                                  

                                end 

                            else cstate <= DATA; 

                        end 

                    else if(!sw1) begin   //写操作 

                            sda_link <= 1'b1;     

                            if(num<=4'd7) begin 

                                cstate <= DATA; 

                                if(`SCL_LOW) begin 

                                    sda_link <= 1'b1;        //数据线sda作为output 

                                    num <= num+1'b1; 

                                    case (num) 

                                        4'd0: sda_r <= db_r[7]; 

                                        4'd1: sda_r <= db_r[6]; 

                                        4'd2: sda_r <= db_r[5]; 

                                        4'd3: sda_r <= db_r[4]; 

                                        4'd4: sda_r <= db_r[3]; 

                                        4'd5: sda_r <= db_r[2]; 

                                        4'd6: sda_r <= db_r[1]; 

                                        4'd7: sda_r <= db_r[0]; 

                                        default: ; 

                                        endcase                                  

                                    end 

                                end 

                            else if((`SCL_LOW) && (num==4'd8)) begin 

                                    num <= 4'd0; 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda置为高阻态 

                                    cstate <= ACK4; 

                                end 

                            else cstate <= DATA; 

                        end 

                end 

            PAGEW:begin 

                    sda_link <= 1'b1;    //sda为输出 

                    

                        if(num<=4'd7) begin 

                            cstate <= PAGEW; 

                            if(`SCL_LOW) begin 

                                sda_link <= 1'b1;        //数据线sda作为output 

                                num <= num+1'b1; 

                                case (num) 

                                    4'd0: sda_r <= pagedata_r[7]; 

                                    4'd1: sda_r <= pagedata_r[6]; 

                                    4'd2: sda_r <= pagedata_r[5]; 

                                    4'd3: sda_r <= pagedata_r[4]; 

                                    4'd4: sda_r <= pagedata_r[3]; 

                                    4'd5: sda_r <= pagedata_r[2]; 

                                    4'd6: sda_r <= pagedata_r[1]; 

                                    4'd7: sda_r <= pagedata_r[0]; 

                                    default: ; 

                                endcase  

                                end 

                        end 

                        else if((`SCL_LOW) && (num==4'd8)&&(pagecnt < PAGEDATA_NUM-1'b1)) begin 

                                    num <= 4'd0; 

                                    pagecnt <= pagecnt +1'd1; 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda置为高阻态 

                                    cstate <= ACK2; 

                                    end 

                        else if((`SCL_LOW) && (num==4'd8) && (pagecnt == PAGEDATA_NUM -1'b1)) begin 

                                    num <= 4'd0; 

                                    //pagecnt <= pagecnt +1'd1; 

                                    pagecnt <= 1'd0; 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0; 

                                    cstate <= ACK4; 

                                    end 

                        else cstate <= PAGEW; 

                  end 

                  //end 

            PAGER:begin  

          

                        if(num<=4'd7) begin 

                            cstate <= PAGER; 

                            if(`SCL_LOW) begin 

                                num <= num+1'b1; 

                                case (num) 

                                    4'd0: read_data[7] <= sda; 

                                    4'd1: read_data[6] <= sda;   

                                    4'd2: read_data[5] <= sda;  

                                    4'd3: read_data[4] <= sda;  

                                    4'd4: read_data[3] <= sda;  

                                    4'd5: read_data[2] <= sda;  

                                    4'd6: read_data[1] <= sda;  

                                    4'd7: read_data[0] <= sda;  

                                    default: ; 

                                endcase  

                                end                                          

                        end 

                        else if((`SCL_LOW) && (num==4'd8)&& (pagecnt < PAGEDATA_NUM-1'b1)) begin 

                                    num <= 4'd0; 

                                    pagecnt <= pagecnt +1'd1; 

                                    outdata_r <= read_data; 

                                    //ackflag <= ackflag +1'd1; 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b1;        //主控制器应答 

                                    cstate <= ACKR; 

                                    end 

                        else if((`SCL_LOW) && (num==4'd8) && (pagecnt == PAGEDATA_NUM -1'b1)) begin 

                                    num <= 4'd0; 

                                    //pagecnt <= pagecnt +1'd1; 

                                    outdata_r <= read_data; 

                                    ackflag <= ackflag +1'b1; 

                                    pagecnt <= 1'd0; 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b1; 

                                    cstate <= HIGH; 

                                    end 

                        else cstate <= PAGER; 

                        end 

                        //end 

            ACK4: begin                                     //写操作最后个应答 

                    if(`SCL_NEG) begin 

                        cstate <= STOP1;                      

                        end 

                    else cstate <= ACK4; 

                end 

            HIGH: begin 

                    if(`SCL_NEG)begin 

                        sda_r <= 1'd1; 

                        //ackflag <= ackflag +1'd1; 

                        cstate <= STOP1; 

                        end 

                    else cstate <= HIGH; 

                  end 

            STOP1:  begin 

                    if(`SCL_LOW) begin 

                            sda_link <= 1'b1; 

                            sda_r <= 1'b0; 

                            cstate <= STOP1; 

                        end 

                    else if(`SCL_HIG) begin 

                            sda_r <= 1'b1;   //scl为高时，sda产生上升沿（结束信号） 

                            cstate <= IDLE; 

                        end 

                    else cstate <= STOP1; 

                end 

            default: cstate <= IDLE; 

            endcase 

end 

  

assign sda = sda_link ? sda_r:1'bz; 

assign outdata = outdata_r; 

  

//--------------------------------------------------------- 

  

endmodule 

 
