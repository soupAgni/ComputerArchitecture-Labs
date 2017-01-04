library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_stage is
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
		isLinkALU        : in std_logic;
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
		
end MEM_stage;


architecture structure of MEM_stage is

component dmem is 
  generic (mif_filename : string := "mem.mif");
  port(address    : in  std_logic_vector(31 downto 0);
       data_in    : in  std_logic_vector(31 downto 0);
       lstypesel  : in  std_logic_vector(1 downto 0);
       lu_sel     : in  std_logic;
       clock      : in  std_logic;
       wren       : in  std_logic;
       data_out   : out std_logic_vector(31 downto 0));
end component;
  

component memToWritebackReg is
	port(Clk             : in std_logic;
		   Reset           : in std_logic;
		   WE              : in std_logic;
		   RegDst          : in std_logic;
		   Reg_w_en        : in std_logic;
		   ALUwrite        : in std_logic;
		   isJumpReg       : in std_logic;
		   isLink          : in std_logic;
		   isLinkALU       : in std_logic;
		   UpperImm        : in std_logic;
		   ValToReg        : in std_logic_vector(31 downto 0);
		   MEMWB_PCplus4   : in std_logic_vector(31 downto 0);
		   instMem         : in std_logic_vector(31 downto 0);
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

signal s_dmemOut, s_muxOut : std_logic_vector(31 downto 0);
--signal s_TypeSel : std_logic_vector(1 downto 0);


begin
  
  -- 2 to 1 mux ALU and DMEM
  s_muxOut <= s_dmemOut WHEN isLoad = '1' else
              EXMEM_ALU;

  DataMemory : dmem 
  generic map(mif_filename => dmem_mif_filename)
  port map(address    => EXMEM_ALU,
           data_in    => EXMEM_Rt,
           lstypesel  => TypeSel,
           lu_sel     => isLoadU,
           clock      => Clk,
           wren       => dmem_w_en,
           data_out   => s_dmemOut);

  
  MEMWB_Reg : memToWritebackReg 
	port map(Clk             => Clk,
		       Reset           => MEMWB_Reg_Reset,
		       WE              => WE,
		       RegDst          => RegDst,
		       Reg_w_en        => reg_w_en,
		       ALUwrite        => ALUwrite,
		       isJumpReg       => isJumpReg,
		       isLink          => isLink,
		       isLinkALU       => isLinkALU,
		       UpperImm        => UpperImm,
		       ValToReg        => s_muxOut,
		       MEMWB_PCplus4   => MEMWB_PCp4,
		       instMem         => IDEX_imem,
		       upperImmVal     => upperImmVal,
		       o_RegDst        => o_RegDst,
		       o_Reg_w_en      => o_Reg_w_en,
		       o_ALUwrite      => o_ALUwrite,
		       o_isJumpReg     => o_isJumpReg,
		       o_isLink        => o_isLink,
		       o_isLinkALU     => o_isLinkALU,
		       o_UpperImm      => o_UpperImm,
		       o_ValToReg      => o_ValToReg,
		       o_MEMWB_PCplus4 => o_MEMWB_PCplus4,
		       o_instMem       => o_instMem,
		       o_upperImmVal   => o_upperImmVal);

end structure;