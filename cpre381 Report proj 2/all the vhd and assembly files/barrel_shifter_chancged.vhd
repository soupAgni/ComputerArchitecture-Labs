use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity barrel_shifter_arithmetic_changed is
 
     generic(N : integer := 32);
        port(
          shift_amount: in std_logic_vector(4 downto 0);
            value:     in std_logic_vector(31 downto 0);
                  OP: in std_logic_vector(1 downto 0);
                 output: out std_logic_vector(31 downto 0)
                 );
                
                
end barrel_shifter_arithmetic_changed;


architecture structure of barrel_shifter_arithmetic_changed is



component barrel_shifter
    Port (
   
      x   : in  STD_LOGIC_VECTOR (4 downto 0);
           A   : in  STD_LOGIC_VECTOR(31 downto 0);
           Y   : out STD_LOGIC_VECTOR(31 downto 0));
end component;



component barrel_shifter_arithmetic
    Port (
 
    x   : in  STD_LOGIC_VECTOR (4 downto 0);
           A   : in  STD_LOGIC_VECTOR(31 downto 0);
           Y   : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component n_full_adder is
  generic(n : integer := 5);
   port(iX : in std_logic_vector(n-1 downto 0);
       iY : in std_logic_vector(n-1 downto 0);
       iC : in std_logic;
       oS : out std_logic_vector(n-1 downto 0);
       oC : out std_logic);
 
end component;


signal s_reverse,s_AR,s_AL,s_R,s_L,s_FinalA, s_Mux1, s_Mux2, s_Mux3, s_Mux4, s_Mux5,s_Lfinal,s_ALfinal: std_logic_vector(31 downto 0);
signal s_MSB,s_signalLeft: std_logic;
signal s_Shift:  std_logic_vector(4 downto 0);
signal temp : std_logic;


begin

s_MSB  <= value(31);
s_signalLeft <= OP(1);

 G1: for i in 0 to 31 generate
  
   s_reverse(31-i) <= value(i);
  
 end generate;
 
 
  full_adder:  n_full_adder
    port map(iX  =>shift_amount,
      iY =>"11111",
      iC => '1',
      oS => s_Shift,
      oC =>temp );
 
 
  barrel_shifter_left:  barrel_shifter
    port map(x  =>s_Shift ,
              A  => s_reverse,
              Y  => s_L);
              
  G2: for i in 0 to 31 generate
  
    s_Lfinal(31-i) <= s_L(i);
  
 end generate;          
 
 
 
  barrel_shifter_right:  barrel_shifter
    port map(x  => shift_amount,
              A  => value,
              Y  => s_R);
             
             
    barrel_shifter_left_arithmetic:  barrel_shifter_arithmetic
    port map(x  => s_Shift ,
              A  => s_reverse,
              Y  => s_AL);
              
   G3: for i in 0 to 31 generate
  
    s_ALfinal(31-i) <= s_AL(i);
  
 end generate;  
 
 
 
  barrel_shifter_right_arithmetic:  barrel_shifter_arithmetic
    port map(x  => shift_amount,
              A  => value,
              Y  => s_AR);
 
  ------------------------------------------------------------------------------
  -- level one
  ------------------------------------------------------------------------------
           
           
           s_Mux1  <=  s_AR when value(31) = '1' else s_R;
           
    
           s_Mux2  <=  s_ALfinal when value(31) = '1' else s_Lfinal;
           
          
  ------------------------------------------------------------------------------
  -- level two
  ------------------------------------------------------------------------------
 
           
           s_Mux3  <=  s_Mux1 when OP(1) = '1' else s_R;
           
           
           s_Mux4  <=  s_Mux2 when OP(1) = '1' else s_Lfinal;
          
  ------------------------------------------------------------------------------
  -- level three
  ------------------------------------------------------------------------------
 
           
             
           output  <=  s_Mux4 when OP(0) = '1' else s_Mux3;
           


end structure;
