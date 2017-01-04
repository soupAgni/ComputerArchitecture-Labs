-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- Sign_extend.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_extend is


  port(input          : in std_logic_vector(7 downto 0);
       sign          : in std_logic;
       output          : out std_logic_vector(15 downto 0));

end entity Sign_extend;

architecture dataflow of Sign_extend is
begin
  
  G1: for i in 0 to 7 generate

  output(i) <= input(i);
  
end generate;
   
   G2: for i in 8 to 15 generate
     
     output(i) <= sign and input(7);
     
end generate;

end dataflow;