use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity ones_complement is
  
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end ones_complement;

architecture dataflow of ones_complement is
  
  component inv
    port (i_A  : in std_logic;
       o_F  : out std_logic);
end component;

  
begin

G1: for i in 0 to N-1 generate
  
  inv_i: inv
  
  port map(
  
  i_A  => i_A(i),
  o_F  => o_F(i));
 
end generate;
  
end dataflow;
