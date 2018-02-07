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
// Definitions for the interconnect between an Ethernet MAC (on the green
// side) and the HSSI signals connected to the FIU (blue side).
//

package hssi_mac_fiu_if_pkg;

//=====================================================================
// FIU HSSI to Ethernet MAC interface definitions
//=====================================================================

parameter HSSI_MF_VERSION_NUMBER = 12'h040;

parameter HSSI_MF_LN_DATA_WIDTH  = 128;

parameter HSSI_M2F_LN_CTRL_WIDTH = 18;
parameter HSSI_F2M_LN_CTRL_WIDTH = 20;

// Base types
typedef logic [HSSI_MF_LN_DATA_WIDTH-1:0] t_hssi_mf_ln_data;

typedef logic [HSSI_M2F_LN_CTRL_WIDTH-1:0] t_hssi_m2f_ln_ctrl;
typedef logic [HSSI_F2M_LN_CTRL_WIDTH-1:0] t_hssi_f2m_ln_ctrl;

endpackage // hssi_mac_fiu_if_pkg
