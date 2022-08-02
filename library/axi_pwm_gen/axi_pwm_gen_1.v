// ***************************************************************************
// ***************************************************************************
// Copyright 2021 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************
`timescale 1ns/1ps

module axi_pwm_gen_1 #(
  // the width and period are defined in number of clock cycles
  parameter   PULSE_WIDTH = 7,
  parameter   PULSE_PERIOD = 100000000
) (
  input               clk,
  input               rstn,

  input       [31:0]  pulse_width,
  input       [31:0]  pulse_period,
  input               load_config,
  input               sync,

  output  reg         pulse,
  output      [31:0]  pulse_counter
);

  // internal registers

  reg     [31:0]               pulse_period_cnt = 32'h0;
  reg     [31:0]               pulse_period_read =  PULSE_PERIOD;
  reg     [31:0]               pulse_width_read = PULSE_WIDTH;
  reg     [31:0]               pulse_period_d = PULSE_PERIOD;
  reg     [31:0]               pulse_width_d = PULSE_WIDTH;
  reg                          phase_align_armed = 1'b1;
  reg                          end_of_pulse;
  reg                          end_of_period;

  // internal wires

  wire                         phase_align;
  wire                         pulse_enable;

  // enable pwm

  assign pulse_enable = (pulse_period_d != 32'd0) ? 1'b1 : 1'b0;

  // flop the desired period

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      pulse_period_d <= pulse_period;
      pulse_width_d <= pulse_width;
      pulse_period_read <= pulse_period;
      pulse_width_read <= pulse_width;
    end else begin
      // load the input period/width values
      if (load_config) begin
        pulse_period_read <= pulse_period;
        pulse_width_read <= pulse_width;
      end
      // update the current period/width at the end of the period
      if (end_of_period | ~pulse_enable) begin
        pulse_period_d <= pulse_period_read;
        pulse_width_d <= pulse_width_read;
      end
    end
  end

  // phase align to the first sync pulse until another load_config

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      phase_align_armed <= 1'b1;
    end else begin
      if (load_config == 1'b1) begin
        phase_align_armed <= sync;
      end else begin
        phase_align_armed <= phase_align_armed & sync;
      end
    end
  end

  assign phase_align = phase_align_armed & sync;

  // a free running counter

  always @(posedge clk) begin
    if (rstn == 1'b0 || phase_align == 1'b1 || end_of_period == 1'b1) begin
      pulse_period_cnt <= 32'd1;
    end else begin
      if (pulse_enable == 1'b1) begin
        pulse_period_cnt <= pulse_period_cnt + 1'b1;
      end
    end
  end

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      end_of_period <= 1'b0;
      end_of_pulse <= 1'b0;
    end else begin
      end_of_period <= (pulse_period_cnt == pulse_period_d) ? 1'b1 : 1'b0;
      end_of_pulse <= (pulse_period_cnt == pulse_width_d) ? 1'b1 : 1'b0;
    end
  end
  // generate pulse with a specified width

  always @ (posedge clk) begin
    if ((rstn == 1'b0) || (phase_align == 1'b1) || (end_of_pulse == 1'b1)) begin
      pulse <= 1'b0;
    end else if (end_of_period == 1'b1 && pulse_enable == 1'b1) begin
      pulse <= 1'b1;
    end
  end

  assign pulse_counter = pulse_period_cnt;

endmodule
