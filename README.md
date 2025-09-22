# IP_uart_in_fpga
Xây dựng khối chức năng giao tiếp UART trên FPGA Altera Cyclone IV EP4CE6E22C8N hỗ trợ cho đồ án tốt nghiệp
Khối giao tiếp UART trước đó tôi thực hiện với nguyên lý lấy mẫu đơn dựa theo BAUD_DIV. Mỗi bit UART được xử lý trong một khoảng thời gian cố định bằng BAUD_DIV chu kỳ clock.

Sau khi tham khảo ở Chapter 12 cuốn 
"FPGA PROTOTYPING BY SYSTEMVERILOG EXAMPLES"

Xilinx MicroBlaze MCS SoC Edition

Pong P.Chu

Tôi đã chỉnh sửa cách lấy mẫu, thay vì lấy mẫu đơn thì tôi thực hiện lấy mẫu 16x với TICK_DIV. Mỗi bit UART được duy trì trong 16tick mỗi tick kéo dài TICK_DIV chu kỳ clock. Khi đếm tick đếm 8 nghĩa là dữ liệu sẽ được chốt lưu vào trong buffer ở giữa xung của bit UART cũng là lúc tín hiệu của bit được ổn định nhất. Từ đó cải thiện độ chính xác ở tốc đô baud cao tăng hiệu suất cho hệ thống.
