use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity branchLogic is 
	port( A :  in std_logic;
		    B : in std_logic;
       sel: in std_logic_vector(2 downto 0);
       O  : out std_logic
         );
end branchLogic;

Architecture behavioral of branchLogic is

Begin

	 O 	<= 	A 		when sel = "000" else -- beq
			not B 	when sel = "001" else -- bgez
			not B 	when sel = "010" else -- bgezal
			B 		when sel = "011" else -- bgtz
			not B 	when sel = "100" else -- blez
			B		when sel = "101" else -- btlzal
			B 		when sel = "110" else -- bltz 
			not A ;				  -- bne	
			
end behavioral;