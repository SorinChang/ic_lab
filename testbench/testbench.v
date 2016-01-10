`timescale 1ns/10ps
module testbench();

reg   clk;
reg   rst_b;

wire  cnt_end;

reg   cnt_en;

reg  [7:0]  clk_cnt;

initial
begin
    clk = 1'b0;
    rst_b = 1'b1;
    cnt_en = 1'b0;

#200 
    rst_b = 1'b0;

#100 
    rst_b = 1'b1;
    $display("reset process is end");

#300
    cnt_en = 1'b1;
    $display("cnt_en is %b", cnt_en); 
end

always #5 clk = ~clk;

always @ (posedge clk or negedge rst_b)
begin
    if (cnt_end)
    begin
       $display ("cnt_end = 1'b1; project is end");
       #400 $finish;
    end
end

// module instance
test my_test(
    .clk(clk),
    .rst_b(rst_b),
    .cnt_en(cnt_en),
    .cnt_end(cnt_end)
    );


initial
begin
    $dumpfile("./test.vcd") ;
end

endmodule
