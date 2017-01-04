Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ALU_64bit_P2 is
    generic(N : integer := 32);
    Port ( A        : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B        : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Cin      : in  STD_LOGIC;
           Op       : in  STD_LOGIC_VECTOR (2 downto 0);
           Ainvert  : in  STD_LOGIC;
           Binvert  : in  STD_LOGIC;
           Zero     : out STD_LOGIC;  
           Overflow : out STD_LOGIC;
           Carry_out: out STD_LOGIC;
           Result   : out STD_LOGIC_VECTOR (N-1 downto 0)
           );
end ALU_64bit_P2;

architecture dataflow of ALU_64bit_P2 is
  
  component ALU_1bit_P2 
    generic(N : integer := 32);
    Port ( A        : in  STD_LOGIC;
           B        : in  STD_LOGIC;
           Less     : in  STD_LOGIC;
           Cin      : in  STD_LOGIC;
           Op       : in  STD_LOGIC_VECTOR (2 downto 0);
           Ainvert  : in  STD_LOGIC;
           Binvert  : in  STD_LOGIC;
           Overflow : out STD_LOGIC;
           Set      : out STD_LOGIC;
           Result   : out STD_LOGIC;
           Carry_out: out STD_LOGIC
           );
  end component;
  
 
    
  ----------------------------- 
  signal s_Set, s_Overflow, s_Carry_out ,s_Result: STD_LOGIC_VECTOR(N-1 downto 0);
  signal s_Not                                   :STD_LOGIC_VECTOR(N-1 downto 0);
  
  signal s_Or : STD_LOGIC_VECTOR(N-1 downto 0);
  
  ----------------------------- 
 
 begin 
    Result <= s_Result;   

    ALU_1BIT_i: ALU_1bit_P2
    port map (A         => A(0),     
              B         => B(0),      
              Less      => s_Set(63),  
              Cin       => Cin,
              Op        => Op,
              Ainvert   => Ainvert,
              Binvert   => Binvert,
              Overflow  => s_Overflow(0),
              Set       => s_Set(0),
              Result    => s_Result(0), 
              Carry_out => s_Carry_out(0)
              );
   
    G1: for i  in 1 to N-1 generate
    ALU_1BIT_i: ALU_1bit_P2
    port map (A         => A(i),     
              B         => B(i),      
              Less      => '0',  
              Cin       => s_Carry_out(i-1),
              Op        => Op,
              Ainvert   => Ainvert,
              Binvert   => Binvert,
              Overflow  => s_Overflow(i),
              Set       => s_Set(i),
              Result    => s_Result(i), ------------CHECK THIS OUT
              Carry_out => s_Carry_out(i)
              );
         end generate;
         
    Zero <= not (s_Result(0) or s_Result(1) or s_Result(2) or s_Result(3) or s_Result(4) or s_Result(5) or s_Result(6) or s_Result(7) 
             or s_Result(8) or s_Result(9) or s_Result(10) or s_Result(11) or s_Result(12) or s_Result(13) or s_Result(14) or s_Result(15) 
             or s_Result(16) or s_Result(17) or s_Result(18) or s_Result(19) or s_Result(20) or s_Result(21) or s_Result(22) or s_Result(23)
             or s_Result(24) or s_Result(25) or s_Result(26) or s_Result(27) or s_Result(28) or s_Result(29) or s_Result(30) or s_Result(31)
             or s_Result(32) or s_Result(33) or s_Result(34) or s_Result(35) or s_Result(36) or s_Result(37) or s_Result(38) or s_Result(39) 
             or s_Result(40) or s_Result(41) or s_Result(42) or s_Result(43) or s_Result(44) or s_Result(45) or s_Result(46) or s_Result(47)
             or s_Result(48) or s_Result(49) or s_Result(50) or s_Result(51) or s_Result(52) or s_Result(53) or s_Result(54) or s_Result(55)
              or s_Result(56) or s_Result(57) or s_Result(58) or s_Result(59) or s_Result(60) or s_Result(61) or s_Result(62) or s_Result(63)
              
             ); 
             

  
    Overflow <= s_Overflow(31);
    Carry_out <= s_Carry_out(31);
    
end dataflow;