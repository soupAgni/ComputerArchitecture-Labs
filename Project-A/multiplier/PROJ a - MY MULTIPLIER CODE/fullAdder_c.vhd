use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity fullAdder_c is
  
  generic(N : integer := 32);
  port(C_in         : in std_logic;
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C_out         : out std_logic_vector(N-1 downto 0);
       S_out         : out std_logic_vector(N-1 downto 0));

end fullAdder_c;

architecture dataflow of fullAdder_c is
  
  component fullAdder_b is
    
  port(C_in      : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       C_out     : out std_logic;
       S_out     : out std_logic);


end component;

begin

G1: for i in 0 to N-1 generate
  
  fullAdder_1 : fullAdder_b
  
  port map(
  
  C_in  => C_in,
  A  => A(i),
  B  => B(i),
  C_out  => C_out(i),
  S_out => S_out(i));
 
end generate;
  
end dataflow;