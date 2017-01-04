use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity multiplexer_d is
  
  generic(N : integer := 32);
  port(x         : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       Y         : out std_logic_vector(N-1 downto 0));

end multiplexer_d;

architecture dataflow of multiplexer_d is

  
begin

   G1: for i in 0 to N-1 generate
     Y(i) <= (A(i) and (not x(i))) or (B(i) and X(i));
 
  end generate;
  
end dataflow;
