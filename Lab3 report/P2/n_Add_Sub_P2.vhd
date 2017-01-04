-------------------------------------------------------------
-- A decoder-type circuit using selected signal assignment --
-------------------------------------------------------------
-- library declaration
use work.all;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity n_Add_Sub_P2 is
  
  generic(N : integer := 32);
  port(nAdd_Sub  : in std_logic;
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       ALUSrc    : in std_logic;
       Y         : out std_logic_vector(N-1 downto 0);
       Z         : out std_logic_vector(N-1 downto 0));

end n_Add_Sub_P2;

architecture dataflow of n_Add_Sub_P2 is
  
  component AddSubP2 is
    
  port(nAdd_Sub  : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       ALUSrc    : in std_logic;
       Y         : out std_logic;
       Z         : out std_logic);


end component;

begin

G1: for i in 0 to N-1 generate
  
  AddSub_1 : AddSubP2
  
  port map(
  
  nAdd_Sub  => nAdd_Sub,
  A  => A(i),
  B  => B(i),
  ALUSrc => ALUSrc,
  Y  => Y(i),
  Z => Z(i));
 
end generate;
  
end dataflow;