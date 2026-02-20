# -------------------------------------------------------------------------
# VOLTAJ AYARLARI (CFGBVS-1 Uyarısı Çözümü)
# -------------------------------------------------------------------------
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# -------------------------------------------------------------------------
# 100 MHz ANA SAAT (Osilatör)
# -------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk_100mhz }]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_100mhz }]

# -------------------------------------------------------------------------
# SWITCHLER (SW1 ve SW0)
# -------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]

# -------------------------------------------------------------------------
# RESET BUTONU (BTNC - Yön tuşlarının ortasındaki buton)
# -------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { rst }]

# -------------------------------------------------------------------------
# LEDLER (Sağdan ilk 4 LED)
# -------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]

