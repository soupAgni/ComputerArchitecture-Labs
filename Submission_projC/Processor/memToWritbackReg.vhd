
library IEEE;
use IEEE.std_logic_1164.all;


entity memToWritebackReg is
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
end memToWritebackReg;


architecture structure of memToWritebackReg is
  
component register_1bit is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

component register_Nbit is
	generic(N : integer := 32);
	port(i_CLK : in std_logic;
		   i_RST : in std_logic;
	    	i_WE  : in std_logic;
		   i_D   : in std_logic_vector(N-1 downto 0);
		   o_Q   : out std_logic_vector(N-1 downto 0));
end component;


begin
  
RegDstReg: register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => RegDst,
		       o_Q    => o_RegDst);
		       
reg_w_enReg : register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => reg_w_en,
		       o_Q    => o_reg_w_en);

  
ALUwriteReg: register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => ALUwrite,
		       o_Q    => o_ALUwrite);
  
isJumpRegReg: register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => isJumpReg,
		       o_Q    => o_isJumpReg);

isLinkReg: register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => isLink,
		       o_Q    => o_isLink);
		       
isLinkALUReg : register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => isLinkALU,
		       o_Q    => o_isLinkALU);


upperImmReg : register_1bit
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => upperImm,
		       o_Q    => o_upperImm);

MEMWB_PCplus4_0utput : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => MEMWB_PCplus4,
		       o_Q    => o_MEMWB_PCplus4);


ValToReg_Reg : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => ValToReg,
		       o_Q    => o_ValToReg);

upperImmValReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => upperImmVal,
		       o_Q    => o_upperImmVal);
		       
instMem_0utput : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => instMem,
		       o_Q    => o_instMem);


end structure;
