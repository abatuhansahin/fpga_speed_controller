`timescale 1ns / 1ps

module speed_control_top (
    input clk_100mhz,  // Ana osilatör (100 MHz)
    input rst,         
    input [1:0] sw,    // sw[1]=SW1, sw[0]=SW0
    output [3:0] led   // Hız göstergesi için 4 LED
);

    wire clk_slow;  // 5 MHz
    wire clk_med;   // 50 MHz
    wire clk_fast;  // 100 MHz
    wire locked;    // IP'nin stabil çalıştığını gösteren sinyal

    // 1. Clocking Wizard IP 
    clk_wiz_0 clk_ip_inst (
        .clk_in1(clk_100mhz),
        .reset(rst),
        .clk_out1(clk_slow),
        .clk_out2(clk_med),
        .clk_out3(clk_fast),
        .locked(locked)
    );

    // 2. Clock Multiplexer 
    reg clk_selected;
    
    always @(*) begin
        case(sw)
            2'b00: clk_selected = 1'b0;      // Mod 0: Sistem durdur (Saat sinyali kesildi
            2'b01: clk_selected = clk_slow;  // Mod 1: 5 MHz (Çok yavaş)
            2'b10: clk_selected = clk_med;   // Mod 2: 50 MHz (Orta)
            2'b11: clk_selected = clk_fast;  // Mod 3: 100 MHz (Çok hızlı)
            default: clk_selected = 1'b0;
        endcase
    end

    // 3. LED Counter (Sayaç Bloğu)
    reg [26:0] counter = 0;

    always @(posedge clk_selected or posedge rst) begin
        if (rst || !locked) begin
            counter <= 27'd0;
        end else begin
            counter <= counter + 1;
        end
    end

    // 4. Çıkış Ataması
    // Sayacın en üst 4 biti LED'lere bağlanır
  assign led = counter[26:23];

endmodule