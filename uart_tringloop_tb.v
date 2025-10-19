`timescale 1ns/1ps

module uart_tringloop_tb;

    // Tín hiệu testbench
    reg clk;
    reg rst_n;
    wire tx;
	 reg rx;

    // Tham số UART
    parameter CLK_PERIOD = 20;       // 50 MHz -> 20 ns chu kỳ f=1/t >> t= 20ns
    parameter BAUD_DIV = 434;        // từ module chính
    parameter BIT_PERIOD = BAUD_DIV * CLK_PERIOD;  // thời gian 1 bit UART = 8680 ns

	 uart_string_loopback uut (
	   .clk(clk),
	   .rst_n(rst_n),
	   .rx(rx),
	   .tx(tx)
	 );

    // Tạo xung clock 50 MHz
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Task gửi 1 byte UART (start + 8 data + stop)
    task send_byte;
        input [7:0] data;
		  integer i;
        begin
            rx = 0;
				#(BIT_PERIOD);
				for( i = 0; i < 8 ; i = i + 1) begin
					rx = data[i];
					#(BIT_PERIOD);
				end
				rx = 1;
            #(BIT_PERIOD);
        end
    endtask
	 /*
	 task check_byte;
        input [7:0] expected_data;
        reg [7:0] received_data ;
        integer i;
        begin
            // Chờ start bit
				received_data = 0;
            @(negedge tx);
            
            // Chờ đến giữa bit đầu tiên
            #(BIT_PERIOD * 1.4);
            for (i = 0; i < 8; i = i + 1) begin
                received_data[i] = tx;
                #(BIT_PERIOD);
            end
				 #(BIT_PERIOD);
            // Kiểm tra stop bit
            if (tx !== 1'b1)
                $display("ERROR: Stop bit not detected at time %t", $time);

            // Kiểm tra dữ liệu nhận được
            if (received_data == expected_data)
                $display("PASS: Received byte 0x%h == Expected 0x%h at %t", received_data, expected_data, $time);
            else
                $display("FAIL: Received byte 0x%h != Expected 0x%h at %t", received_data, expected_data, $time);
        end
    endtask
	*/	
    // Khối mô phỏng chính
    initial begin
        // Khởi tạo
        clk = 0;
        rst_n = 0;
		  rx = 1;
		  

        // Reset ngắn
        #100;
        rst_n = 1;

        // Gửi ký tự 'A' (0x41)
        #1000;
		  $display(">> Gửi ký tự A (0x41)");
        send_byte(8'h41);
		  send_byte(8'h48);
		  send_byte(8'h65);
		  send_byte(8'h6C);
		  send_byte(8'h6C);
		  send_byte(8'h6F);
//		  #(10 * BIT_PERIOD);
//		  check_byte(8'h41);
/*
        $display("Test 2: Sending 'Hello'");
        send_byte(8'h48); check_byte(8'h48); // H
        send_byte(8'h65); check_byte(8'h65); // e
        send_byte(8'h6C); check_byte(8'h6C); // l
        send_byte(8'h6C); check_byte(8'h6C); // l
        send_byte(8'h6F); check_byte(8'h6F); // o
*/
        // Dừng mô phỏng
        #10000;
        $stop;
    end

endmodule
