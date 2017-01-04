library IEEE;
use IEEE.std_logic_1164.all;

entity n_full_adder_current is
  generic(N : integer := 32);
   port(iX : in std_logic_vector(N-1 downto 0);
       iY : in std_logic_vector(N-1 downto 0);
       iC : in std_logic;
       oS : out std_logic_vector(N-1 downto 0);
       oC : out std_logic);
  
end n_full_adder_current;

architecture structure of n_full_adder_current is
   component full_adder is

  port(iX              : in std_logic;
       iY 		           : in std_logic;
       iC 		           : in std_logic;
       oS 		           : out std_logic;
       oC 		           : out std_logic
       );

end component;
 signal  s_B: std_logic_vector(N downto 0);

begin
  
  s_B(0) <= iC;

  
    G1: for i in 0 to N-1 generate
         fulladder_i:full_adder
      port map(iX  => iX(i),
              iY  => iY(i),
              iC  => s_B(i),
              oS  => oS(i),
              oC  => s_B(i+1));
      
        end generate;
     oC <= s_B(N-1);
     
  
end structure;
