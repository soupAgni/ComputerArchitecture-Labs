use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use work.array2D.all;

entity multiplier is
  

  port(
       X         : in  std_logic_vector(31 downto 0);         --Multiplying with each bit of X
       Y         : in  std_logic_vector(31 downto 0);         --Multiplying with one bit of Y
      -- sum_in    : in std_logic_vector(31 downto 0);          --Sum from the previous full adder
       carry_in  : in std_logic;                              --Carry from the previous full adder
       and1_res   : out std_logic_vector(31 downto 0);
       and2_res   : out std_logic_vector(31 downto 0);
       sum_out   : out std_logic_vector(31 downto 0);         --Summing to next full adder
       carry_out : out std_logic;                             --Carry to the next adder
       R         : out  std_logic_vector(31 downto 0));       --Result is stored in R                
end multiplier;

architecture dataflow of multiplier is
  
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

signal s_and1, s_full_addr_sum, s_full_addr_carry, s_and2, s_and3, s_and4, s_and5, s_and6, s_and7, s_and8, s_and9, s_and10, s_and11, s_and12, s_and13, s_and14, s_and15, s_and16, s_and17, s_and18, s_and19, s_and20, s_and21, s_and22, s_and23, s_and24, s_and25, s_and26, s_and27, s_and28, s_and29, s_and30, s_and31 : std_logic_vector(31 downto 0);
signal s_C1, s_C2, s_C3, s_C4, s_C5, s_C6, s_C7, s_C8, s_C9, s_C10, s_C11, s_C12, s_C13, s_C14, s_C15, s_C16, s_C17, s_C18, s_C19, s_C20, s_C21, s_C22, s_C23, s_C24, s_C25, s_C26, s_C27, s_C28, s_C29, s_C30, s_C31  : std_logic;
signal s_R0 : std_logic; 
signal s_R1, s_R2, s_R3, s_R4, s_R5, s_R6, s_R7, s_R8, s_R9, s_R10, s_R11, s_R12, s_R13, s_R14, s_R15, s_R16, s_R17, s_R18, s_R19, s_R20, s_R21, s_R22, s_R23, s_R24, s_R25, s_R26, s_R27, s_R28, s_R29, s_R30, s_R31  : std_logic;
signal s_R  : std_logic_vector(31 downto 0);
signal carry_zero : STD_LOGIC:= '0';
signal s_C1 : std_logic_vector(31 downto 0);

---signal s_sel : std_logic  ;

begin
  
  and0 : and2

PORT MAP ( i_A => X(0),
           i_B => Y(0),
           o_F => s_and1(0));
           
           R(0)   <= s_and1(0);
  
  
  ----collumn 1---
G1: for i in 1 to 31 generate
  
  
and1 : and2

PORT MAP ( i_A => X(i),
           i_B => Y(0),
           o_F => s_and1(i));
           
           
    ---       and1_res(0)   <= s_and1(0);   ----------this is our first result
           and1_res(1)   <= s_and1(1);
           and1_res(2)   <= s_and1(2);
           and1_res(3)   <= s_and1(3);
           and1_res(4)   <= s_and1(4);
           and1_res(5)   <= s_and1(5);
           and1_res(6)   <= s_and1(6);
           and1_res(7)   <= s_and1(7);
           and1_res(8)   <= s_and1(8);
           and1_res(9)   <= s_and1(9);
           and1_res(10)   <= s_and1(10);
           and1_res(11)   <= s_and1(11);
           and1_res(12)   <= s_and1(12);
           and1_res(13)   <= s_and1(13);
           and1_res(14)   <= s_and1(14);
           and1_res(15)   <= s_and1(15);
           and1_res(16)   <= s_and1(16);
           and1_res(17)   <= s_and1(17);
           and1_res(18)   <= s_and1(18);
           and1_res(19)   <= s_and1(19);
           and1_res(20)   <= s_and1(20);
           and1_res(21)   <= s_and1(21);
           and1_res(22)   <= s_and1(22);
           and1_res(23)   <= s_and1(23);
           and1_res(24)   <= s_and1(24);
           and1_res(25)   <= s_and1(25);
           and1_res(26)   <= s_and1(26);
           and1_res(27)   <= s_and1(27);
           and1_res(28)   <= s_and1(28);
           and1_res(29)   <= s_and1(29);
           and1_res(30)   <= s_and1(30);
           and1_res(31)   <= s_and1(31);
           
           
  end generate;
  ----collumn 2------ 
  
  
  G1: for i in 0 to 31 generate
    
  and_lev_2 : and2

PORT MAP ( i_A => X(i),
           i_B => Y(1),
           o_F => s_and2(i));
           
           
           and2_res(0)   <= s_and2(0);   
           and2_res(1)   <= s_and2(1);
           and2_res(2)   <= s_and2(2);
           and2_res(3)   <= s_and2(3);
           and2_res(4)   <= s_and2(4);
           and2_res(5)   <= s_and2(5);
           and2_res(6)   <= s_and2(6);
           and2_res(7)   <= s_and2(7);
           and2_res(8)   <= s_and2(8);
           and2_res(9)   <= s_and2(9);
           and2_res(10)   <= s_and2(10);
           and2_res(11)   <= s_and2(11);
           and2_res(12)   <= s_and2(12);
           and2_res(13)   <= s_and2(13);
           and2_res(14)   <= s_and2(14);
           and2_res(15)   <= s_and2(15);
           and2_res(16)   <= s_and2(16);
           and2_res(17)   <= s_and2(17);
           and2_res(18)   <= s_and2(18);
           and2_res(19)   <= s_and2(19);
           and2_res(20)   <= s_and2(20);
           and2_res(21)   <= s_and2(21);
           and2_res(22)   <= s_and2(22);
           and2_res(23)   <= s_and2(23);
           and2_res(24)   <= s_and2(24);
           and2_res(25)   <= s_and2(25);
           and2_res(26)   <= s_and2(26);
           and2_res(27)   <= s_and2(27);
           and2_res(28)   <= s_and2(28);
           and2_res(29)   <= s_and2(29);
           and2_res(30)   <= s_and2(30);
           and2_res(31)   <= s_and2(31);
           
  end generate;
  
  ------level 3-------

 G1: for i in 0 to 31 generate
  
  fullAdder_level3 : fullAdder_b 

  port MAP(C_in => carry_zero,
       A        => s_and1(i+1),
       B        => s_and2(i),
       C_out    => s_C1(i),  
       S_out    => s_R(i));
  
       
   R(1)   <= s_R(0);
   
 end generate;    
----collumn 2------         
           
and_lev_2 : and2

  PORT MAP ( i_A => X(1),
             i_B => Y(0),
             o_F => s_and1(0));
             
           
  and_lev_2 : and2

  PORT MAP ( i_A => X(0),
             i_B => Y(1),
             o_F => s_and2(0));
             
  fullAdder_level2 : fullAdder_b 

  port MAP(C_in     => carry_zero,
       A        => s_and1(0),
       B        => s_and2(0),
       C_out    => s_C1(i),  
       S_out    => s_R1);
        

      R(1)  <= s_R1;
      

           
--- G1: for i in 0 to 31 generate
  
  --- second for loop------
             
---   G2: for j in 1 to 31 generate
     
      ------------------ON the second Level  ------
  
      
     ----------for the third level--------
     
and_lev_1 : and2

  PORT MAP ( i_A => X(2),
             i_B => Y(0),
             o_F => s_and1(1));
             
           
  and_lev_2 : and2

  PORT MAP ( i_A => X(1),
             i_B => Y(1),
             o_F => s_and2(1));
             
  fullAdder_level2 : fullAdder_b 

  port MAP(C_in     => carry_zero,
       A        => s_and1(0),
       B        => s_and2(0),
       C_out    => s_C1,  
       S_out    => s_R1);
       
       
and_lev_2 : and2

  PORT MAP ( i_A => X(1),
             i_B => Y(1),
             o_F => s_and2(1));
             
  fullAdder_level2 : fullAdder_b 

  port MAP(C_in     => carry_zero,
       A        => s_and1(0),
       B        => s_and2(0),
       C_out    => s_C1,  
       S_out    => s_R1);
        

      R(1)  <= s_R1;
     
  
  
           
end dataflow;          
 
        
        
        
             
  