--- ALU unit

--Souparni Agnihotri--


use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
  
port(Unit_Sel  :  in std_logic_vector(1 downto 0);
     Shift_Amt :  in std_logic_vector(4 downto 0);
     Shift_op  :  in std_logic_vector(1 downto 0);
     AlU_op    :  in std_logic_vector(2 downto 0);
     Data1     :  in std_logic_vector(31 downto 0);
     Data2     :  in std_logic_vector(31 downto 0);
     Sltu      :  in std_logic;
     selectData:  in std_logic;
     A_inv     :  in std_logic;
     B_inv     :  in std_logic;
     C_in      :  in std_logic;
     Zero      :  out std_logic;
     Result    :  out std_logic_vector(31 downto 0));   ---We need more outputs to handle jump and branch I think
       
end entity;

architecture structure of ALU is
  
       
  
     component barrel_shifter_arithmetic_logical 
 
    
        port(
            shift_amount : in std_logic_vector(4 downto 0);
            value        : in std_logic_vector(31 downto 0);
            OP           : in std_logic_vector(1 downto 0);
            output       : out std_logic_vector(31 downto 0));
                
                
end component;
    
    
    component multiplier 
  
  
  port(A           : in std_logic_vector(31 downto 0);
       B           : in std_logic_vector(31 downto 0);
       Result      : out std_logic_vector(31 downto 0));

end component;

component ALU_64bit_P2  --this is actually 32 bit
  
    Port ( A        : in  STD_LOGIC_VECTOR (31 downto 0);
           B        : in  STD_LOGIC_VECTOR (31 downto 0);
           Cin      : in  STD_LOGIC;
           Sltu     : in  STD_LOGIC;
           Op       : in  STD_LOGIC_VECTOR (2 downto 0);
           Ainvert  : in  STD_LOGIC;
           Binvert  : in  STD_LOGIC;
           Zero     : out STD_LOGIC;  
           Overflow : out STD_LOGIC;
           Carry_out: out STD_LOGIC;
           Result   : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component mux_2to1_top 
  generic(N : integer := 32);
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           X   : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;

component mux3to1 is 
   generic(N : integer := 32);
port( A: in std_logic_vector(N-1 downto 0);
      B: in std_logic_vector(N-1 downto 0); 
      C: in std_logic_vector(N-1 downto 0);              
      S: in std_logic_vector(1 downto 0);
      O: out std_logic_vector(N-1 downto 0));
end component;

signal s_BS     : std_logic_vector(31 downto 0);
signal Alu_out  : std_logic_vector(31 downto 0); 
signal s_ValuetoShift  : std_logic_vector (31 downto 0);
signal s_MUL     : std_logic_vector(31 downto 0);
signal s_Overflow    : std_logic;
signal s_CarryOut    : std_logic;

  ---We need more outputs to handle jump and branch I think
begin
mux1 :   mux_2to1_top
  port map(SEL => selectData,
           A   =>  Data1,
           B   =>  Data2,
           X   => s_ValuetoShift); 
           
         
    shifter:  barrel_shifter_arithmetic_logical
    port map(shift_amount =>  Shift_Amt ,
            value  => s_ValuetoShift,
             OP    => Shift_op,
            output  => s_BS);
    
    multiplier1 :   multiplier
  port map(A   =>  Data1,
           B   =>  Data2,
           Result   => s_MUL); 
           
  alucomponent  :  ALU_64bit_P2
   port map(A   =>  Data1,
           B   =>  Data2,
           Cin  =>  C_in,
           Sltu =>  Sltu,
          Op  =>  AlU_op,
          Ainvert => A_inv,
          Binvert => B_inv,
          Zero    => Zero,
          Overflow => s_Overflow,
          Carry_out => s_CarryOut,
           Result   => Alu_out);
           
  finalmux :  mux3to1
    port map(A   => s_BS ,
           B   =>  s_MUL,
           C   =>  Alu_out,
           S   =>  Unit_Sel,
           O => Result); 


end structure;
  



    
    





    
    
