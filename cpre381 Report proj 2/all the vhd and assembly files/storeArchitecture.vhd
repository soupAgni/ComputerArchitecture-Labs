use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity storeArchitecture is 
	port( A			: in std_logic_vector(31 downto 0);
		  dataType 	: in std_logic_vector(1 downto 0);
          aluOut 	: in std_logic_vector(1 downto 0);
		  MEM_DATA	: out std_logic_vector(31 downto 0);
          BE		: out std_logic_vector(3 downto 0)
         );
end storeArchitecture;



Architecture behavioral of storeArchitecture is
  
  signal s_Byte, s_Hw: std_logic_vector(3 downto 0);
signal s_Byte1: std_logic_vector(31 downto 0);
signal s_Hw1: std_logic_vector(31 downto 0);
  
  
Begin
-------------------------------------------------------------------------------------------------------
-- Byteena 
-------------------------------------------------------------------------------------------------------
BE 		<= 	s_Byte 	when dataType = "00" else
			s_Hw	when dataType = "01" else
			"1111";				    		-- word  

s_Byte	<= 	"0001"	when aluOut = "00" else -- byte
			"0010" 	when aluOut = "01" else -- byte
			"0100"	when aluOut = "10" else -- byte
			"1000";							-- byte
			
s_Hw	<=	"0011" 	when aluOut(1) = '0' else -- hw
			"1100";							  -- hw
			
-------------------------------------------------------------------------------------------------------
-- MEM_DATA
-------------------------------------------------------------------------------------------------------
			
s_Byte1	<=  A(7 downto 0) & A(7 downto 0) & A(7 downto 0) & A(7 downto 0);
s_Hw1	<=	A(15 downto 0) & A(15 downto 0);

MEM_DATA<=  s_Byte1 when dataType = "00" else
			s_Hw1	when dataType = "01" else
			A;

end behavioral;