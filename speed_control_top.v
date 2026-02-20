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
    
    // 1. iş : sw0 durumuna göre alt ve üst hız gruplarını ayrıldı
    (* dont_touch = "true" *) wire clk_mux_lower = (sw[0]) ? clk_slow : 1'b0;
    (* dont_touch = "true" *) wire clk_mux_upper = (sw[0]) ? clk_fast : clk_med;

    // Kademe 2: sw1 durumuna göre nihai saati seçildi
    (* dont_touch = "true" *) wire clk_final_mux = (sw[1]) ? clk_mux_upper : clk_mux_lower;

    // 3. Global Clock Buffer 
    // Toprak yoldan gelen saati al
    wire clk_selected;
    BUFG bufg_inst (
        .I(clk_final_mux),
        .O(clk_selected)
    );

    // 4. LED Counter (Sayaç Bloğu)
    reg [26:0] counter = 0;

    always @(posedge clk_selected or posedge rst) begin
        if (rst || !locked) begin
            counter <= 27'd0;
        end else begin
            counter <= counter + 1;
        end
    end

    // 5. Çıkış Ataması
    // Sayacın en üst 4 biti LED'lere bağlanır
    assign led = counter[26:23];

endmodule