use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use work.array2D.all;

entity multiplier_final is
  
generic(N : integer := 3);
  port(
       X         : in  std_logic_vector(3 downto 0);         --Multiplying with each bit of X
       Y         : in  std_logic_vector(3 downto 0);         --Multiplying with one bit of Y
      -- sum_in    : in std_logic_vector(31 downto 0);          --Sum from the previous full adder
       carry_in  : in std_logic;        
      --- sum_out   : out std_logic_vector(3 downto 0);         --Summing to next full adder
       carry_out : out std_logic_vector(3 downto 0);                             --Carry to the next adder
       R         : out  std_logic_vector(3 downto 0));       --Result is stored in R                
end multiplier_final;

architecture dataflow of multiplier_final is
  
component and2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component fullAdder_d 
  
  generic(N : integer := 32);
  port(C_in      : in std_logic;
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C_out     : out std_logic;
       S_out     : out std_logic_vector(N-1 downto 0));

end component;


signal s_and1, s_full_addr_sum, s_full_addr_carry, s_and2, s_and3, s_and4, s_and5, s_and6, s_and7, s_and8, s_and9, s_and10, s_and11, s_and12, s_and13, s_and14, s_and15, s_and16, s_and17, s_and18, s_and19, s_and20, s_and21, s_and22, s_and23, s_and24, s_and25, s_and26, s_and27, s_and28, s_and29, s_and30, s_and31 : std_logic_vector(31 downto 0);
signal  s_C2, s_C3, s_C4, s_C5, s_C6, s_C7, s_C8, s_C9, s_C10, s_C11, s_C12, s_C13, s_C14, s_C15, s_C16, s_C17, s_C18, s_C19, s_C20, s_C21, s_C22, s_C23, s_C24, s_C25, s_C26, s_C27, s_C28, s_C29, s_C30, s_C31  : std_logic;
signal s_R0 : std_logic; 
signal s_R1, s_R2, s_R3, s_R4, s_R5, s_R6, s_R7, s_R8, s_R9, s_R10, s_R11, s_R12, s_R13, s_R14, s_R15, s_R16, s_R17, s_R18, s_R19, s_R20, s_R21, s_R22, s_R23, s_R24, s_R25, s_R26, s_R27, s_R28, s_R29, s_R30, s_R31  : std_logic;
signal s_R  : std_logic_vector(31 downto 0);
signal carry_zero : STD_LOGIC:= '0';
signal s_C1 : std_logic_vector(31 downto 0);



---signal s_sel : std_logic  ;

begin
  
  s_C1(0) <= '0';
  
  and0 : and2

PORT MAP ( i_A => X(0),
           i_B => Y(0),
           o_F => s_and1(0));
           
           R(0)   <= s_and1(0);
           
  -----for the second level------         
      
 and1 : and2

    PORT MAP ( i_A => X(1),
               i_B => Y(0),
               o_F => s_and1(1));
               
 and2_2 : and2

    PORT MAP ( i_A => X(0),
               i_B => Y(1),
               o_F => s_and2(1));
               
               
               
  fullAdder_level2 : fullAdder_d 

    port MAP(C_in      => s_C1(0),
             A         => s_and1,
             B         => s_and2,
             C_out     => s_C1(1),
             S_out     => s_R);
             
        R(1)  <= s_R(0);
                 
  
  ----collumn 1---
G1 : for i in N to 1 generate
  
   G2: for j in 0 to 3 generate
  
  
  and1 : and2

    PORT MAP ( i_A => X(i-j),
               i_B => Y(j),
               o_F => s_and1(j));
               
 and2_2 : and2

    PORT MAP ( i_A => X(j),
               i_B => Y(i-j),
               o_F => s_and2(j));
               
               
               
  fullAdder_level3 : fullAdder_d 

    port MAP(C_in      => s_C1(i-2),
             A         => s_and1,
             B         => s_and2,
             C_out     => s_C1(i-1),
             S_out     => s_R);
               
               
               
               R(2)  <= s_R(1);
               R(3)  <= s_R(2);
           
  end generate;
  
    end generate;
 
           
end dataflow;          
 
        
        
        
             
  