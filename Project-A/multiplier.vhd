use work.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.array2D.all;

entity multiplier is
    generic(N : integer := 32);
    Port ( a   :  std_logic_vector(31 downto 0);---multiplicand
           b  :  std_logic_vector(31 downto 0);---multiplier
           product : out std_logic_vector(63 downto 0));-- can ignore the high bits so we can make it 32 as well 
end multiplier;


architecture structure of multiplier is

component and2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;
  
  
 component fullAdder_b 
  port(C_in      : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       C_out     : out std_logic;
       S_out     : out std_logic);
  end component;
  
  
  ----------------------------- 
  ---signal s_output: STD_LOGIC_VECTOR(30 downto 0);
  --signal s_Cin :std_logic;
  --signal s_A    :std_logic;
  ---signal s_B    :std_logic;
  signal carry_sum : std_logic;
  signal s_Carry  : array32_bit(31 downto 0);
  signal s_Sum     : array32_bit (31 downto 0);
  signal s_Adder    : 
  
  
  signal ss_Sum  :array32_bit(31 downto 0);
 ----------------------------- 
 begin

  and1 :   and2      
   --- port map(i_A  => a(0),
          --   i_B  => b(0),
             --o_F  => product(0));
             
  
 --- and2 :   and2      
    --port map(i_A  => a(1),
           ---  i_B  => b(1),
            -- o_F  => product(0));
             
             
             
     -- G1: for i in 1 to 31 generate
        -- fulladder_i:full_adder
     -- port map(A  => iX(i),
            --  B  => iY(i),
             -- C_in  => s_B(i),
            --  S_out  => oS(i),
             -- C_out  => s_B(i+1));
      
      --  end generate;
              
  
          
 
 
end structure;
