use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity Mux6input is
  
  generic(N : integer := 32);
  port(SEL       : in  STD_LOGIC_VECTOR (2 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C         : in std_logic_vector(N-1 downto 0);
       D         : in std_logic_vector(N-1 downto 0);
       E         : in std_logic_vector(N-1 downto 0);
       F         : in std_logic_vector(N-1 downto 0);
       Mux_out   : out std_logic_vector(N-1 downto 0));

end Mux6input;

architecture Behavioral of Mux6input is

  
begin
  
  Mux_out  <= A when SEL = "000" else
        B when SEL = "001" else
        C when SEL = "010" else
        D when SEL = "011" else
        E when SEL = "100" else
        F when SEL = "101";
        
       

  
end Behavioral;
