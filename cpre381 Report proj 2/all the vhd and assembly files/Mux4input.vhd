Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1 is
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           A   : in  STD_LOGIC;
           B   : in  STD_LOGIC;
           C   : in  STD_LOGIC;
           D   : in  STD_LOGIC;
           X   : out STD_LOGIC);
end mux_4to1;

architecture Behavioral of mux_4to1 is
begin
  
  
      X <=  A WHEN SEL="00" ELSE
            B WHEN SEL="01" ELSE
            C WHEN SEL="10" ELSE
            D WHEN SEL="11" ELSE
            '0';
    
   
END Behavioral;

