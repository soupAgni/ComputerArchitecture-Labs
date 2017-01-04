-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- Sign_extend_32.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_extend_32 is


  port(input          : in std_logic_vector(15 downto 0);
       sign          : in std_logic;
       output          : out std_logic_vector(31 downto 0));

end entity Sign_extend_32;

architecture dataflow of Sign_extend_32 is
begin
  
  G1: for i in 0 to 15 generate

  output(i) <= input(i);
  
end generate;
   
   G2: for i in 16 to 31 generate
     
     output(i) <= sign and input(15);
     
end generate;

end dataflow;