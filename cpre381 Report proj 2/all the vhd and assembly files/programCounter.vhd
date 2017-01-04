---Program counter

-- Souparni Agnihotri--

use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity PC is
  
  port(Data    :   in std_logic_vector(31 downto 0);
       Output  :   out std_logic_vector(31 downto 0);
       WE      :   in std_logic;
       reset   :   in std_logic;
       clock   :   in std_logic);
       
end PC;

architecture behaviour of PC is
  
signal current_pc: std_logic_vector( 31 downto 0) := X"00000000";
constant PCU_OP_INC: std_logic_vector(3 downto 0):= "0100";


 begin
    
 --current_pc  <= x"00000000";
    
   REG :  process(clock)
    
   begin
      
     if(rising_edge(clock)) then
        
       if(reset = '1') then 
        
          current_pc  <= x"00000000";
           
        elsif(WE = '1') then
        
          current_pc  <=  Data;
           
           
        end if;
         
  end if;
     
  end process;
  
  Output <= current_pc;



  
end behaviour;