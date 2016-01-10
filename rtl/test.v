`timescale 1ns/10ps

module test(
    clk,
    rst_b,

    cnt_en,
    cnt_end
    );


input    clk;
input    rst_b;
input    cnt_en;
output   cnt_end;

wire     clk;
wire     rst_b;
wire     cnt_en;
wire     cnt_end;

reg  [7:0] cnt;

always @ (posedge clk or negedge rst_b)
begin
    if(~rst_b)
    begin
        cnt <= 8'h0;
    end
    else if (cnt_en)
    begin
        cnt <= cnt + 1;
    end
    else 
    begin
        cnt <= cnt;
    end
end

assign cnt_end = (cnt == 8'hff)? 1'b1 : 1'b0;

endmodule

