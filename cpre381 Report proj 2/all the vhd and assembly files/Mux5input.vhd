Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_5to1_top is
    generic(N : integer := 1);
    Port ( SEL : in  STD_LOGIC_VECTOR (2 downto 0);
           A   : in  STD_LOGIC;
           B   : in  STD_LOGIC;
           C   : in  STD_LOGIC;
           D   : in  STD_LOGIC;
           E   : in  STD_LOGIC;
           X   : out STD_LOGIC);
end mux_5to1_top;

architecture Behavioral of mux_5to1_top is
begin
  
  
      X <=  A WHEN SEL="000" ELSE
            B WHEN SEL="001" ELSE
            C WHEN SEL="010" ELSE
            D WHEN SEL="011" ELSE
            E WHEN SEL="100" ELSE
            '0';
    
   
END Behavioral;