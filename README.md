<img width="1920" height="1054" alt="image" src="https://github.com/user-attachments/assets/f848c28b-4b63-4b58-a18a-db98a1ae0928" /># IP_uart_in_fpga
Xây dựng khối chức năng giao tiếp UART trên FPGA Altera Cyclone IV EP4CE6E22C8N hỗ trợ cho đồ án tốt nghiệp
Khối giao tiếp UART trước đó tôi thực hiện với nguyên lý lấy mẫu đơn dựa theo BAUD_DIV. Mỗi bit UART được xử lý trong một khoảng thời gian cố định bằng BAUD_DIV chu kỳ clock.

Sau khi tham khảo ở Chapter 12 cuốn 
"FPGA PROTOTYPING BY SYSTEMVERILOG EXAMPLES"

Xilinx MicroBlaze MCS SoC Edition

Pong P.Chu

Tôi đã chỉnh sửa cách lấy mẫu, thay vì lấy mẫu đơn thì tôi thực hiện lấy mẫu 16x với TICK_DIV. Mỗi bit UART (434 clk của xung hệ thống 50MHZ) được duy trì trong 16tick mỗi tick kéo dài TICK_DIV chu kỳ clock. Khi đếm tick đếm 8 nghĩa là dữ liệu sẽ được chốt lưu vào trong buffer ở giữa xung của bit UART cũng là lúc tín hiệu của bit được ổn định nhất. Từ đó cải thiện độ chính xác ở tốc đô baud cao tăng hiệu suất cho hệ thống.

Dạng sóng mô phỏng trên Modelsim cho hai module con "RX" và "TX" như sau:
RX: 
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/32e71a82-df40-4de9-b924-74edbe25edad" />

Dạng sóng tại thời điểm dữ liệu thay đổi module RX: 

<img width="1056" height="600" alt="image" src="https://github.com/user-attachments/assets/5eea909e-3253-4e71-99d4-a81dbbe5600d" />

TX:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3530497c-c8b1-4b5f-be30-c1ccbdcf1c1b" />

Dạng sóng tại thời điểm dữ liệu thay đổi module TX: 

<img width="1056" height="600" alt="image" src="https://github.com/user-attachments/assets/47077b3e-9442-4236-89f0-1fd69fef1ad1" />

Dạng sóng cho topmodule uart_string_loopback như sau : 
*tôi gửi lần lượt các giá trị 8bit : 
'A':0100 0001
'H':01001000
'E':01100101
x2'L':01101100
'O':01101111

<img width="1920" height="1054" alt="image" src="https://github.com/user-attachments/assets/2912c9da-647a-4e98-873b-864fc3383431" />

So sánh dạng sóng với chương trình Verilog thì tôi thấy chương trình đang hoạt động chính xác theo máy trạng thái và tuân thủ chính xác theo khung dữ liệu của giao thức UART. Những chính xác này đặt nền móng cho hệ thống lớn sau này.
