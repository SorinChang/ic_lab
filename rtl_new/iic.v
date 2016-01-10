


module iic( 

        clk,
		rst_n, 
	    REG_WR,
		IDAT,             //���ݶ˿�
		addr,
        sw1,sw2,sw3,sw4,  //��дѡ��,����Ч������ͬʱ����
	    scl,
		sda, 
        ackflag, 
		sda_link,//��������ʱ��ʹ�ã���ʾsda״̬λ
        outdata��
		done
        ); 
//			    DEVICE,//      //��Ѱַ������ַ
//				BYTE_ADDR,//   //д��EEPROM�ĵ�ַ�Ĵ��� 
//				PAGEDATA_NUM, //  		ҳ��ҳд���ݸ���
 //				WRITE_DATA0,//       ��д������,��дʱ����ע��
//				WRITE_DATA1,//         //��д������ ֧������ĸ�����
//				WRITE_DATA2,    //
//				WRITE_DATA3,   // 
//				WRITE_DATA4,  //   

  
input REG_WR;
input [7:0]IDAT;
input [2:0]addr;
input clk;      // 1MHz 

input rst_n;    //��λ�źţ�����Ч 

input sw1,sw2,sw3,sw4;  //����,(1����ִ��д�������2����ִ�ж�������3����ִ����д������4����ִ����������) 

output scl;     //ʱ�Ӷ˿� 

output [2:0]ackflag;//������ʾ���յ����ݵı�׼ 

inout sda;      //���ݶ˿� 

output [7:0] outdata;   //�������ʾ������ 

output reg done;


//--------------------------------------------- 

        //��Ƶ���� 

reg[2:0] cnt;   // cnt=0:scl�����أ�cnt=1:scl�ߵ�ƽ�м䣬cnt=2:scl�½��أ�cnt=3:scl�͵�ƽ�м� 

reg[8:0] cnt_delay; //500ѭ������������iic����Ҫ��ʱ�� 

reg scl_r;      //ʱ������Ĵ��� 

  

always @ (posedge clk or negedge rst_n) 

    if(!rst_n) cnt_delay <= 9'd0; 

    else if(cnt_delay == 9'd99) cnt_delay <= 9'd0;  //������10usΪscl�����ڣ���100KHz 

    else cnt_delay <= cnt_delay+1'b1;    //ʱ�Ӽ��� 

  

always @ (posedge clk or negedge rst_n) begin 

    if(!rst_n) cnt <= 3'd5; 

    else begin 

        case (cnt_delay) 

            9'd25: cnt <= 3'd1; //cnt=1:scl�ߵ�ƽ�м�,�������ݲ��� 

            9'd52: cnt <= 3'd2; //cnt=2:scl�½��غ���� 

            9'd76: cnt <= 3'd3; //cnt=3:scl�͵�ƽ�м�,�������ݱ仯 

            9'd98: cnt <= 3'd0; //cnt=0:scl������ǰ��� 

            default: cnt <= 3'd5; 

            endcase 

        end 

end 

  

  

`define SCL_POS     (cnt==3'd0)     //cnt=0:scl������ǰ��� 

`define SCL_HIG     (cnt==3'd1)     //cnt=1:scl�ߵ�ƽ�м�,�������ݲ��� 

`define SCL_NEG     (cnt==3'd2)     //cnt=2:scl�½��غ���� 

`define SCL_LOW     (cnt==3'd3)     //cnt=3:scl�͵�ƽ�м�,�������ݱ仯 

  

  

always @ (posedge clk or negedge rst_n) 

    if(!rst_n) scl_r <= 1'b0; 

    else if(cnt_delay==9'd99) scl_r <= 1'b1;    //scl�ź������� 

    else if(cnt_delay==9'd49) scl_r <= 1'b0;    //scl�ź��½��� 

  

assign scl = scl_r; //����iic����Ҫ��ʱ�� 

//--------------------------------------------- 

reg [6:0] DEVICE;//     //��Ѱַ������ַ��д������ 
reg [7:0]DEVICE_WRITE;
reg [7:0] WRITE_DATA0;//     8'b1000_1000     

reg [7:0] WRITE_DATA1;//     8'b0010_0001    //д������� 
reg [7:0] WRITE_DATA2;     //8'b0100_0011 

reg [7:0] WRITE_DATA3;    //8'b0110_0101 

reg [7:0] WRITE_DATA4;   //8'b1000_0111 
reg [7:0] BYTE_ADDR;//  8'b0000_0100    //д��ĵ�ַ�Ĵ���  

reg [4:0]   PAGEDATA_NUM;        //ҳ��ҳд���ݸ��� 
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

reg[7:0] db_r;      //��IIC�ϴ��͵����ݼĴ��� 

reg[7:0] read_data; //����EEPROM�����ݼĴ��� 

reg[7:0] outdata_r; //������������� 



//--------------------------------------------- 

        //����дʱ�� 

parameter   IDLE    = 17'b0_0000_0000_0000_0001;//��ʼ̬ 

parameter   START1  = 17'b0_0000_0000_0000_0010;//��ʼ�ź� 

parameter   ADD1    = 17'b0_0000_0000_0000_0100;//д��������ַ 

parameter   ACK1    = 17'b0_0000_0000_0000_1000;//Ӧ�� 

parameter   ADD2    = 17'b0_0000_0000_0001_0000;//д���ֽڵ�ַ 

parameter   ACK2    = 17'b0_0000_0000_0010_0000;//Ӧ�� 

parameter   START2  = 17'b0_0000_0000_0100_0000;//��������ʼǰ����ʼ�ź� 

parameter   ADD3    = 17'b0_0000_0000_1000_0000;//д��������ַ 

parameter   ACK3    = 17'b0_0000_0001_0000_0000;//Ӧ�� 

parameter   ACKR    = 17'b1_0000_0000_0000_0000;//fpga��Ӧ�� 

parameter   DATA    = 17'b0_0000_0010_0000_0000;//�ֽڶ�д 

parameter   PAGER   = 17'b0_0000_0100_0000_0000;//ҳ�� 

parameter   PAGEW   = 17'b0_0000_1000_0000_0000;//ҳд 

parameter   ACK4    = 17'b0_0001_0000_0000_0000;//Ӧ�� 

parameter   HIGH    = 17'b0_0010_0000_0000_0000;//�ߵ�ƽ 

parameter   STOP1   = 17'b0_0100_0000_0000_0000;//ֹͣλ 

parameter   STOP2   = 17'b0_1000_0000_0000_0000;//��ʱͬ�� 

  

  

reg[16:0] cstate;   //״̬�Ĵ��� 

reg sda_r;      //������ݼĴ��� 

output reg sda_link;   //�������sda�ź�inout�������λ        

reg[3:0] num;   //��д���ֽڼ��� 

reg[2:0] ackflag;//����ʱ�����ݱ�־ 

reg[2:0] pagecnt;//������дʱ�����ݼ����� 

reg[7:0] pagedata_r;//���������� 

  

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

//---------------------------------------״̬��---------------------------------------------// 

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
					done < = 1;
					
                    sda_link <= 1'b1;            //������sdaΪinput 

                    sda_r <= 1'b1; 

                    read_data <= 8'b0000_0000; 

                    //ackflag <= 3'd0; 
						  if(!sw1 || !sw3)
						  DEVICE_WRITE <= {DEVICE,1'b0};
						  if(!sw2 || !sw4)
						  DEVICE_WRITE <= {DEVICE,1'b1};

                    if(!sw1 || !sw2 || !sw3 || !sw4) begin    //SW1,SW2,SW3,SW4����һ��������           

                        db_r <= DEVICE_WRITE;                       //��������ַ��д������ 

                        cstate <= START1;         

                        end 

                    else cstate <= IDLE; //û���κμ������� 

                end 

            START1: begin 
					done < = 0;

                    if(`SCL_HIG) begin      //sclΪ�ߵ�ƽ�ڼ� 

                        sda_link <= 1'b1;    //������sdaΪoutput 

                        sda_r <= 1'b0;       //����������sda��������ʼλ�ź� 

                        cstate <= ADD1; 

                        ackflag <= 1'b0; 

                        num <= 4'd0;     //num�������� 

                        end 

                    else cstate <= START1; //�ȴ�scl�ߵ�ƽ�м�λ�õ��� 

                end 

            ADD1:   begin 
					done < = 0;
                    if(`SCL_LOW) begin 

                            if(num == 4'd8) begin    

                                    num <= 4'd0;         //num�������� 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda��Ϊ����̬(input) 

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
					done < = 0;
                    if(`SCL_NEG) begin   

                            cstate <= ADD2;  //�ӻ���Ӧ�ź� 

                            db_r <= BYTE_ADDR;  // 1��ַ       

                        end 

                    else cstate <= ACK1;     //�ȴ��ӻ���Ӧ 

                end  

            ADD2:   begin 
					done < = 0;
                    if(`SCL_LOW) begin 

                            if(num==4'd8) begin  

                                    num <= 4'd0;         //num�������� 

                                    sda_r <= 1'b1; 

                                    sda_link <= 1'b0;        //sda��Ϊ����̬(input) 

                                    cstate <= ACK2; 

                                end 

                            else begin 

                                    sda_link <= 1'b1;        //sda��Ϊoutput 

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
					done < = 0;
                    if(`SCL_NEG) begin      //�ӻ���Ӧ�ź� 

                        if(!sw1) begin 

                                cstate <= DATA;  //д���� 

                                db_r <= WRITE_DATA0;    //д�������1                             

                            end  
								else if(!sw2) begin 

                            cstate <= DATA;  //�ӻ���Ӧ�ź� 

                            sda_link <= 1'b0; 

                        end 

								else if(!sw4) begin 

                            cstate <= PAGER; //�ӻ���Ӧ�ź� 

                            ackflag <= ackflag +1'd1; 

                            sda_link <= 1'b0; 

                        end 
                        else if(!sw3) begin       //��д 


                                cstate <= PAGEW; 

                        end 

                    else cstate <= ACK2; //�ȴ��ӻ���Ӧ 

                    end 

                    end 

            ACKR:   begin 
					done < = 0;
                    sda_r <= 0;      //��������Ӧ�� 

                    if(`SCL_NEG && !sw4) begin 

                            cstate <= PAGER; 

                            ackflag <= ackflag +1'd1; 

                            sda_link <= 1'b0; 

                    end 

                    else cstate <= ACKR;      

                    end  

            DATA:   begin 
					done < = 0;
                    if(!sw2) begin     //������ 

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

                                num <= 4'd0;         //num�������� 

                                //cstate <= ACK4; 

                                sda_link <= 1'b1;        //��Ӧ�� 

                                outdata_r <= read_data; 

                                ackflag <= 3'd1;     //1���� 

                                cstate <= HIGH; 

                                  

                                end 

                            else cstate <= DATA; 

                        end 

                    else if(!sw1) begin   //д���� 

                            sda_link <= 1'b1;     

                            if(num<=4'd7) begin 

                                cstate <= DATA; 

                                if(`SCL_LOW) begin 

                                    sda_link <= 1'b1;        //������sda��Ϊoutput 

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

                                    sda_link <= 1'b0;        //sda��Ϊ����̬ 

                                    cstate <= ACK4; 

                                end 

                            else cstate <= DATA; 

                        end 

                end 

            PAGEW:begin 
					done < = 0;
                    sda_link <= 1'b1;    //sdaΪ��� 

                    

                        if(num<=4'd7) begin 

                            cstate <= PAGEW; 

                            if(`SCL_LOW) begin 

                                sda_link <= 1'b1;        //������sda��Ϊoutput 

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

                                    sda_link <= 1'b0;        //sda��Ϊ����̬ 

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

					done < = 0;

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

                                    sda_link <= 1'b1;        //��������Ӧ�� 

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

            ACK4: begin                                     //д��������Ӧ�� 
					done < = 0;
                    if(`SCL_NEG) begin 

                        cstate <= STOP1;                      

                        end 

                    else cstate <= ACK4; 

                end 

            HIGH: begin 
					done < = 0;
                    if(`SCL_NEG)begin 

                        sda_r <= 1'd1; 

                        //ackflag <= ackflag +1'd1; 

                        cstate <= STOP1; 

                        end 

                    else cstate <= HIGH; 

                  end 

            STOP1:  begin 
					done < = 0;
                    if(`SCL_LOW) begin 

                            sda_link <= 1'b1; 

                            sda_r <= 1'b0; 

                            cstate <= STOP1; 

                        end 

                    else if(`SCL_HIG) begin 

                            sda_r <= 1'b1;   //sclΪ��ʱ��sda���������أ������źţ� 

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

 
