
library IEEE;
use IEEE.std_logic_1164.all;




entity ifToIDReg is
	port(Clk      : in std_logic;
		   Reset    : in std_logic;
		   WE       : in std_logic;
		   instMem  : in std_logic_vector(31 downto 0);
		   PCplus4  : in std_logic_vector(31 downto 0);
		   o_instMem: out std_logic_vector(31 downto 0);
		   o_PCplus4: out std_logic_vector(31 downto 0));
end ifToIDReg;


architecture structure of ifToIDReg is

component register_Nbit is
	generic(N : integer := 32);
	port(i_CLK : in std_logic;
		   i_RST : in std_logic;
		   i_WE  : in std_logic;
	     i_D   : in std_logic_vector(N-1 downto 0);
		   o_Q   : out std_logic_vector(N-1 downto 0));
end component;


begin

PCReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => PCplus4,
		       o_Q    => o_PCplus4);

IMemReg : register_Nbit
	generic map(N => 32)
	port map(i_CLK  => Clk,
		       i_RST  => Reset,
		       i_WE   => WE,
		       i_D    => instMem,
		       o_Q    => o_instMem);

end structure;