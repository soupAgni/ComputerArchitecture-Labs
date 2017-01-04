use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity fullAdder_d is
  
  generic(N : integer := 32);
  port(C_in         : in std_logic;
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C_out         : out std_logic;
       S_out         : out std_logic_vector(N-1 downto 0));

end fullAdder_d;

architecture dataflow of fullAdder_d is

  
begin

   G1: for i in 0 to N-1 generate
     
     S_out(i) <= (A(i) xor B(i) xor C_in);
     
     C_out <= (A(i) and B(i)) or (A(i) and C_in) or (B(i) and C_in);
 
  end generate;
  
end dataflow;
