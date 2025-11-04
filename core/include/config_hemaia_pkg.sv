// Copyright 2023 Thales DIS France SAS
//
// Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
// You may obtain a copy of the License at https://solderpad.org/licenses/
//
// Original Author: Jean-Roch COULON - Thales
// Modified by: Fanchen and Yunhao to add the support for multichiplet hemaia
package config_pkg;

  // ---------------
  // Global Config
  // ---------------
  localparam int unsigned ILEN = 32;
  localparam int unsigned NRET = 1;

  localparam int   LocalAddressWidth = 40;
  localparam int   ChipIdWidth = 8; // Number of bits used to identify the chiplet. This is also listed in the cfg files, but I hardcode it here to avoid using Mako template to generate this file.
  typedef logic [ChipIdWidth-1:0] chip_id_t;
  /// The NoC type is a top-level parameter, hence we need a bit more
  /// information on what protocol those type parameters are supporting.
  /// Currently two values are supported"
  typedef enum {
    /// The "classic" AXI4 protocol.
    NOC_TYPE_AXI4_ATOP,
    /// In the OpenPiton setting the WT cache is connected to the L15.
    NOC_TYPE_L15_BIG_ENDIAN,
    NOC_TYPE_L15_LITTLE_ENDIAN
  } noc_type_e;

  /// Cache type parameter
  typedef enum logic [2:0] {
    WB = 0,
    WT = 1,
    HPDCACHE_WT = 2,
    HPDCACHE_WB = 3,
    HPDCACHE_WT_WB = 4
  } cache_type_t;

  /// Branch predictor parameter
  typedef enum logic {
    BHT = 0,  // Bimodal predictor
    PH_BHT = 1  // Private History Bimodal predictor
  } bp_type_t;

  /// Data and Address length
  typedef enum logic [3:0] {
    ModeOff  = 0,
    ModeSv32 = 1,
    ModeSv39 = 8,
    ModeSv48 = 9,
    ModeSv57 = 10,
    ModeSv64 = 11
  } vm_mode_t;

  /// Coprocessor type parameter
  typedef enum {
    COPRO_NONE,
    COPRO_EXAMPLE
  } copro_type_t;

  localparam NrMaxRules = 16;

  typedef struct packed {
    // General Purpose Register Size (in bits)
    int unsigned                 XLEN;
    // Virtual address Size (in bits)
    int unsigned                 VLEN;
    // Atomic RISC-V extension
    bit                          RVA;
    // Bit manipulation RISC-V extension
    bit                          RVB;
    // Scalar Cryptography RISC-V entension
    bit                          ZKN;
    // Vector RISC-V extension
    bit                          RVV;
    // Compress RISC-V extension
    bit                          RVC;
    // Hypervisor RISC-V extension
    bit                          RVH;
    // Zcb RISC-V extension
    bit                          RVZCB;
    // Zcmp RISC-V extension
    bit                          RVZCMP;
    // Zcmt RISC-V extension
    bit                          RVZCMT;
    // CLIC extension
    bit                          RVSCLIC;
    // CLIC virtualization extension (vCLIC)
    bit                          RVXHCLIC;
    // Zicond RISC-V extension
    bit                          RVZiCond;
    // Zicntr RISC-V extension
    bit                          RVZicntr;
    // Zihpm RISC-V extension
    bit                          RVZihpm;
    // Floating Point
    bit                          RVF;
    // Floating Point
    bit                          RVD;
    // Non standard 16bits Floating Point extension
    bit                          XF16;
    // Non standard 16bits Floating Point Alt extension
    bit                          XF16ALT;
    // Non standard 8bits Floating Point extension
    bit                          XF8;
    // TO_BE_COMPLETED
    bit                          XF8ALT;
    // Non standard Vector Floating Point extension
    bit                          XFVec;
    // Perf counters
    bit                          PerfCounterEn;
    // MMU
    bit                          MmuPresent;
    // Supervisor mode
    bit                          RVS;
    // User mode
    bit                          RVU;
    // Software interrupts are enabled
    bit                          SoftwareInterruptEn;
    // Debug support
    bit                          DebugEn;
    // Base address of the debug module
    logic [63:0]                 DmBaseAddress;
    // Address to jump when halt request
    logic [63:0]                 HaltAddress;
    // Address to jump when exception
    logic [63:0]                 ExceptionAddress;
    // Tval Support Enable
    bit                          TvalEn;
    // MTVEC CSR supports only direct mode
    bit                          DirectVecOnly;
    // PMP entries number
    int unsigned                 NrPMPEntries;
    // PMP CSR configuration reset values
    logic [63:0][63:0]           PMPCfgRstVal;
    // PMP CSR address reset values
    logic [63:0][63:0]           PMPAddrRstVal;
    // PMP CSR read-only bits
    bit [63:0]                   PMPEntryReadOnly;
    // PMP NA4 and NAPOT mode enable
    bit                          PMPNapotEn;
    // PMA non idempotent rules number
    int unsigned                 NrNonIdempotentRules;
    // PMA NonIdempotent region base address
    logic [NrMaxRules-1:0][63:0] NonIdempotentAddrBase;
    // PMA NonIdempotent region length
    logic [NrMaxRules-1:0][63:0] NonIdempotentLength;
    // PMA regions with execute rules number
    int unsigned                 NrExecuteRegionRules;
    // PMA Execute region base address
    logic [NrMaxRules-1:0][63:0] ExecuteRegionAddrBase;
    // PMA Execute region address base
    logic [NrMaxRules-1:0][63:0] ExecuteRegionLength;
    // PMA regions with cache rules number
    int unsigned                 NrCachedRegionRules;
    // PMA cache region base address
    logic [NrMaxRules-1:0][63:0] CachedRegionAddrBase;
    // PMA cache region rules
    logic [NrMaxRules-1:0][63:0] CachedRegionLength;
    // CV-X-IF coprocessor interface enable
    bit                          CvxifEn;
    // Coprocessor type
    copro_type_t                 CoproType;
    // NOC bus type
    noc_type_e                   NOCType;
    // Number of interrupt signals from the CLIC.
    int unsigned                 CLICNumInterruptSrc;
    // AXI address width
    int unsigned                 AxiAddrWidth;
    // AXI data width
    int unsigned                 AxiDataWidth;
    // AXI ID width
    int unsigned                 AxiIdWidth;
    // AXI User width
    int unsigned                 AxiUserWidth;
    // AXI burst in write
    bit                          AxiBurstWriteEn;
    // TODO
    int unsigned                 MemTidWidth;
    // Instruction cache size (in bytes)
    int unsigned                 IcacheByteSize;
    // Instruction cache associativity (number of ways)
    int unsigned                 IcacheSetAssoc;
    // Instruction cache line width
    int unsigned                 IcacheLineWidth;
    // Cache Type
    cache_type_t                 DCacheType;
    // Data cache ID
    int unsigned                 DcacheIdWidth;
    // Data cache size (in bytes)
    int unsigned                 DcacheByteSize;
    // Data cache associativity (number of ways)
    int unsigned                 DcacheSetAssoc;
    // Data cache line width
    int unsigned                 DcacheLineWidth;
    // Data cache flush on fence
    bit                          DcacheFlushOnFence;
    // Data cache invalidate on flush
    bit                          DcacheInvalidateOnFlush;
    // User field on data bus enable
    int unsigned                 DataUserEn;
    // Write-through data cache write buffer depth
    int unsigned                 WtDcacheWbufDepth;
    // User field on fetch bus enable
    int unsigned                 FetchUserEn;
    // Width of fetch user field
    int unsigned                 FetchUserWidth;
    // Is FPGA optimization of CV32A6 for Xilinx and Altera
    bit                          FpgaEn;
    // Is FPGA optimization for Altera FPGA
    bit                          FpgaAlteraEn;
    // Is Techno Cut instanciated
    bit                          TechnoCut;
    // Enable superscalar* with 2 issue ports and 2 commit ports.
    bit                          SuperscalarEn;
    // Number of commit ports. Forced to 2 if SuperscalarEn.
    int unsigned                 NrCommitPorts;
    // Load cycle latency number
    int unsigned                 NrLoadPipeRegs;
    // Store cycle latency number
    int unsigned                 NrStorePipeRegs;
    // Scoreboard length
    int unsigned                 NrScoreboardEntries;
    // Load buffer entry buffer
    int unsigned                 NrLoadBufEntries;
    // Maximum number of outstanding stores
    int unsigned                 MaxOutstandingStores;
    // Return address stack depth
    int unsigned                 RASDepth;
    // Branch target buffer entries
    int unsigned                 BTBEntries;
    // Branch predictor type
    bp_type_t                    BPType;
    // Branch history entries
    int unsigned                 BHTEntries;
    // Branch history bits
    int unsigned                 BHTHist;
    // MMU instruction TLB entries
    int unsigned                 InstrTlbEntries;
    // MMU data TLB entries
    int unsigned                 DataTlbEntries;
    // MMU option to use shared TLB
    bit unsigned                 UseSharedTlb;
    // MMU depth of shared TLB
    int unsigned                 SharedTlbDepth;
  } cva6_user_cfg_t;

  typedef struct packed {
    int unsigned XLEN;
    int unsigned VLEN;
    int unsigned PLEN;
    int unsigned GPLEN;
    bit IS_XLEN32;
    bit IS_XLEN64;
    int unsigned XLEN_ALIGN_BYTES;
    int unsigned ASID_WIDTH;
    int unsigned VMID_WIDTH;

    bit FpgaEn;
    bit FpgaAlteraEn;
    bit TechnoCut;

    bit          SuperscalarEn;
    int unsigned NrCommitPorts;
    int unsigned NrIssuePorts;
    bit          SpeculativeSb;

    int unsigned NrLoadPipeRegs;
    int unsigned NrStorePipeRegs;
    /// AXI parameters.
    int unsigned AxiAddrWidth;
    int unsigned AxiDataWidth;
    int unsigned AxiIdWidth;
    int unsigned AxiUserWidth;
    int unsigned MEM_TID_WIDTH;
    int unsigned NrLoadBufEntries;
    bit          RVF;
    bit          RVD;
    bit          XF16;
    bit          XF16ALT;
    bit          XF8;
    bit          XF8ALT;
    bit          RVA;
    bit          RVB;
    bit          ZKN;
    bit          RVV;
    bit          RVC;
    bit          RVH;
    bit          RVZCB;
    bit          RVZCMP;
    bit          RVZCMT;
    bit          RVSCLIC;
    bit          RVXHCLIC;
    bit          XFVec;
    bit          CvxifEn;
    copro_type_t CoproType;
    bit          RVZiCond;
    bit          RVZicntr;
    bit          RVZihpm;

    int unsigned NR_SB_ENTRIES;
    int unsigned TRANS_ID_BITS;

    bit          FpPresent;
    bit          NSX;
    int unsigned FLen;
    bit          RVFVec;
    bit          XF16Vec;
    bit          XF16ALTVec;
    bit          XF8Vec;
    bit          XF8ALTVec;
    int unsigned NrRgprPorts;
    int unsigned NrWbPorts;
    bit          EnableAccelerator;
    bit          PerfCounterEn;
    bit          MmuPresent;
    bit          RVS;                  //Supervisor mode
    bit          RVU;                  //User mode
    bit          SoftwareInterruptEn;

    logic [63:0] HaltAddress;
    logic [63:0] ExceptionAddress;
    int unsigned RASDepth;
    int unsigned BTBEntries;
    bp_type_t    BPType;
    int unsigned BHTEntries;
    int unsigned BHTHist;
    int unsigned InstrTlbEntries;
    int unsigned DataTlbEntries;
    bit unsigned UseSharedTlb;
    int unsigned SharedTlbDepth;
    int unsigned VpnLen;
    int unsigned PtLevels;

    logic [63:0]                 DmBaseAddress;
    bit                          TvalEn;
    bit                          DirectVecOnly;
    int unsigned                 NrPMPEntries;
    logic [63:0][63:0]           PMPCfgRstVal;
    logic [63:0][63:0]           PMPAddrRstVal;
    bit [63:0]                   PMPEntryReadOnly;
    bit                          PMPNapotEn;
    noc_type_e                   NOCType;
    int unsigned                 CLICNumInterruptSrc;
    int unsigned                 NrNonIdempotentRules;
    logic [NrMaxRules-1:0][63:0] NonIdempotentAddrBase;
    logic [NrMaxRules-1:0][63:0] NonIdempotentLength;
    int unsigned                 NrExecuteRegionRules;
    logic [NrMaxRules-1:0][63:0] ExecuteRegionAddrBase;
    logic [NrMaxRules-1:0][63:0] ExecuteRegionLength;
    int unsigned                 NrCachedRegionRules;
    logic [NrMaxRules-1:0][63:0] CachedRegionAddrBase;
    logic [NrMaxRules-1:0][63:0] CachedRegionLength;
    int unsigned                 MaxOutstandingStores;
    bit                          DebugEn;
    bit                          NonIdemPotenceEn;       // Currently only used by V extension (Ara)
    bit                          AxiBurstWriteEn;

    int unsigned ICACHE_SET_ASSOC;
    int unsigned ICACHE_SET_ASSOC_WIDTH;
    int unsigned ICACHE_INDEX_WIDTH;
    int unsigned ICACHE_TAG_WIDTH;
    int unsigned ICACHE_LINE_WIDTH;
    int unsigned ICACHE_USER_LINE_WIDTH;
    cache_type_t DCacheType;
    int unsigned DcacheIdWidth;
    int unsigned DCACHE_SET_ASSOC;
    int unsigned DCACHE_SET_ASSOC_WIDTH;
    int unsigned DCACHE_INDEX_WIDTH;
    int unsigned DCACHE_TAG_WIDTH;
    int unsigned DCACHE_LINE_WIDTH;
    int unsigned DCACHE_USER_LINE_WIDTH;
    int unsigned DCACHE_USER_WIDTH;
    int unsigned DCACHE_OFFSET_WIDTH;
    int unsigned DCACHE_NUM_WORDS;

    int unsigned DCACHE_MAX_TX;

    bit DcacheFlushOnFence;
    bit DcacheInvalidateOnFlush;

    int unsigned DATA_USER_EN;
    int unsigned WtDcacheWbufDepth;
    int unsigned FETCH_USER_WIDTH;
    int unsigned FETCH_USER_EN;
    bit          AXI_USER_EN;

    int unsigned FETCH_WIDTH;
    int unsigned FETCH_ALIGN_BITS;
    int unsigned INSTR_PER_FETCH;
    int unsigned LOG2_INSTR_PER_FETCH;

    int unsigned ModeW;
    int unsigned ASIDW;
    int unsigned VMIDW;
    int unsigned PPNW;
    int unsigned GPPNW;
    vm_mode_t MODE_SV;
    int unsigned SV;
    int unsigned SVX;

    int unsigned X_NUM_RS;
    int unsigned X_ID_WIDTH;
    int unsigned X_RFR_WIDTH;
    int unsigned X_RFW_WIDTH;
    int unsigned X_NUM_HARTS;
    int unsigned X_HARTID_WIDTH;
    int unsigned X_DUALREAD;
    int unsigned X_DUALWRITE;
    int unsigned X_ISSUE_REGISTER_SPLIT;

  } cva6_cfg_t;

  /// Empty configuration to sanity check proper parameter passing. Whenever
  /// you develop a module that resides within the core, assign this constant.
  localparam cva6_cfg_t cva6_cfg_empty = cva6_cfg_t'(0);

  /// Utility function being called to check parameters. Not all values make
  /// sense for all parameters, here is the place to sanity check them.
  function automatic void check_cfg(cva6_cfg_t Cfg);
    // pragma translate_off
    assert (Cfg.RASDepth > 0);
    assert (Cfg.BTBEntries == 0 || (2 ** $clog2(Cfg.BTBEntries) == Cfg.BTBEntries));
    assert (Cfg.BHTEntries == 0 || (2 ** $clog2(Cfg.BHTEntries) == Cfg.BHTEntries));
    assert (Cfg.NrNonIdempotentRules <= NrMaxRules);
    assert (Cfg.NrExecuteRegionRules <= NrMaxRules);
    assert (Cfg.NrCachedRegionRules <= NrMaxRules);
    assert (Cfg.NrPMPEntries <= 64);
    assert (!(Cfg.RVXHCLIC && (!Cfg.RVH || !Cfg.RVSCLIC)));
    assert (!(Cfg.SuperscalarEn && Cfg.RVF));
    assert (Cfg.FETCH_WIDTH == 32 || Cfg.FETCH_WIDTH == 64)
    else $fatal(1, "[frontend] fetch width != not supported");
    // Support for disabling MIP.MSIP and MIE.MSIE in Hypervisor and Supervisor mode is not supported
    // Software Interrupt can be disabled when there is only M machine mode in CVA6.
    assert (!(Cfg.RVS && !Cfg.SoftwareInterruptEn));
    assert (!(Cfg.RVH && !Cfg.SoftwareInterruptEn));
    assert (!(Cfg.RVZCMT && ~Cfg.MmuPresent));
    // pragma translate_on
  endfunction

  function automatic logic range_check(logic [63:0] base, logic [63:0] len, logic [63:0] address, chip_id_t chip_id);
    // if len is a power of two, and base is properly aligned, this check could be simplified
    // Extend base by one bit to prevent an overflow.
    return ({chip_id,address[LocalAddressWidth-1:0]} >= {chip_id, base[LocalAddressWidth-1:0]}) && ({chip_id,address[LocalAddressWidth-1:0]} < {chip_id, (base[LocalAddressWidth-1:0] + len[LocalAddressWidth-1:0])}) && ((~(&address[LocalAddressWidth +: (ChipIdWidth/2)]))|(~(&address[(LocalAddressWidth+ChipIdWidth/2) +: (ChipIdWidth/2)])));
  endfunction : range_check


  function automatic logic is_inside_nonidempotent_regions(cva6_cfg_t Cfg, logic [63:0] address, chip_id_t chip_id);

    logic [NrMaxRules-1:0] pass;
    pass = '0;
    for (int unsigned k = 0; k < Cfg.NrNonIdempotentRules; k++) begin
      pass[k] = range_check(Cfg.NonIdempotentAddrBase[k], Cfg.NonIdempotentLength[k], address, chip_id);
    end
    return |pass;
  endfunction : is_inside_nonidempotent_regions

  function automatic logic is_inside_execute_regions(cva6_cfg_t Cfg, logic [63:0] address, chip_id_t chip_id);
    // if we don't specify any region we assume everything is accessible
    logic [NrMaxRules-1:0] pass;
    if (Cfg.NrExecuteRegionRules != 0) begin
      pass = '0;
      for (int unsigned k = 0; k < Cfg.NrExecuteRegionRules; k++) begin
        pass[k] = range_check(Cfg.ExecuteRegionAddrBase[k], Cfg.ExecuteRegionLength[k], address, chip_id);
      end
      return |pass;
    end else begin
      return 1;
    end
  endfunction : is_inside_execute_regions

  function automatic logic is_inside_cacheable_regions(cva6_cfg_t Cfg, logic [63:0] address, chip_id_t chip_id);
    automatic logic [NrMaxRules-1:0] pass;
    pass = '0;
    for (int unsigned k = 0; k < Cfg.NrCachedRegionRules; k++) begin
      pass[k] = range_check(Cfg.CachedRegionAddrBase[k], Cfg.CachedRegionLength[k], address, chip_id);
    end
    return |pass;
  endfunction : is_inside_cacheable_regions

endpackage

// The package defines here is purely for the dependency in the pkgs in the cva6 repo
// The full configuration for hemaia is overridden in the occamy_cva6.sv
package cva6_config_pkg;
  localparam CVA6ConfigXlen = 64;

  localparam CVA6ConfigNrCommitPorts = 2;
  // We do not need the FPU in CVA6, the FPU is offloaded to the Ara
  localparam CVA6ConfigRVF = 0;
  localparam CVA6ConfigRVD = 0;
  localparam CVA6ConfigF16En = 0;
  localparam CVA6ConfigF16AltEn = 0;
  localparam CVA6ConfigF8En = 0;
  localparam CVA6ConfigF8AltEn = 0;
  localparam CVA6ConfigFVecEn = 0;

  localparam CVA6ConfigCvxifEn = 0;
  localparam CVA6ConfigCExtEn = 1;    // Compress Ext
  localparam CVA6ConfigZcbExtEn = 0;
  localparam CVA6ConfigZcmpExtEn = 0;
  localparam CVA6ConfigAExtEn = 1;    // Atomic Ext
  localparam CVA6ConfigBExtEn = 0;
  localparam CVA6ConfigHExtEn = 0;
  localparam CVA6ConfigVExtEn = 1;    // Vector Ext
  localparam CVA6ConfigRVZiCond = 0;
  localparam CVA6ConfigSclicExtEn = 0;
  localparam CVA6ConfigXhclicExtEn = 0;

  localparam CVA6ConfigAxiIdWidth   = 3;
  localparam CVA6ConfigAxiAddrWidth = 48;
  localparam CVA6ConfigAxiDataWidth = 64;
  localparam CVA6ConfigFetchUserEn  = 0;
  localparam CVA6ConfigFetchUserWidth = CVA6ConfigXlen;
  localparam CVA6ConfigDataUserEn = 0;
  localparam CVA6ConfigDataUserWidth = CVA6ConfigXlen;

  localparam CVA6ConfigIcacheByteSize = 4096;
  localparam CVA6ConfigIcacheSetAssoc = 4;
  localparam CVA6ConfigIcacheLineWidth = 128;
  localparam CVA6ConfigDcacheByteSize = 8192;
  localparam CVA6ConfigDcacheSetAssoc = 4;
  localparam CVA6ConfigDcacheLineWidth = 256;

  localparam CVA6ConfigDcacheFlushOnFence = 1'b0;
  localparam CVA6ConfigDcacheInvalidateOnFlush = 1'b0;

  localparam CVA6ConfigDcacheIdWidth = 1;
  localparam CVA6ConfigMemTidWidth = 2;

  localparam CVA6ConfigWtDcacheWbufDepth = 8;

  localparam CVA6ConfigNrScoreboardEntries = 8;

  localparam CVA6ConfigNrLoadPipeRegs = 1;
  localparam CVA6ConfigNrStorePipeRegs = 0;
  localparam CVA6ConfigNrLoadBufEntries = 2;

  localparam CVA6ConfigRASDepth = 2;
  localparam CVA6ConfigBTBEntries = 32;
  localparam CVA6ConfigBHTEntries = 128;

  localparam CVA6ConfigTvalEn = 1;

  localparam CVA6ConfigNrPMPEntries = 8;

  localparam CVA6ConfigPerfCounterEn = 0;

  localparam config_pkg::cache_type_t CVA6ConfigDcacheType = config_pkg::HPDCACHE_WT;

  localparam CVA6ConfigMmuPresent = 0;

  localparam CVA6ConfigRvfiTrace = 1;

  // Memory regions
  localparam logic [63:0] WideSPMBase           =   64'h8000_0000;
  localparam logic [63:0] WideSPMLength         =   64'h100_0000;
  localparam logic [63:0] NarrowSPMBase         =   64'h7000_0000;
  localparam logic [63:0] NarrowSPMLength       =   64'h8000;
  localparam logic [63:0] BootromBase           =   64'h100_0000;
  localparam logic [63:0] BootromLength         =   64'h2_0000;
  localparam logic [63:0] DebugBase             =   64'd0;
  localparam logic [63:0] DebugLength           =   64'd4096;
  // MMIO regions
  localparam logic [63:0] SoCPeriphBase         =   64'd0;
  localparam logic [63:0] SoCPeriphLength       =   64'h1000_0000;
  localparam logic [63:0] ClusterBase           =   64'h1000_0000;
  localparam logic [63:0] ClusterLength         =   64'h100_0000;
  localparam config_pkg::cva6_user_cfg_t cva6_cfg = '{
      XLEN: unsigned'(CVA6ConfigXlen),
      VLEN: unsigned'(64),
      FpgaEn: bit'(0),  // for Xilinx and Altera
      FpgaAlteraEn: bit'(0),  // for Altera (only)
      TechnoCut: bit'(0),
      SuperscalarEn: bit'(0),
      NrCommitPorts: unsigned'(CVA6ConfigNrCommitPorts),
      AxiAddrWidth: unsigned'(CVA6ConfigAxiAddrWidth),
      AxiDataWidth: unsigned'(CVA6ConfigAxiDataWidth),
      AxiIdWidth: unsigned'(CVA6ConfigAxiIdWidth),
      AxiUserWidth: unsigned'(CVA6ConfigDataUserWidth),
      MemTidWidth: unsigned'(CVA6ConfigMemTidWidth),
      NrLoadBufEntries: unsigned'(CVA6ConfigNrLoadBufEntries),
      RVF: bit'(CVA6ConfigRVF),
      RVD: bit'(CVA6ConfigRVD),
      XF16: bit'(CVA6ConfigF16En),
      XF16ALT: bit'(CVA6ConfigF16AltEn),
      XF8: bit'(CVA6ConfigF8En),
      XF8ALT: bit'(CVA6ConfigF8AltEn),
      RVA: bit'(CVA6ConfigAExtEn),
      RVB: bit'(CVA6ConfigBExtEn),
      ZKN: bit'(0),
      RVV: bit'(CVA6ConfigVExtEn),
      RVC: bit'(CVA6ConfigCExtEn),
      RVH: bit'(CVA6ConfigHExtEn),
      RVZCB: bit'(CVA6ConfigZcbExtEn),
      RVZCMP: bit'(CVA6ConfigZcmpExtEn),
      RVZCMT: bit'(0),
      XFVec: bit'(CVA6ConfigFVecEn),
      CvxifEn: bit'(CVA6ConfigCvxifEn),
      CoproType: config_pkg::COPRO_NONE,
      RVZiCond: bit'(CVA6ConfigRVZiCond),
      RVSCLIC: bit'(CVA6ConfigSclicExtEn),
      RVXHCLIC: bit'(CVA6ConfigXhclicExtEn),
      RVZicntr: bit'(1),
      RVZihpm: bit'(1),
      NrScoreboardEntries: unsigned'(CVA6ConfigNrScoreboardEntries),
      PerfCounterEn: bit'(CVA6ConfigPerfCounterEn),
      MmuPresent: bit'(CVA6ConfigMmuPresent),
      RVS: bit'(1),
      RVU: bit'(1),
      SoftwareInterruptEn: bit'(1),
      HaltAddress: 64'h800,
      ExceptionAddress: 64'h808,
      RASDepth: unsigned'(CVA6ConfigRASDepth),
      BTBEntries: unsigned'(CVA6ConfigBTBEntries),
      BPType: config_pkg::BHT,
      BHTEntries: unsigned'(CVA6ConfigBHTEntries),
      BHTHist: unsigned'(3),
      DmBaseAddress: 64'h0,
      TvalEn: bit'(CVA6ConfigTvalEn),
      DirectVecOnly: bit'(0),
      NrPMPEntries: unsigned'(CVA6ConfigNrPMPEntries),
      PMPCfgRstVal: {64{64'h0}},
      PMPAddrRstVal: {64{64'h0}},
      PMPEntryReadOnly: 64'd0,
      PMPNapotEn: bit'(1),
      NOCType: config_pkg::NOC_TYPE_AXI4_ATOP,
      CLICNumInterruptSrc: unsigned'(256),
      // Memory Regions
      //    NonIdemp Region
      NrNonIdempotentRules: unsigned'(2),
      //                            SoC Periph;        Cluster
      NonIdempotentAddrBase: 1024'({SoCPeriphBase,    ClusterBase  }),
      NonIdempotentLength:   1024'({SoCPeriphLength,  ClusterLength}),
      //    Exe Region
      NrExecuteRegionRules: unsigned'(4),
      //                             WideSPM;       NarrowSPM;    Boot ROM;        Debug Module
      ExecuteRegionAddrBase: 1024'({WideSPMBase,   NarrowSPMBase, BootromBase,    DebugBase  }),
      ExecuteRegionLength:   1024'({WideSPMLength, NarrowSPMBase, BootromLength,  DebugLength}),
      //    Cache Region
      NrCachedRegionRules: unsigned'(2),
      //                             WideSPM;       NarrowSPM
      CachedRegionAddrBase:  1024'({WideSPMBase,   NarrowSPMBase  }),
      CachedRegionLength:    1024'({WideSPMLength, NarrowSPMLength}),
      MaxOutstandingStores: unsigned'(7),
      DebugEn: bit'(1),
      AxiBurstWriteEn: bit'(0),
      IcacheByteSize: unsigned'(CVA6ConfigIcacheByteSize),
      IcacheSetAssoc: unsigned'(CVA6ConfigIcacheSetAssoc),
      IcacheLineWidth: unsigned'(CVA6ConfigIcacheLineWidth),
      DcacheByteSize: unsigned'(CVA6ConfigDcacheByteSize),
      DcacheSetAssoc: unsigned'(CVA6ConfigDcacheSetAssoc),
      DcacheLineWidth: unsigned'(CVA6ConfigDcacheLineWidth),
      DcacheFlushOnFence: unsigned'(CVA6ConfigDcacheFlushOnFence),
      DcacheInvalidateOnFlush: unsigned'(CVA6ConfigDcacheInvalidateOnFlush),
      DataUserEn: unsigned'(CVA6ConfigDataUserEn),
      WtDcacheWbufDepth: int'(CVA6ConfigWtDcacheWbufDepth),
      FetchUserWidth: unsigned'(CVA6ConfigFetchUserWidth),
      FetchUserEn: unsigned'(CVA6ConfigFetchUserEn),
      DCacheType: CVA6ConfigDcacheType,
      InstrTlbEntries: int'(16),
      DataTlbEntries: int'(16),
      UseSharedTlb: bit'(0),
      SharedTlbDepth: int'(64),
      NrLoadPipeRegs: int'(CVA6ConfigNrLoadPipeRegs),
      NrStorePipeRegs: int'(CVA6ConfigNrStorePipeRegs),
      DcacheIdWidth: int'(CVA6ConfigDcacheIdWidth)
  };


endpackage