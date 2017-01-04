-------------------------------------------------------------------------
-- Fahmida Joyti
--tb_control_unit
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_controlunit is
 
end tb_controlunit;

architecture behavior of tb_controlunit is
 
  
component Control_Unit is
  
port(
       OpCode   :  in std_logic_vector(5 downto 0);
       funct    :  in std_logic_vector(5 downto 0);
       rt       :  in std_logic_vector(4 downto 0);
       regDest  :  out std_logic;
       Jump     :  out std_logic;
       Branch   :  out std_logic;
       MemRead  :  out std_logic;
       MemtoReg :  out std_logic;  --- This will be 1 for loads and 0 for everything else
       ALU_Code :  out std_logic_vector(3 downto 0);  ---this is a 4 bit value. Gotta change name to resolve conflict with original ALUOp 
       MemWrite :  out std_logic;
       ALUSrc   :  out std_logic;
       RegWrite :  out std_logic;
      SignExtend :  out std_logic;
      LoadUpperImmediate :  out std_logic;
      isLink     : out std_logic;
      dataType   : out std_logic_vector(1 downto 0);
      LoadUnsigned : out std_logic;
      JorJAL      :  out std_logic;
      JRegister   :  out std_logic;
      Bgtz_blez   :out std_logic;
      BranchType  :out std_logic_vector(2 downto 0);
      isLinkALU   :out std_logic;
      isImmALU    :out std_logic
       
        );
       
end component;

signal s_regDest, s_Jump ,s_Branch,s_MemRead,s_MemtoReg,s_MemWrite,s_ALUSrc,s_RegWrite ,s_SignExtend,s_LoadUpperImmediate,s_isLink,s_LoadUnsigned,s_JorJAL,s_JRegister,s_Bgtz_blez,s_isLinkALU,s_isImmALU                                 :std_logic;
signal   s_rtAddr                     : std_logic_vector(4 downto 0);
signal   s_OpCode,s_functCode                     : std_logic_vector(5 downto 0);  
signal   s_ALUCode                     : std_logic_vector(3 downto 0);  
signal   s_BranchType                     : std_logic_vector(2 downto 0);  
signal   s_DataType                     :std_logic_vector(1 downto 0);

 
 begin

 DUT: Control_Unit 
  port map(OpCode  => s_OpCode,
          funct    => s_functCode,
          rt       => s_rtAddr,
          regDest => s_regDest,
          Jump    => s_Jump,
	        Branch  => s_Branch,
	        MemRead => s_MemRead,
	        MemtoReg => s_MemtoReg,
	        ALU_Code => s_ALUCode,
	        MemWrite => s_MemWrite,
	        ALUSrc   => s_ALUSrc,
 	        RegWrite   => s_RegWrite,
 	        SignExtend =>s_SignExtend,
 	        LoadUpperImmediate => s_LoadUpperImmediate,
 	        isLink             => s_isLink,
 	        dataType   =>   s_DataType,
 	        LoadUnsigned => s_LoadUnsigned,
 	        JorJAL       => s_JorJAL,
 	         JRegister  =>   s_JRegister,
 	         Bgtz_blez  => s_Bgtz_blez,
 	         BranchType => s_BranchType,
 	         isLinkALU  => s_isLinkALU,
 	         isImmALU   => s_isImmALU 
 	        );
 	        
 process
  begin
    --Jump instruction
    s_OpCode <= "000010";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
   -- Jump and Link instruction
    s_OpCode <= "000011";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    --Jump Register
     s_OpCode <= "000000";
    s_functCode <= "001000";
    s_rtAddr <= "00000";
    wait for 100 ns;
   -- Jump and Link Register 
    s_OpCode <= "000000";
    s_functCode <= "001001";
    s_rtAddr <= "00000";
    wait for 100 ns;
    -- Add instruction
     s_OpCode <= "000000";
    s_functCode <= "100000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    ---- Add unsigned instruction
    s_OpCode <= "000000";
    s_functCode <= "100001";
    s_rtAddr <= "00000";
    wait for 100 ns;
     -- Subtract instruction
     s_OpCode <= "000000";
    s_functCode <= "100010";
    s_rtAddr <= "00000";
    wait for 100 ns;
     -- Subtract unsigned instruction
     s_OpCode <= "000000";
    s_functCode <= "100011";
    s_rtAddr <= "00000";
    wait for 100 ns;
  -- Or instruction
     s_OpCode <= "000000";
    s_functCode <= "100101";
    s_rtAddr <= "00000";
    wait for 100 ns;
     -- Or instruction
     s_OpCode <= "000000";
    s_functCode <= "100100";
    s_rtAddr <= "00000";
    wait for 100 ns;
      -- Or immediate instruction
     s_OpCode <= "000000";
    s_functCode <= "100101";
    s_rtAddr <= "00000";
    wait for 100 ns;
     --And instruction
     s_OpCode <= "000000";
    s_functCode <= "100100";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
    --Xor instruction
    s_OpCode <= "000000";
    s_functCode <= "100110";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
    --Nor instruction
    
    s_OpCode <= "000000";
    s_functCode <= "100111";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
    --Slt instruction
     s_OpCode <= "000000";
    s_functCode <= "101010";
    s_rtAddr <= "00000";
    wait for 100 ns;
    --Sltu instruction
    s_OpCode <= "000000";
    s_functCode <= "101011";
    s_rtAddr <= "00000";
    wait for 100 ns;
    --Sll instruction
    s_OpCode <= "000000";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    --Srl instruction
    s_OpCode <= "000000";
    s_functCode <= "000010";
    s_rtAddr <= "00000";
    wait for 100 ns;
      --Sra instruction
    s_OpCode <= "000000";
    s_functCode <= "000011";
    s_rtAddr <= "00000";
    wait for 100 ns;
      --Sllv instruction
    s_OpCode <= "000000";
    s_functCode <= "000100";
    s_rtAddr <= "00000";
     wait for 100 ns;
     
     --Srlv instruction
    s_OpCode <= "000000";
    s_functCode <= "000110";
    s_rtAddr <= "00000";
     wait for 100 ns;
     
      --Srav instruction
    s_OpCode <= "000000";
    s_functCode <= "000111";
    s_rtAddr <= "00000";
     wait for 100 ns;  
    
     --Bltz instruction
    s_OpCode <= "000001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
     wait for 100 ns;  
     
       --Bgez instruction
    s_OpCode <= "000001";
    s_functCode <= "000000";
    s_rtAddr <= "00001";
     wait for 100 ns;  
     
         --Bgezal instruction
    s_OpCode <= "000001";
    s_functCode <= "000000";
    s_rtAddr <= "10001";
     wait for 100 ns;  
     
           --Bltzal instruction
    s_OpCode <= "000001";
    s_functCode <= "000000";
    s_rtAddr <= "10000";
     wait for 100 ns; 
     
     --Beq instruction
    s_OpCode <= "000100";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
   
       --Bne instruction
    s_OpCode <= "000101";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
   
     --Blez instruction
    s_OpCode <= "000110";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;  
     
      --Bgtz instruction
    s_OpCode <= "000111";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;  
    
    --confused about Mul instruction
      --Addi instruction
    s_OpCode <= "001000";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;  
    
      --Addiu instruction
    s_OpCode <= "001001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
    --Ori instruction
    s_OpCode <= "001101";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;   
    
    --Andi instruction
    s_OpCode <= "001100";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;   
      
    --Xori instruction
    s_OpCode <= "001110";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;   
       
    --Slti instruction
    s_OpCode <= "001010";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;   
    
      --Sltiu instruction
    s_OpCode <= "001011";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;   
    
   --lb instruction
    s_OpCode <= "100000";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns; 
     
     --lbu instruction
    s_OpCode <= "100100";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;  
    
     --lh instruction
    s_OpCode <= "100001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;    
    
     --lhu instruction
    s_OpCode <= "100101";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;  
    
      --lw instruction
    s_OpCode <= "100011";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns; 
    
       --lui instruction
    s_OpCode <= "001111";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
    --sb instruction
      s_OpCode <= "101000";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
  --sh instruction
      s_OpCode <= "101001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    
   --sh instruction
      s_OpCode <= "101001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
     --sw instruction
    s_OpCode <= "101001";
    s_functCode <= "000000";
    s_rtAddr <= "00000";
    wait for 100 ns;
    wait;
 end process;
 	        
end behavior;