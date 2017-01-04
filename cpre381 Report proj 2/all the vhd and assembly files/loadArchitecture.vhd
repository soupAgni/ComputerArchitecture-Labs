use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity loadArchitecture is 
	port( MEM_DATA		: in std_logic_vector(31 downto 0);
		  dataType 		: in std_logic_vector(1 downto 0);
          aluOut 		: in std_logic_vector(1 downto 0);
		  loadUnsigned	: in std_logic;
          O				: out std_logic_vector(31 downto 0)
         );
end loadArchitecture;



Architecture behavioral of loadArchitecture is
  
  signal s_Byte, s_Byte1, s_Byte2, s_Byte3, s_Byte4: std_logic_vector(7 downto 0);
signal s_Hw, s_Hw1, s_Hw2: std_logic_vector(15 downto 0);
signal s_HwSigned, s_ByteSigned, s_ByteExtend, s_ByteExtend1, s_ByteExtend2, s_HwExtend, s_HwExtend1, s_HwExtend2: std_logic_vector(31 downto 0);


Begin


----------------------------------- final mux -------------------------
O 		<= 	s_ByteExtend when dataType = "00" else
			s_HwExtend	 when dataType = "01" else
			MEM_DATA;				        -- word  

----------------------------------- byte select -----------------------
s_Byte	<= 	s_Byte1	when aluOut = "00" else -- byte
			s_Byte2 when aluOut = "01" else -- byte
			s_Byte3	when aluOut = "10" else -- byte
			s_Byte4;						-- byte
		
----------------------------------- half word select ------------------
s_Hw	<=	s_Hw1 	when aluOut(1) = '0' else -- hw   
			s_Hw2;							  -- hw

--------------------------------- byte extend to 32 -------------------
s_ByteExtend1	<= "111111111111111111111111" & s_Byte;
s_ByteExtend2	<= "000000000000000000000000" & s_Byte;
s_ByteSigned	<= s_ByteExtend1 when s_Byte(7) = '1' else
				   s_ByteExtend2;
				   
s_ByteExtend	<= s_ByteSigned when loadUnsigned = '0' else
				   s_ByteExtend2;

------------------------------------ half word extend to 32 -----------
s_HwExtend1	<= "1111111111111111" & s_Hw;
s_HwExtend2	<= "0000000000000000" & s_Hw;		
s_HwSigned	<= s_HwExtend1 when s_Hw(15) = '1' else
			   s_HwExtend2;

s_HwExtend	<= s_HwSigned when loadUnsigned = '0' else
			   s_HwExtend2;

------------------------------ bytes ---------------------------------
s_Byte1	<=  MEM_DATA(7 downto 0);
s_Byte2	<=  MEM_DATA(15 downto 8);
s_Byte3	<=  MEM_DATA(23 downto 16);
s_Byte4	<=  MEM_DATA(31 downto 24);

---------------------------- half words ------------------------------
s_Hw1	<=	MEM_DATA(15 downto 0);
s_Hw2	<=	MEM_DATA(31 downto 16);

end behavioral;