Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity barrel_shifter_arithmetic is
    Port ( 
    x   : in  STD_LOGIC_VECTOR (4 downto 0);
           A   : in  STD_LOGIC_VECTOR(31 downto 0);
           Y   : out STD_LOGIC_VECTOR(31 downto 0));
end barrel_shifter_arithmetic;

architecture structure of barrel_shifter_arithmetic is
  
  component multiplexer is

  port(x         : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       Y         : out std_logic);

end component;

signal s_mux1, s_mux2, s_mux3 ,s_mux4, s_mux5: STD_LOGIC_VECTOR(31 downto 0);

 begin
   --- level 1
   Y <= s_mux5;
   

               
   G1: for i in 0 to 30 generate
     
    multiplexer_i: multiplexer
    port map(x  => x(0),
              A  => A(i),
              B  => A(i+1),
              Y  => s_mux1(i));
              
    end generate; 
     
    
     multiplexer_i: multiplexer
    port map(  x  => x(0),
              A  => A(31),
              B  => '1',
              Y  => s_mux1(31));
              
              
    --level 2 


 G2: for i in 0 to 29 generate
    multiplexer_i: multiplexer
    port map(x  => x(1),
              A  => s_mux1(i),
              B  =>s_mux1(i+2),
              Y  => s_mux2(i));
    end generate; 
  
  
    G3: for i in 30 to 31 generate
     multiplexer_i: multiplexer
    port map(  x  => x(1),
              A  => s_mux1(i),
              B  => '1',
              Y  => s_mux2(i));
 end generate;
 
 --level 3
 
  G4: for i in 0 to 27 generate
    multiplexer_i: multiplexer
    port map(x  => x(2),
              A  => s_mux2(i),
              B  =>s_mux2(i+4),
              Y  => s_mux3(i));
    end generate;
    
     G5: for i in 28 to 31 generate
     multiplexer_i: multiplexer
    port map(  x  => x(2),
              A  => s_mux2(i),
              B  => '1',
              Y  => s_mux3(i));
 end generate; 
 
  --level 4
   G6: for i in 0 to 23 generate
    multiplexer_i: multiplexer
    port map(x  => x(3),
              A  => s_mux3(i),
              B  =>s_mux3(i+8),
              Y  => s_mux4(i));
    end generate;
 G7: for i in 24 to 31 generate
     multiplexer_i: multiplexer
    port map(  x  => x(3),
              A  => s_mux3(i),
              B  => '1',
              Y  => s_mux4(i));
 end generate; 
 
 --level 5
  G8: for i in 0 to 15 generate
    multiplexer_i: multiplexer
    port map(x  => x(4),
              A  => s_mux4(i),
              B  =>s_mux4(i+16),
              Y  => s_mux5(i));
     end generate; 
 
  G9: for i in 15 to 31 generate
     multiplexer_i: multiplexer
    port map(  x  => x(4),
              A  => s_mux4(i),
              B  => '1',
              Y  => s_mux5(i));
 end generate; 
 

 
 

  
end structure;

