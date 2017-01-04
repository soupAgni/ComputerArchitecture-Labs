--- Instruction Fetch module

--Souparni Agnihotri--



use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std;

entity I_Fetch is
  
port(BorJ       :  in std_logic;
     JR         :  in std_logic;
     Branch_op  :  in std_logic;
     Jump_op    :  in std_logic;
     WE         :  in std_logic;
     reset      :  in std_logic;
     clock      :  in std_logic;
     instr_25to0:  in std_logic_vector(25 downto 0);
     readData1  :  in std_logic_vector(31 downto 0);
     imm_val    :  in std_logic_vector(31 downto 0);
     PC_Val_final :  out std_logic_vector(31 downto 0);
     PC_add_four   : out std_logic_vector(31 downto 0));
     
end I_Fetch;

architecture behaviour of I_Fetch is

  
 component n_full_adder_current is
   
  generic(N : integer := 32);
   port(iX : in std_logic_vector(N-1 downto 0);
       iY : in std_logic_vector(N-1 downto 0);
       iC : in std_logic;
       oS : out std_logic_vector(N-1 downto 0);
       oC : out std_logic);
  
end component;

component mux_2to1_top is
  generic(N : integer := 32);
    Port ( SEL : in  STD_LOGIC;
           A   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B   : in  STD_LOGIC_VECTOR (N-1 downto 0);
           X   : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;


component PC is
  
  port(Data    :   in std_logic_vector(31 downto 0);
       Output  :   out std_logic_vector(31 downto 0);
       WE      :   in std_logic;
       reset   :   in std_logic;
       clock   :   in std_logic);
       
end component;


component barrel_shifter_arithmetic_logical
 
        port(
            shift_amount : in std_logic_vector(4 downto 0);
            value        : in std_logic_vector(31 downto 0);
            OP           : in std_logic_vector(1 downto 0);
            output       : out std_logic_vector(31 downto 0));
                
end component;

  signal PCval                                      : std_logic_vector(3 downto 0);   
  signal PCval_32                                   : std_logic_vector(31 downto 0);
  signal J_val,s_mux, s_shift , s_immVal            : std_logic_vector(31 downto 0);
  signal s_instr_27to0                              : std_logic_vector(27 downto 0);
  signal PC_Val_final_temp                          : std_logic_vector(31 downto 0);
  signal s_JumpTA                                   : std_logic_vector(31 downto 0);
  signal s_BranchTA                                 : std_logic_vector(31 downto 0);
  
   
  constant Inc_4: std_logic_vector(31 downto 0):= x"00000004";
  constant shift_2: std_logic_vector(4 downto 0):= "00010";
  constant sll_logic: std_logic_vector(1 downto 0):= "00";
  constant zero : std_logic := '0';
  

begin
  
  --Concat 00 ---
  
  s_instr_27to0  <= instr_25to0  & "00";
  
  
  ----
    
  ----Add PC = PC + 4 -----
  
  
  fullAdder1 : n_full_adder_current
   
  port MAP(iC      =>  zero,  -- et to 0
           iX         =>  PC_Val_final_temp,  --Pass in your PC value
           iY         =>  Inc_4,      --Pass in '4'
           oC     =>  open,
           oS     =>  PCval_32);  -- pass into mux   ---pc = pc+4
       
       PCval  <=  PCval_32(3 downto 0);    ----------for the jump instruction
       
       ---have a pc val 4 bit as an output
  ----
   
  J_val  <=  PCval & s_instr_27to0;  -- pass into mux of branch op and jump
  
  ----
  
  ----Shifting the value imm_val
  s_shift  <=  imm_val(29 downto 0) & "00";
                    
 ----
 
 ----Adding the value into second adder
 
 fullAdder2 : n_full_adder_current
   
  port MAP(iC  =>  zero,  -- Set to 0
       iX         =>  PCval_32,  --Pass in your PC value
       iY         =>  s_shift,   --shift val
       oC     =>  open,
       oS     =>  s_immVal);  -- pass into mux
       
  ----
   mux_2to1_top1 : mux_2to1_top
   
    Port map
         (Branch_op,PCval_32, s_immval,s_BranchTA);

mux_2to1_top2 : mux_2to1_top
   
    Port map
         (Jump_op,s_BranchTA,J_val,s_JumpTA);

mux_2to1_top3 : mux_2to1_top
   
    Port map
         (JR,s_JumpTA,readData1,s_mux);


  ----
  PC1 :  PC 
  
  port MAP(Data    => s_mux,
       Output  => PC_Val_final_temp,
       WE      => '1',
       reset   => reset,
       clock   => clock);

PC_add_four <=  PCval_32;
PC_Val_final <=  PC_Val_final_temp;

end behaviour;