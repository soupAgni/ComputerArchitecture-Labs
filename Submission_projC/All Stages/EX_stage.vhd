
library IEEE;
use IEEE.std_logic_1164.all;

entity EX_stage is
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
end EX_stage;


architecture structure of EX_stage is


component exToMemReg is
	port(Clk           : in std_logic;
	     Reset         : in std_logic;
		   WE            : in std_logic;
	    	RegDst        : in std_logic;
		   isLoad        : in std_logic;
		   isLoadU       : in std_logic;
		   reg_w_en      : in std_logic;
		   dmem_w_en     : in std_logic;
		   isLinkALU     : in std_logic;
		   ALU_write     : in std_logic;
		   isJumpReg     : in std_logic;
		   isLink        : in std_logic;
		   upperImm      : in std_logic;
		   TypeSel       : in std_logic_vector(1 downto 0);
		   ALUVal        : in std_logic_vector(31 downto 0);
		   RegData2      : in std_logic_vector(31 downto 0);
		   PCplus4       : in std_logic_vector(31 downto 0);
		   instMem       : in std_logic_vector(31 downto 0);
		   upperImmVal   : in std_logic_vector(31 downto 0);
		   o_RegDst      : out std_logic;
		   o_isLoad      : out std_logic;
	    	o_isLoadU     : out std_logic;
		   o_Reg_w_en    : out std_logic;
		   o_dmem_w_en   : out std_logic;
		   o_ALUwrite    : out std_logic;
		   o_isJumpReg   : out std_logic;
		   o_isLink      : out std_logic;
		   o_isLinkALU   : out std_logic;
		   o_UpperImm    : out std_logic;
		   o_TypeSel     : out std_logic_vector(1 downto 0);
		   o_ALUVal      : out std_logic_vector(31 downto 0);
		   o_RegData2    : out std_logic_vector(31 downto 0);
		   o_PCplus4     : out std_logic_vector(31 downto 0);
		   o_instMem     : out std_logic_vector(31 downto 0);
		   o_upperImmVal : out std_logic_vector(31 downto 0));
end component;

component ALU is
  port(operation     : in  std_logic_vector(2 downto 0);
       ALUsel        : in  std_logic_vector(1 downto 0);
       shamt         : in  std_logic_vector(4 downto 0);
       i_A           : in  std_logic_vector(31 downto 0);
       i_B           : in  std_logic_vector(31 downto 0);
       issv          : in  std_logic;
       isUnsignedALU : in  std_logic;
       zero          : out std_logic;
       carry_out     : out std_logic;
       overflow      : out std_logic;
       ALU_out       : out std_logic_vector(31 downto 0));
end component;


signal s_issv, s_isUnsignedALU, s_zero, s_isJumpReg, s_isLinkALU, s_ALU_write : std_logic;
signal s_muxA_toALU, s_muxB_toALU, s_mux10, s_ALU_out : std_logic_vector(31 downto 0);
signal s_operation : std_logic_vector(2 downto 0);
signal s_TypeSel, s_ALUsel : std_logic_vector(1 downto 0);

begin

  -- 5 to 1 mux for ALU A input 
  s_muxA_toALU <= IDEX_Rs WHEN forwardA_ALU = "000" else
                  EXMEM_ALU WHEN forwardA_ALU = "001" else
                  MEMWB_memOut WHEN forwardA_ALU = "010" else
                  MEMWB_PCp4 WHEN forwardA_ALU = "011" else
                  EXMEM_UpperImm WHEN forwardA_ALU = "100" else
                  MEMWB_UpperImm;
  
  -- 5 to 1 mux for ALU B input 
  s_muxB_toALU <= IDEX_Rt WHEN forwardB_ALU = "000" else
                  EXMEM_ALU WHEN forwardB_ALU = "001" else
                  MEMWB_memOut WHEN forwardB_ALU = "010" else
                  MEMWB_PCp4 WHEN forwardB_ALU = "011" else
                  EXMEM_UpperImm WHEN forwardB_ALU = "100" else
                  MEMWB_UpperImm;
                  
  -- 2 to 1 mux for Bmux and mux12 to ALU B input
  s_mux10 <= s_muxB_toALU WHEN isImmALU = '0' else
             IDEX_mux12;
  
  -- Full ALU           
  EX_ALU : ALU 
  port map(operation     => operation,
           ALUsel        => ALUsel,
           shamt         => IDEX_imem(10 downto 6),
           i_A           => s_muxA_toALU,
           i_B           => s_mux10,
           issv          => issv,
           isUnsignedALU => isUnsignedALU,
           zero          => s_zero,
           ALU_out       => s_ALU_out);
           
          -- o_ALUVal  <= s_ALU_out; 
           
           s_ALU_write <= ALU_write;
           
           s_isLinkALU  <= isLinkALU;
           
           s_isJumpReg  <= isJumpReg;
           
           o_IDEX_upperImmVal  <= IDEX_upperImmVal;
  
  EXMEM_Reg : exToMemReg 
	port map(Clk           => Clk,
	        	Reset         => EXMEM_Reg_Reset,
		       WE            => WE,
	        	RegDst        => RegDst,
		       isLoad        => isLoad,
		       isLoadU       => isLoadU,
		       reg_w_en      => reg_w_en,
		       dmem_w_en     => dmem_w_en,
		       isLinkALU     => s_isLinkALU,
		       ALU_write     => s_ALU_write,
		       isJumpReg     => s_isJumpReg,
		       isLink        => isLink,
		       upperImm      => upperImm,
		       TypeSel       => TypeSel,
		       ALUVal        => s_ALU_out,
		       RegData2      => s_muxB_toALU,
		       PCplus4       => IDEX_PCp4,
		       instMem       => IDEX_imem,
		       upperImmVal   => IDEX_mux12,
		       o_RegDst      => o_RegDst,
		       o_isLoad      => o_isLoad,
		       o_isLoadU     => o_isLoadU,
		       o_Reg_w_en    => o_Reg_w_en,
		       o_dmem_w_en   => o_dmem_w_en,
		       o_ALUwrite    => o_ALUwrite,
		       o_isJumpReg   => o_isJumpReg,
		       o_isLink      => o_isLink,
		       o_isLinkALU   => o_isLinkALU,
		       o_UpperImm    => o_UpperImm,
		       o_TypeSel     => o_TypeSel,
		       o_ALUVal      => o_ALUVal,
		       o_RegData2    => o_RegData2,
		       o_PCplus4     => o_PCplus4,
		       o_instMem     => o_instMem,
		       o_upperImmVal => o_upperImmVal);

end structure;