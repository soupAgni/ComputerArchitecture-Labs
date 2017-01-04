-------------------------------------------------------------------------
-- Souparni Agnihotri
-- Fall 2016
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_pipelined_processor is
  generic(N : integer := 32;
          dmem_mif_filename : string := "mem.mif";
          imem_mif_filename : string := "i_mem.mif");
  port(CLK           : in  std_logic;
       regfile_reset : in  std_logic;
       PC_reset      : in  std_logic;
       IFID_reset    : in  std_logic;    -- same as PC_reset
       IFID_flush    : in  std_logic;    -- do we need this?
       IFID_w_en     : in  std_logic;    -- same as reg_WE
       IDEX_reset    : in  std_logic;
       IDEX_flush    : in  std_logic;
       IDEX_WE       : in  std_logic;
       EXMEM_reset   : in  std_logic;
       EXMEM_flush   : in  std_logic;
       EXMEM_WE      : in  std_logic;
       MEMWB_reset   : in  std_logic;
       MEMWB_flush   : in std_logic;
       MEMWB_WE      : in  std_logic;
       forwardA_branch : in std_logic_vector(2 downto 0);  -- can remove this after adding forwarding logic
       forwardB_branch : in std_logic_vector(2 downto 0);  -- can remove this after adding forwarding logic 
       forwardA_ALU    : in std_logic_vector(2 downto 0);  -- can remove this after adding forwarding logic
       forwardB_ALU    : in std_logic_vector(2 downto 0);  -- can remove this after adding forwarding logic
       o_IF_instMem  : out std_logic_vector(31 downto 0); -- for debugging purposes
       o_ID_RegData1 : out std_logic_vector(31 downto 0);
       o_ID_RegData2 : out std_logic_vector(31 downto 0);
       o_EX_ALUVal   : out std_logic_vector(31 downto 0));
       
end MIPS_pipelined_processor;
 
architecture structure of MIPS_pipelined_processor is
   
   
component IF_stage 
  generic(N : integer := 32;
  mif_filename 	: string := "i_mem.mif");
  port(CLK              : in std_logic;
       PC_reset         : in std_logic;
       IFID_reset       : in std_logic;
       MEMWB_isJumpReg  : in std_logic;
       mux_ORval        : in std_logic;
       reg_WE           : in std_logic;
       IDEX_branchJump  : in std_logic_vector(31 downto 0);
       IDEX_rs          : in std_logic_vector(31 downto 0);
       o_instMem        : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0));
		 
end component;  


component ID_stage is
  generic(N : integer := 32);
 port(CLK               : in std_logic;
       IDEX_reset       : in std_logic;
       Regfile_reset    : in std_logic;
       IDEX_WE          : in std_logic;
       IDEX_Flush       : in std_logic;
       IFID_AdderVal    : in std_logic_vector(31 downto 0) ;
       IFID_instMem     : in std_logic_vector(31 downto 0);
       MEMWB_instMem    : in std_logic_vector(31 downto 0); 
       MEMWB_upperImmVal: in std_logic_vector(31 downto 0);
       ValtoReg_File    : in std_logic_vector(31 downto 0);
       MemWB_PCPlus4    : in std_logic_vector(31 downto 0);
       MEMWB_ALUWrite   : in std_logic;
       MEMWB_isLinkALU  : in std_logic;
       MEMWB_RegDest    : in std_logic;
       MEMWB_IsLink     : in std_logic;
       MemWB_upperImm   : in std_logic;
       MemWB_RegW_en    : in std_logic;
       forwardA_Branch  : in std_logic_vector(2 downto 0);
       forwardB_Branch  : in std_logic_vector(2 downto 0);
       ExMem_ALU        : in std_logic_vector(31 downto 0);
       IDEX_ALUval      : in std_logic_vector(31 downto 0); 
       EXMEM_PCplus4    : in std_logic_vector(31 downto 0);
       EXMEM_UpperImm   : in std_logic_vector(31 downto 0); 
       IDEX_UpperImm    : in std_logic_vector(31 downto 0);
       o_IFID_instMem   : out std_logic_vector(31 downto 0);
       o_branchAnd      : out std_logic;
		   o_operation      : out std_logic_vector(2 downto 0);
       o_ALUsel         : out std_logic_vector(1 downto 0);
       o_issv           : out std_logic;
       o_isJumpReg      : out std_logic;
       o_isLinkALU      : out std_logic;
       o_ALU_write      : out std_logic;
       o_isUnsignedALU  : out std_logic;
       o_IsImmALU       : out std_logic;
		 --  o_IsRtype        : out std_logic;
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		  -- o_instMem        : out std_logic;   --- might need to be std_logic_vector(31 downto 0)
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_branch_jump_mux: out std_logic_vector(31 downto 0);
		   o_muxORval       : out std_logic;   ---  feeding into mux in IF stage
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)
      );
		 
		 
end component;



component EX_stage 
  generic(N : integer := 32);
	port(
		Clk             : in std_logic;
		EXMEM_Reg_Reset : in std_logic; 
		WE              : in std_logic;
		RegDst          : in std_logic; -- might need to change to vectors
		reg_w_en        : in std_logic;
		dmem_w_en       : in std_logic;
		upperImm        : in std_logic;
		isLink          : in std_logic;
		isLoad          : in std_logic;
		isLoadU         : in std_logic;
		isImmALU        : in std_logic;
		operation       : in std_logic_vector(2 downto 0);
    ALUsel          : in std_logic_vector(1 downto 0);
    issv            : in std_logic;
    isJumpReg       : in std_logic;
    isLinkALU       : in std_logic;
    ALU_write       : in std_logic;
    isUnsignedALU   : in std_logic;
		TypeSel         : in std_logic_vector(1 downto 0);
		forwardA_ALU    : in std_logic_vector(2 downto 0);
		forwardB_ALU    : in std_logic_vector(2 downto 0);
		IDEX_ALUop      : in std_logic_vector(5 downto 0);
		IDEX_upperImmVal : in std_logic_vector(31 downto 0);
		EXMEM_ALU       : in std_logic_vector(31 downto 0);
		MEMWB_memOut    : in std_logic_vector(31 downto 0);
		MEMWB_PCp4      : in std_logic_vector(31 downto 0);
		EXMEM_UpperImm  : in std_logic_vector(31 downto 0);
		MEMWB_UpperImm  : in std_logic_vector(31 downto 0);
		IDEX_Rs         : in std_logic_vector(31 downto 0);
		IDEX_Rt         : in std_logic_vector(31 downto 0);
		IDEX_mux12      : in std_logic_vector(31 downto 0);
		IDEX_imem       : in std_logic_vector(31 downto 0);
		IDEX_PCp4       : in std_logic_vector(31 downto 0);
		o_IDEX_upperImmVal : out std_logic_vector(31 downto 0);
		o_RegDst        : out std_logic;
		o_isLoad        : out std_logic;
		o_isLoadU       : out std_logic;
		o_Reg_w_en      : out std_logic;
		o_dmem_w_en     : out std_logic;
		o_ALUwrite      : out std_logic;
		o_isJumpReg     : out std_logic;
		o_isLink        : out std_logic;
		o_isLinkALU     : out std_logic;
		o_UpperImm      : out std_logic;
		o_TypeSel       : out std_logic_vector(1 downto 0);
		o_ALUVal        : out std_logic_vector(31 downto 0);
		o_RegData2      : out std_logic_vector(31 downto 0);
		o_PCplus4       : out std_logic_vector(31 downto 0);
		o_instMem       : out std_logic_vector(31 downto 0);
		o_upperImmVal   : out std_logic_vector(31 downto 0));
end component;

component MEM_stage 
  generic(N : integer := 32;
          dmem_mif_filename : string := "mem.mif");
	port(
		Clk             : in std_logic;
		MEMWB_Reg_Reset : in std_logic; 
		WE              : in std_logic;
		RegDst          : in std_logic; 
		reg_w_en        : in std_logic;
		dmem_w_en       : in std_logic;
		upperImm        : in std_logic;
		isLink          : in std_logic;
		isLoad          : in std_logic;
		isLoadU         : in std_logic;
		isLinkALU       : in std_logic;
		ALUwrite        : in std_logic;
		isJumpReg       : in std_logic;
		TypeSel         : in std_logic_vector(1 downto 0);
		EXMEM_ALU       : in std_logic_vector(31 downto 0);
		EXMEM_Rt        : in std_logic_vector(31 downto 0);
		MEMWB_PCp4      : in std_logic_vector(31 downto 0);
		IDEX_imem       : in std_logic_vector(31 downto 0);
		upperImmVal     : in std_logic_vector(31 downto 0);
		o_RegDst        : out std_logic;
		o_Reg_w_en      : out std_logic;
		o_ALUwrite      : out std_logic;
		o_isJumpReg     : out std_logic;
		o_isLink        : out std_logic;
		o_isLinkALU     : out std_logic;
		o_UpperImm      : out std_logic;
		o_ValToReg      : out std_logic_vector(31 downto 0);
		o_MEMWB_PCplus4 : out std_logic_vector(31 downto 0);
		o_instMem       : out std_logic_vector(31 downto 0);
		o_upperImmVal   : out std_logic_vector(31 downto 0));
end component;

    signal  s_MEMWB_isJumpReg, s_mux_ORval, s_MEMWB_RegDest,s_MemWB_upperImm, s_o_branchAnd, s_MemWB_RegW_en   : std_logic;
    
     --- signals forwarded from Control unit
     signal s_MEMWB_IsLink, s_o_IsImmALU    : std_logic;
     
     signal  s_IDEX_branchJump, s_IDEX_rs  , s_IFID_imem, s_PCplus4, s_MEMWB_instMem, s_MEMWB_upperImmVal, s_ValtoReg_File, s_MemWB_PCPlus4, s_ExMem_ALU, s_EXMEM_PCplus4, s_EXMEM_UpperImm, s_IDEX_UpperImm, s_MEMWB_memOut,s_MEMWB_PCp4    : std_logic_vector(31 downto 0);
     
     signal  s_o_IFID_instMem  : std_logic_vector(31 downto 0);
     
     signal   s_o_operation   : std_logic_vector(2 downto 0);
     
     signal   s_o_ALUsel  , s_o_TypeSel    : std_logic_vector(1 downto 0);
     
     signal   s_o_ALU_OP         :std_logic_vector(5 downto 0);
     
     -- outputs from IDEX stage
     signal  s_o_RegDst, s_o_isLoadU , s_o_Reg_w_en, s_o_UpperImm, s_o_isLink, s_o_dmem_w_en, s_o_isLoad, s_o_branch_jump_mux, s_o_muxORval  : std_logic;
     signal s_o_RegData1, s_o_RegData2, s_o_ImmSignExt, s_o_PCplus4, s_o_upperImmVal, s_o_branchALU     : std_logic_vector(31 downto 0); 
     
     -- signals passing through from alu control
    signal s_MEMWB_ALUWrite, s_MEMWB_isLinkALU, s_o_issv, s_o_isJumpReg, s_o_isLinkALU, s_o_ALU_write, s_o_isUnsignedALU : std_logic;
    --- output signals from EX stage
    signal  s_EX_o_RegDst,s_EX_o_isLoad, s_EX_o_isLoadU, s_EX_o_Reg_w_en , s_EX_o_dmem_w_en, s_EX_o_ALUwrite, s_EX_o_isJumpReg, s_EX_o_isLink, s_EX_o_isLinkALU, s_EX_o_UpperImm : std_logic;
    signal s_EX_o_TypeSel  : std_logic_vector(1 downto 0);
    signal  s_EX_o_ALUVal, s_EX_o_RegData2, s_EX_o_PCplus4, s_EX_o_instMem , s_EX_o_upperImmVal , s_o_EXupperImmVal :  std_logic_vector(31 downto 0);
    
  begin
      
   IF_stage1 : IF_stage 
   
   generic map(N => 32, 
   mif_filename => "i_mem.mif")
    port map
      (CLK             => CLK,
       PC_reset        => PC_reset,
       IFID_reset      => IFID_reset,
       MEMWB_isJumpReg => s_MEMWB_isJumpReg,
       mux_ORval       => s_o_muxORval,
       reg_WE          => IFID_w_en, 
       IDEX_branchJump => s_IDEX_branchJump,
       IDEX_rs         => s_IDEX_rs,
       o_instMem       => s_IFID_imem,  -- pass in as IFIDimem input into ID stge
		   o_PCplus4       => s_PCplus4);
		 
  s_IDEX_rs  <= s_o_RegData1;

  ID_stage_1 : ID_stage 
  
  generic map(N => 32)
  port map
      (CLK               => CLK, 
       IDEX_reset        => IDEX_reset, 
       Regfile_reset     => regfile_reset,
       IDEX_WE           => IDEX_WE,
       IDEX_Flush        => IDEX_Flush,
       IFID_AdderVal     => s_PCplus4,
       IFID_instMem      => s_IFID_imem, 
       MEMWB_instMem     => s_MEMWB_instMem,
       MEMWB_upperImmVal => s_MEMWB_upperImmVal, 
       ValtoReg_File     => s_ValtoReg_File, 
       MemWB_PCPlus4     => s_MemWB_PCPlus4, 
       MEMWB_ALUWrite    => s_MEMWB_ALUWrite,
       MEMWB_isLinkALU   => s_MEMWB_isLinkALU,
       MEMWB_RegDest     => s_MEMWB_RegDest,
       MEMWB_IsLink      => s_MEMWB_IsLink,
       MemWB_upperImm    => s_MemWB_upperImm, 
       MemWB_RegW_en     => s_MemWB_RegW_en, 
       forwardA_Branch   => forwardA_branch, 
       forwardB_Branch   => forwardB_branch,
       ExMem_ALU         => s_EX_o_ALUVal,
       IDEX_ALUval       => s_EX_o_ALUVal,
       EXMEM_PCplus4     => s_EX_o_PCplus4,
       EXMEM_UpperImm    => s_EX_o_upperImmVal,
       IDEX_UpperImm     => s_EX_o_upperImmVal,
       o_IFID_instMem    => s_o_IFID_instMem, 
       o_branchAnd       => s_o_branchAnd,
		   o_operation       => s_o_operation,
       o_ALUsel          => s_o_ALUsel,
       o_issv            => s_o_issv,
       o_isJumpReg       => s_o_isJumpReg,
       o_isLinkALU       => s_o_isLinkALU,
       o_ALU_write       => s_o_ALU_write, 
       o_isUnsignedALU   => s_o_isUnsignedALU, 
       o_IsImmALU        => s_o_IsImmALU,
		  -- o_IsRtype         => s_o_IsRtype, --dont need this anymore
		   o_RegDst          => s_o_RegDst,
		   o_isLoadU         => s_o_isLoadU, 
		  -- o_instMem         => s_o_instMem, -- might 
		   o_Reg_w_en        => s_o_Reg_w_en, 
		   o_UpperImm        => s_o_UpperImm, 
		   o_isLink          => s_o_isLink,
		   o_dmem_w_en       => s_o_dmem_w_en,
		   o_isLoad          => s_o_isLoad, 
		   o_branch_jump_mux => s_IDEX_branchJump,
		   o_muxORval        => s_o_muxORval,    ---  feeding into mux in IF stage
		   o_TypeSel         => s_o_TypeSel, 
		   o_ALU_OP	         => s_o_ALU_OP, 
		   o_RegData1        => s_o_RegData1, 
		   o_RegData2        => s_o_RegData2,
		   o_ImmSignExt      => s_o_ImmSignExt,
		   o_PCplus4         => s_o_PCplus4, 
		   o_upperImmVal     => s_EX_o_upperImmVal, 
		   o_branchALU       => s_o_branchALU
		   
      );
		 
	EX_stage1 : EX_stage 
  generic map(N => 32)
	port map(
		Clk             => CLK,
		EXMEM_Reg_Reset => EXMEM_reset, 
		WE              => EXMEM_WE, 
		RegDst          => s_o_RegDst,
		reg_w_en        => s_o_Reg_w_en, 
		dmem_w_en       => s_o_dmem_w_en, 
		upperImm        => s_o_UpperImm,
		isLink          => s_o_isLink,
		isLoad          => s_o_isLoad, 
		isLoadU         => s_o_isLoadU, 
		isImmALU        => s_o_IsImmALU,
		operation       => s_o_operation, 
    ALUsel          => s_o_ALUsel, 
    issv            => s_o_issv, 
    isJumpReg       => s_o_isJumpReg,
    isLinkALU       => s_o_isLinkALU,
    ALU_write       => s_o_ALU_write,
    isUnsignedALU   => s_o_isUnsignedALU,
		TypeSel         => s_o_TypeSel,
		forwardA_ALU    => forwardA_ALU, 
		forwardB_ALU    => forwardB_ALU,
		IDEX_ALUop      => s_o_ALU_OP, 
		IDEX_upperImmVal => s_EX_o_upperImmVal,
		EXMEM_ALU       => s_EX_o_ALUVal, 
		MEMWB_memOut    => s_ValtoReg_File, 
		MEMWB_PCp4      => s_MemWB_PCPlus4, 
		EXMEM_UpperImm  => s_o_EXupperImmVal, 
		MEMWB_UpperImm  => s_MEMWB_upperImmVal, 
		IDEX_Rs         => s_o_RegData1, 
		IDEX_Rt         => s_o_RegData2, 
		IDEX_mux12      => s_o_ImmSignExt, 
		IDEX_imem       => s_o_IFID_instMem, 
		IDEX_PCp4       => s_o_PCplus4, 
		o_IDEX_upperImmVal => s_EX_o_upperImmVal,
		o_RegDst        => s_EX_o_RegDst, 
		o_isLoad        => s_EX_o_isLoad, 
		o_isLoadU       => s_EX_o_isLoadU, 
		o_Reg_w_en      => s_EX_o_Reg_w_en, 
		o_dmem_w_en     => s_EX_o_dmem_w_en, 
		o_ALUwrite      => s_EX_o_ALUwrite,
		o_isJumpReg     => s_EX_o_isJumpReg, 
		o_isLink        => s_EX_o_isLink,
		o_isLinkALU     => s_EX_o_isLinkALU, 
		o_UpperImm      => s_EX_o_UpperImm, 
		o_TypeSel       => s_EX_o_TypeSel, 
		o_ALUVal        => s_EX_o_ALUVal, 
		o_RegData2      => s_EX_o_RegData2, 
		o_PCplus4       => s_EX_o_PCplus4, 
		o_instMem       => s_EX_o_instMem, 
		o_upperImmVal   => s_EX_o_upperImmVal);

	 MEM_stage1: MEM_stage
  generic map(N =>  32,
          dmem_mif_filename => "mem.mif")
          
	port map
	(
		Clk             => CLK,
		MEMWB_Reg_Reset => MEMWB_reset, 
		WE              => MEMWB_WE, 
		RegDst          => s_EX_o_RegDst,
		reg_w_en        => s_EX_o_Reg_w_en, 
		dmem_w_en       => s_EX_o_dmem_w_en, 
		upperImm        => s_EX_o_UpperImm,
		isLink          => s_EX_o_isLink,
		isLoad          => s_EX_o_isLoad,
		isLoadU         => s_EX_o_isLoadU,
		isLinkALU       => s_EX_o_isLinkALU,
		ALUwrite        => s_EX_o_ALUwrite,
		isJumpReg       => s_EX_o_isJumpReg,
		TypeSel         => s_EX_o_TypeSel, 
		EXMEM_ALU       => s_EX_o_ALUVal, 
		EXMEM_Rt        => s_EX_o_RegData2,
		MEMWB_PCp4      => s_EX_o_PCplus4,
		IDEX_imem       => s_EX_o_instMem,
		upperImmVal     => s_EX_o_UpperImmVal,
		o_RegDst        => s_MEMWB_RegDest, 
		o_Reg_w_en      => s_MemWB_RegW_en, 
		o_ALUwrite      => s_MEMWB_ALUWrite,
		o_isJumpReg     => s_MEMWB_isJumpReg,
		o_isLink        => s_MEMWB_IsLink,
		o_isLinkALU     => s_MEMWB_isLinkALU,
		o_UpperImm      => s_MEMWB_upperImm, 
		o_ValToReg      => s_ValtoReg_File, 
		o_MEMWB_PCplus4 => s_MemWB_PCPlus4,
		o_instMem       => s_MEMWB_instMem,
		o_upperImmVal   => s_MEMWB_upperImmVal);
 
		 
        
end structure;
