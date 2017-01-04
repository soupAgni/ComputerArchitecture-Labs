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
  
  process(SEL)
    BEGIN
      CASE SEL IS 
         WHEN "000" => X <= A;
         WHEN "001" => X <= B;
         WHEN "010" => X <= C;
         WHEN "011" => X <= D;
         WHEN "100" => X <= E;
         WHEN OTHERS =>  X <= E;
           
       END CASE;
     END PROCESS;
   
END Behavioral;