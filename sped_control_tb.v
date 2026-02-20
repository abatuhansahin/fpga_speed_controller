`timescale 1ns / 1ps

module tb_speed_control;

    reg clk_100mhz;
    reg rst;
    reg [1:0] sw;
    wire [3:0] led;

    speed_control_top uut (
        .clk_100mhz(clk_100mhz),
        .rst(rst),
        .sw(sw),
        .led(led)
    );

    // 100MHz Ana osilatör simülasyonu 
    always #5 clk_100mhz = ~clk_100mhz;

    initial begin
        // Başlangıç değerleri
        clk_100mhz = 0;
        rst = 1;
        sw = 2'b00;

        // Reset'i 100 ns tut ve kaldır
        #100;
        rst = 0;

        // Clocking Wizard IP'sinin uyanması için bekleme locked=1
        #6000; 

        // 1. Mod: SW=01 -> clk_slow (5 MHz)
        // Sistem artık uyanık olduğu için sayaç anında saymaya başlayacak
        sw = 2'b01;
        #10000; // 10 mikrosaniye boyunca bu modda kalır

        // 2. Mod: SW=10 -> clk_med (50 MHz)
        sw = 2'b10;
        #10000;

        // 3. Mod: SW=11 -> clk_fast (100 MHz)
        sw = 2'b11;
        #10000;

        // 4. Mod: Tekrar Durdur (SW=00)
        sw = 2'b00;
        #5000;

        // Simülasyonu bitir
        $finish;
    end
    
endmodule