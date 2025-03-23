module booth_tb;
    reg clk,rst,start;
    reg signed [3:0]X,Y;
    wire signed [7:0]Z;
    wire valid;
    always #5 clk = ~clk;
    booth uut (clk,rst,start,X,Y,valid,Z);

    initial begin
        X=5;Y=7;clk=1'b1;rst=1'b0;start=1'b0;
        #10 rst = 1'b1;
        #10 start = 1'b1;
        #10 start = 1'b0;
        @valid
        #10 X=-4;Y=6;start = 1'b1;
        #10 start = 1'b0;
    end
    
    initial begin
        $dumpfile("dump.vcd");    // Name of the VCD file
        $dumpvars(1, uut, booth_tb);   // Dump all signals from the testbench and the DUT
    end

    initial begin
        $monitor($time,"X=%d, Y=%d, valid=%d, Z=%d ",X,Y,valid,Z);
    end

    initial begin
        #1500;
        $finish;
    end
endmodule