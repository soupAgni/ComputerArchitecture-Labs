
library IEEE;
use IEEE.std_logic_1164.all;

entity exToMemReg is
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
end exToMemReg;


architecture structure of exToMemReg is

component register_Nbit is
	generic(N : integer := 32);
	port(
		i_CLK : in std_logic;
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

signal s_TypeSel : std_logic_vector(1 downto 0);--------------------come back to this

begin

  --flush mux
	s_TypeSel <= TypeSel when Reset = '0' else 
		          "11";

RegDstReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => RegDst,
		       o_Q   => o_RegDst);

isLoadReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => isLoad,
		       o_Q   => o_isLoad);

isLoadUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => isLoadU,
		       o_Q   => o_isLoadU);

reg_w_enReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => reg_w_en,
		       o_Q   => o_Reg_w_en);

dmem_w_enReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => dmem_w_en,
		       o_Q   => o_dmem_w_en);

isLinkALUReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => isLinkALU,
		       o_Q   => o_isLinkALU);
		       
ALU_writeReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => ALU_write,
		       o_Q   => o_ALUwrite);
		       
isJumpReg_Reg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => isJumpReg,
		       o_Q   => o_isJumpReg);
		       
isLinkReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => isLink,
		       o_Q   => o_isLink);


upperImmReg : register_1bit
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => upperImm,
		       o_Q   => o_UpperImm);

TypeSelReg : register_Nbit
	generic map(N => 2)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => s_TypeSel,
		       o_Q   => o_TypeSel);

ALUValReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => ALUVal,
		       o_Q   => o_ALUVal);

RegData2Reg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => RegData2,
		       o_Q   => o_RegData2);

PCplus4_0utput : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => PCplus4,
		       o_Q   => o_PCplus4);
		       
instMemReg: register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => instMem,
		       o_Q   => o_instMem);

upperImmValReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK => Clk,
		       i_RST => Reset,
		       i_WE  => WE,
		       i_D   => upperImmVal,
		       o_Q   => o_upperImmVal);
		       
end structure;
