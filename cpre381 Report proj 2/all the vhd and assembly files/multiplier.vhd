use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
  use IEEE.NUMERIC_STD.ALL;

entity multiplier is
  
  
  port(
       A           : in std_logic_vector(31 downto 0);
       B           : in std_logic_vector(31 downto 0);
       Result      :out std_logic_vector(31 downto 0)
       
     );

end entity multiplier;

architecture dataflow of multiplier is
  
  signal s_result : std_logic_vector(63 downto 0);
  
  begin
    
   s_result <= std_logic_vector(unsigned(A) * unsigned(B));
   
   Result <= s_result(31 downto 0);
  
end dataflow;
