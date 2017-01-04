library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1_top is
    generic(N : integer := 32);
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           C   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           D   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           X   : out STD_LOGIC_VECTOR (N-1 downto 0));
end mux_4to1_top;

architecture Behavioral of mux_4to1_top is
begin
   
   x <= A when SEL = '00' else
        B when SEL = '01' else
        C when SEL = '10' else
        D when SEL = '11' else
        '0' when others
   
end Behavioral;