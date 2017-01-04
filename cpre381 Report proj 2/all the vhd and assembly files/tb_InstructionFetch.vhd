library IEEE;
use IEEE.std_logic_1164.all;

entity tb_InstructionFetch is
  
  generic(gCLK_HPER   : time := 50 ns);
 
end tb_InstructionFetch;

architecture behavior of tb_InstructionFetch is
 
  

component I_Fetch is
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

end component;

signal s_BorJ,  s_JR, s_BranchOp ,s_JumpOp,s_WE,s_reset,s_clock    :std_logic;
signal   s_readData1, s_PC_Val_final, s_immVal,s_PC_add_four    : std_logic_vector(31 downto 0);
signal   s_instr_25to0                     : std_logic_vector(25 downto 0); 
 
 begin
   
   DUT: I_Fetch
   port map(
   BorJ    => s_BorJ,  
   JR      => s_JR,
     Branch_op  => s_BranchOp,
     Jump_op    => s_JumpOp,
     WE         => s_WE,
     reset      => s_reset,
     clock      => s_clock,
     instr_25to0=> s_instr_25to0,
     readData1  => s_readData1,
     imm_val    => s_immVal,
     PC_Val_final =>s_PC_Val_final);
     
   
    P_CLK: process
  begin
    s_clock <= '0';
    wait for gCLK_HPER;
    s_clock <= '1';
    wait for gCLK_HPER;
  end process;
  
  P_TB: process
   
 begin
    --- This should output the value of my instruction_25to0
    s_BorJ        <=  '0';
     s_JR         <=  '0';
     s_BranchOp  <=  '0';
     s_JumpOp    <=  '0';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000000001";
     s_readData1   <= x"00000000";
     s_immVal <= x"00001111";
   
 wait for gCLK_HPER;
    --- This should output the value of instr_25to0
    s_BorJ        <=  '0';
     s_JR         <=  '0';
     s_BranchOp  <=  '1';
     s_JumpOp    <=  '0';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000000";
     s_immVal <= x"00111111";
     
 wait for gCLK_HPER;
 
      --- This should output the value of readData1
     s_BorJ        <=  '0'; 
     s_JR         <=  '1';
     s_BranchOp  <=  '0';
     s_JumpOp    <=  '0';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"11111111";
     s_immVal <= x"00111111";
     
     
       
 wait for gCLK_HPER;
 
      --- This should output the value of ReadData1
      s_BorJ        <=  '0';
     s_JR         <=  '1';
     s_BranchOp  <=  '1';
     s_JumpOp    <=  '0';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000000";
     s_immVal   <= x"00111111";
   
     
       
 wait for gCLK_HPER;
  --- This should output the value of immVal
    s_BorJ        <=  '0';
     s_JR         <=  '0';
     s_BranchOp  <=  '0';
     s_JumpOp    <=  '1';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000000";
     s_immVal <= x"00111111";
     
wait for gCLK_HPER;
  --- This should output the value of immVal
  s_BorJ        <=  '0';
     s_JR         <=  '0';
     s_BranchOp  <=  '1';
     s_JumpOp    <=  '1';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000000";
     s_immVal <= x"00111111";
  wait for gCLK_HPER;  
  
  --- This should output the value of readData1
    s_BorJ        <=  '0';
     s_JR         <=  '1';
     s_BranchOp  <=  '0';
     s_JumpOp    <=  '1';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000111";
     s_immVal <= x"00111111";
  wait for gCLK_HPER;  
  
  --- This should output the value of readData1
  s_BorJ        <=  '0';
     s_JR         <=  '1';
     s_BranchOp  <=  '1';
     s_JumpOp    <=  '1';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000011";
     s_immVal <= x"00111111";
  wait for gCLK_HPER;
  
    s_BorJ        <=  '1';
     s_JR         <=  '1';
     s_BranchOp  <=  '0';
     s_JumpOp    <=  '1';
     s_WE         <=  '1'; 
     s_reset      <=  '0';  
     s_instr_25to0 <= "00000000000000000000001110";
     s_readData1   <= x"00000111";
     s_immVal <= x"00111111";
  wait for gCLK_HPER;    


    wait;
  end process;
  
end behavior; 
    