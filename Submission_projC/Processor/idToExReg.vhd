

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity idToExReg is
	port(Clk              : in std_logic;
		   Reset            : in std_logic;
		   Flush            : in std_logic;
		   WE               : in std_logic;
		   RegDst           : in std_logic;
		   IsLoad           : in std_logic;
		   IsLink           : in std_logic;
		   Reg_w_en         : in std_logic;
		   UpperImm         : in std_logic;
		   dmem_w_en        : in std_logic;
		   IsImmALU         : in std_logic;
		  -- IsRtype          : in std_logic;
		   IsLoadU          : in std_logic;
		   branchAnd        : in std_logic;
		   operation        : in std_logic_vector(2 downto 0);
       ALUsel           : in std_logic_vector(1 downto 0);
       issv             : in std_logic;
       isJumpReg        : in std_logic;
       isLinkALU        : in std_logic;
       reg_w_enANDAlu_write : in std_logic;
       ALU_write        : in std_logic;
       isUnsignedALU    : in std_logic;
		   TypeSel          : in std_logic_vector(1 downto 0);
		   ALU_OP	          : in std_logic_vector(5 downto 0);
		  --- branch_jump_mux  : in std_logic_vector(31 downto 0);
		   RegData1         : in std_logic_vector(31 downto 0);
		   RegData2         : in std_logic_vector(31 downto 0);
		   instMem          : in std_logic_vector(31 downto 0); 
		   PCplus4          : in std_logic_vector(31 downto 0); 
		   upperImmVal      : in std_logic_vector(31 downto 0); 
		   branchALU        : in std_logic_vector(31 downto 0); 
		   ImmSignExt       : in std_logic_vector(31 downto 0);
       o_branchAnd      : out std_logic;
		   o_operation      : out std_logic_vector(2 downto 0);
       o_ALUsel         : out std_logic_vector(1 downto 0);
       o_issv           : out std_logic;
       o_isJumpReg      : out std_logic;
       o_isLinkALU      : out std_logic;
       o_ALU_write      : out std_logic;
       o_isUnsignedALU  : out std_logic;
		   o_IsImmALU       : out std_logic;
		   o_reg_w_enANDAlu_write : out std_logic;
		  -- o_IsRtype        : out std_logic;
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		   o_instMem        : out std_logic_vector(31 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)); 
end idToExReg;


architecture structure of idToExReg is
  

component register_Nbit is
	generic(N : integer := 32);
	port(i_CLK : in std_logic;
		   i_RST : in std_logic;
		   i_WE  : in std_logic;
		   i_D   : in std_logic_vector(N-1 downto 0);
		   o_Q   : out std_logic_vector(N-1 downto 0));
end component;

component register_1bit is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
 end component;

signal s_FlushOrReset : std_logic;
signal s_TypeSel : std_logic_vector(1 downto 0);

begin

  --This mux is here because when we flush the default value for memOP is '111'.
	s_TypeSel <= TypeSel when Reset = '0' else
		         "11";
		         
  s_FlushOrReset <= Flush or Reset;


RegDstReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => RegDst,
		       o_Q   => o_RegDst);

IsLoadReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => IsLoad,
		       o_Q   => o_IsLoad);

reg_w_enANDAlu_write1 : register_1bit

	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => reg_w_enANDAlu_write,
		       o_Q   => o_reg_w_enANDAlu_write);

IsLinkReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => IsLink,
		       o_Q   => o_IsLink);


Reg_w_enReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => Reg_w_en,
		       o_Q   => o_Reg_w_en);


UpperImmReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => UpperImm,
		       o_Q   => o_UpperImm);


dmem_w_enReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => dmem_w_en,
		       o_Q   => o_dmem_w_en);

IsImmALUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => IsImmALU,
		       o_Q   => o_IsImmALU);

--IsRtypeReg : register_1bit
----	port map(i_CLK => Clk,
		--       i_RST => s_FlushOrReset,
		     --  i_WE  => WE,
		     --  i_D   => IsRtype,
		      -- o_Q   => o_IsRtype);

IsLoadUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => IsLoadU,
		       o_Q   => o_IsLoadU);
		       
		       
branchAndReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => branchAnd,
		       o_Q   => o_branchAnd);

operationReg : register_Nbit
generic map(N => 3)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => operation,
		       o_Q   => o_operation);

ALUselReg : register_Nbit
generic map(N => 2)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => ALUsel,
		       o_Q   => o_ALUsel);

issvReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => issv,
		       o_Q   => o_issv);

isJumpRegReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => isJumpReg,
		       o_Q   => o_isJumpReg);

isLinkALUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => isLinkALU,
		       o_Q   => o_isLinkALU);

ALU_writeReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => ALU_write,
		       o_Q   => o_ALU_write);

isUnsignedALUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => isUnsignedALU,
		       o_Q   => o_isUnsignedALU);


TypeSelReg : register_Nbit
	generic map(N => 2)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,    
		       i_D   => s_TypeSel,
		       o_Q   => o_TypeSel);

ALU_OPReg : register_Nbit
	generic map(N => 6)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => ALU_OP,
		       o_Q   => o_ALU_OP);
		       


RegData1Reg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => RegData1,
		       o_Q   => o_RegData1);


RegData2Reg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => RegData2,
		       o_Q   => o_RegData2);

instMemReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => instMem,
		       o_Q   => o_instMem);

PCplus4_0 : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => PCplus4,
		       o_Q   => o_PCplus4);

upperImmValReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => upperImmVal,
		       o_Q   => o_upperImmVal);


branchALUReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => branchALU,
		       o_Q   => o_branchALU);

ImmSignExtReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => s_FlushOrReset,
		       i_WE  => WE,
		       i_D   => ImmSignExt,
		       o_Q   => o_ImmSignExt);

end structure;