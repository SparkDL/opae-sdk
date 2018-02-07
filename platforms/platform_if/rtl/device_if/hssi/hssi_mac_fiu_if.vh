/* ****************************************************************************
 * Copyright(c) 2017-2018, Intel Corporation
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * **************************************************************************/

// Date: April/24/2017
// Compliant with HSSI MAC interface spec v0.4

//
// The interconnect between an Ethernet MAC (on the green side) and the HSSI
// signals connected to the FIU (blue side).
//

`ifndef __HSSI_MAC_FIU_IF_VH__
`define __HSSI_MAC_FIU_IF_VH__

// `ifdef PLATFORM_PROVIDES_HSSI

import hssi_mac_fiu_if_pkg::*;

interface hssi_mac_fiu_if
  #(
    parameter NUM_LN = 4 // Number of HSSI lanes
    )
   ();

    typedef logic [NUM_LN-1:0] t_hssi_mac_ln_flags;

    // clocks and lock flags
    logic f2m_tx_clk;
    logic f2m_tx_clkx2;
    logic f2m_tx_locked;
          
    // All f2m lanes in 10G and 40G are clocked by the ln0 clocks
    logic f2m_rx_clk_ln0;
    logic f2m_rx_clkx2_ln0;
    logic f2m_rx_locked_ln0;
    // ln4 clocks are not used in 10G and 40G modes
    logic f2m_rx_clk_ln4;
    logic f2m_rx_locked_ln4;
    
    // reset signals
    t_hssi_mac_ln_flags m2f_tx_analogreset;
    t_hssi_mac_ln_flags m2f_tx_digitalreset;
    t_hssi_mac_ln_flags m2f_rx_analogreset;
    t_hssi_mac_ln_flags m2f_rx_digitalreset;

    // lock control signals
    t_hssi_mac_ln_flags m2f_rx_seriallpbken;
    t_hssi_mac_ln_flags m2f_rx_set_locktoref;
    t_hssi_mac_ln_flags m2f_rx_set_locktodata;

    // lock flags
    logic               f2m_tx_cal_busy;
    logic               f2m_tx_pll_locked;
    logic               f2m_rx_cal_busy;
    t_hssi_mac_ln_flags f2m_rx_is_lockedtoref;
    t_hssi_mac_ln_flags f2m_rx_is_lockedtodata;

    // parallel data
    t_hssi_mf_ln_data  [NUM_LN-1:0] m2f_tx_parallel_data;
    t_hssi_m2f_ln_ctrl [NUM_LN-1:0] m2f_tx_control;
    t_hssi_mf_ln_data  [NUM_LN-1:0] f2m_rx_parallel_data;
    t_hssi_2fm_ln_ctrl [NUM_LN-1:0] f2m_rx_control;

    // enhanced interface status
    t_hssi_mac_ln_flags f2m_tx_enh_fifo_full;
    t_hssi_mac_ln_flags f2m_tx_enh_fifo_pfull;
    t_hssi_mac_ln_flags f2m_tx_enh_fifo_empty;
    t_hssi_mac_ln_flags f2m_tx_enh_fifo_pempty;
    t_hssi_mac_ln_flags f2m_rx_enh_data_valid;
    t_hssi_mac_ln_flags f2m_rx_enh_fifo_full;
    t_hssi_mac_ln_flags f2m_rx_enh_fifo_pfull;
    t_hssi_mac_ln_flags f2m_rx_enh_fifo_empty;
    t_hssi_mac_ln_flags f2m_rx_enh_fifo_pempty;
    t_hssi_mac_ln_flags f2m_rx_enh_blk_lock;
    t_hssi_mac_ln_flags f2m_rx_enh_highber;
    t_hssi_mac_ln_flags m2f_rx_enh_fifo_rd_en;
    t_hssi_mac_ln_flags m2f_tx_enh_data_valid;

    // HSSI GBS logic initialization
    logic        m2f_init_start;
    logic        f2m_init_done;

    logic        m2f_prmgmt_fatal_err;
    logic [31:0] m2f_prmgmt_dout;

    logic        f2m_prmgmt_ctrl_clk;
    logic [15:0] f2m_prmgmt_cmd;
    logic [15:0] f2m_prmgmt_addr;
    logic [31:0] f2m_prmgmt_din;
    logic        f2m_prmgmt_freeze;
    logic        f2m_prmgmt_arst;
    logic        f2m_prmgmt_ram_ena;

modport to_mac (
    output f2m_tx_clk,
    output f2m_tx_clkx2,
    output f2m_tx_locked,
          
    output f2m_rx_clk_ln0,
    output f2m_rx_clkx2_ln0,
    output f2m_rx_locked_ln0,
    output f2m_rx_clk_ln4,
    output f2m_rx_locked_ln4,
    
    input  m2f_tx_analogreset,
    input  m2f_tx_digitalreset,
    input  m2f_rx_analogreset,
    input  m2f_rx_digitalreset,

    input  m2f_rx_seriallpbken,
    input  m2f_rx_set_locktoref,
    input  m2f_rx_set_locktodata,

    output f2m_tx_cal_busy,
    output f2m_tx_pll_locked,
    output f2m_rx_cal_busy,
    output f2m_rx_is_lockedtoref,
    output f2m_rx_is_lockedtodata,

    input  m2f_tx_parallel_data,
    input  m2f_tx_control,
    output f2m_rx_parallel_data,
    output f2m_rx_control,

    output f2m_tx_enh_fifo_full,
    output f2m_tx_enh_fifo_pfull,
    output f2m_tx_enh_fifo_empty,
    output f2m_tx_enh_fifo_pempty,
    output f2m_rx_enh_data_valid,
    output f2m_rx_enh_fifo_full,
    output f2m_rx_enh_fifo_pfull,
    output f2m_rx_enh_fifo_empty,
    output f2m_rx_enh_fifo_pempty,
    output f2m_rx_enh_blk_lock,
    output f2m_rx_enh_highber,
    input  m2f_rx_enh_fifo_rd_en,
    input  m2f_tx_enh_data_valid,

    input  m2f_init_start,
    output f2m_init_done,

    input  m2f_prmgmt_fatal_err,
    input  m2f_prmgmt_dout,
    output f2m_prmgmt_ctrl_clk,
    output f2m_prmgmt_cmd,
    output f2m_prmgmt_addr,
    output f2m_prmgmt_din,
    output f2m_prmgmt_freeze,
    output f2m_prmgmt_arst,
    output f2m_prmgmt_ram_ena
);

modport to_fiu (
    input  f2m_tx_clk,
    input  f2m_tx_clkx2,
    input  f2m_tx_locked,
       
    input  f2m_rx_clk_ln0,
    input  f2m_rx_clkx2_ln0,
    input  f2m_rx_locked_ln0,
    input  f2m_rx_clk_ln4,
    input  f2m_rx_locked_ln4,
    
    output m2f_tx_analogreset,
    output m2f_tx_digitalreset,
    output m2f_rx_analogreset,
    output m2f_rx_digitalreset,

    output m2f_rx_seriallpbken,
    output m2f_rx_set_locktoref,
    output m2f_rx_set_locktodata,

    input  f2m_tx_cal_busy,
    input  f2m_tx_pll_locked,
    input  f2m_rx_cal_busy,
    input  f2m_rx_is_lockedtoref,
    input  f2m_rx_is_lockedtodata,

    output m2f_tx_parallel_data,
    output m2f_tx_control,
    input  f2m_rx_parallel_data,
    input  f2m_rx_control,

    input  f2m_tx_enh_fifo_full,
    input  f2m_tx_enh_fifo_pfull,
    input  f2m_tx_enh_fifo_empty,
    input  f2m_tx_enh_fifo_pempty,
    input  f2m_rx_enh_data_valid,
    input  f2m_rx_enh_fifo_full,
    input  f2m_rx_enh_fifo_pfull,
    input  f2m_rx_enh_fifo_empty,
    input  f2m_rx_enh_fifo_pempty,
    input  f2m_rx_enh_blk_lock,
    input  f2m_rx_enh_highber,
    output m2f_rx_enh_fifo_rd_en,
    output m2f_tx_enh_data_valid,

    output m2f_init_start,
    input  f2m_init_done,

    output m2f_prmgmt_fatal_err,
    output m2f_prmgmt_dout,
    input  f2m_prmgmt_ctrl_clk,
    input  f2m_prmgmt_cmd,
    input  f2m_prmgmt_addr,
    input  f2m_prmgmt_din,
    input  f2m_prmgmt_freeze,
    input  f2m_prmgmt_arst,
    input  f2m_prmgmt_ram_ena
);

endinterface

// `endif // PLATFORM_PROVIDES_HSSI

`endif // __HSSI_MAC_FIU_IF_VH__
