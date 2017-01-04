--- Control Unit

--Souparni Agnihotri--


use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity Control_Unit is
  
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
      isImmALU    :out std_logic;
       BorJ       : out std_logic
        );
       
end Control_Unit;

architecture dataflow of Control_Unit is
   
   signal s_OpCode : std_logic_vector(5 downto 0);
   
   signal s_out   : std_logic_vector(26 downto 0);
   
   signal s_funct : std_logic_vector(5 downto 0);
   
   signal s_rt : std_logic_vector(4 downto 0);
   
begin

  s_OpCode  <= OpCode;
  
  s_funct   <= funct;
  
  s_rt <= rt;
  
  my_proc  : process(s_OpCode)
  
  begin
  
       case (s_OpCode) is
       
       when  "000010"  =>  s_out <= "101000000000000000000000000" ; --J
         
       when  "000011"  => s_out  <= "101000000000100100010000000";  --Jal
         
       when  "000000"  => 
             
             case(s_funct) is
       
                    when "001000" => s_out  <= "101000000000000000001000000"; --Jr 
  
                    when "001001"  => s_out <= "101000000000100000000000000";  --Jalr 
                      
                    when "100000"  => s_out <= "010000000000100000000000000"; --add
                      
                    when "100001"  => s_out <= "010000000000100000000000000"; --addu
                      
                    when "100010"  => s_out <= "010000000100100000000000000"; --sub
                      
                    when "100011" =>  s_out <= "010000000100100000000000000"; --subu
                      
                    when "100101" => s_out <= "010000001100100000000000000"; --or
                      
                    when "100100" => s_out <= "010000011000100000000000000";  --and
                      
                    when "100110" => s_out <= "010000010000100000000000000"; --xor
                      
                    when "100111" => s_out <= "010000010100100000000000000";  --nor
                      
                    when "101010" => s_out <= "010000001010100000000000000";  --slt
                      
                    when "101011" => s_out <= "010000011110100000000000000";  ---sltu
                      
                    when "000000" => s_out <= "010000100100100000000000001";  --sll
                      
                    when "000010" => s_out <= "010000101000100000000000000"; --srl
                      
                    when "000011" => s_out <= "010000110000100000000000000"; --sra
                      
                    when "000100" => s_out <= "010000100100100000000000000"; --sllv
                      
                    when "000110" => s_out <= "010000101000100000000000000"; --srlv
                      
                    when "000111" => s_out <= "010000110000100000000000000"; --srav
                      
                      ----add others and end case
                      
                    when others  => s_out <=  "000000000000000000000000000";  ---??
                      
                  end case;  
                      

       when  "000001"  =>
       
             case(s_rt ) is    
       
                    when "00000" => s_out <= "100100001001000000000011001"; --bltz      
                    
                    when "00001" => s_out <= "100100001001000000000000101"; --bgez    
                    
                    when "10001" => s_out <= "100100000001000100000001011"; --bgezal
                    
                    when "10000" => s_out <= "100100000101000100000010111"; --bltzal  
                      
                    when others  => s_out <=  "100000000000000000000000000";  ---?? Don't do anything pretty much
                      
                      
                end case;
                      
                    ---add others and end case
                      
       when  "000100"  => s_out <= "100100000101000000000000001"; --beq 
       
       when  "000101"  => s_out <= "100100000101000000000011101"; --bne 
       
       when  "000110"  => s_out <= "100100000001000000000110001"; --blez
       
       when  "000111"  => s_out <= "100100000001000000000001101"; --bgtz             
         
       when  "011100"  => s_out <= "010000111100100000000000000";  --MUl  && also has a function code
  
       when  "001000"  => s_out <= "000010000001101000000011001";  ---addi
         
       when  "001001" => s_out <=  "000010000001101000000000001";  --addiu
         
       when  "001101"  => s_out <= "000010001101101000000000001";  --ori
         
       when  "001100"  => s_out <= "000010011001101000000000001";  --andi
         
       when  "001110"  => s_out <= "000010010001101000000000001"; --xori
         
       when  "001010"  => s_out <= "000010001011101000000000001"; --slti
         
       when  "001011"  => s_out <= "000010011111101000000000001"; --sltiu
         
         
       when  "100000"  => s_out <= "000011000001100000000000001"; --lb
         
       when  "100100"  => s_out <= "000011000001100000100000001"; --lbu
         
       when  "100001"  => s_out <= "000011000001110001000000001"; --lh
         
       when  "100101"  => s_out <= "000011000001100001100000001"; --lhu
         
       when  "100011"  => s_out <= "000011000001100010000000001"; --lw
         
       when  "001111"  => s_out <= "000011000001101010000000011"; --lui
    
         
       when  "101000"  => s_out <= "000000000011000000000000001"; --sb  
         
       when  "101001"  => s_out <= "000000000011000001000000001"; --sh 
         
       when  "101011"  => s_out <= "000000000011000010000000001"; --sw  
         
       when others  => s_out <=  "000000000000000000000000000";  ---?? Dont do anything   
         
         
      end case;
     
  end process my_proc;
  
  BorJ <= s_out(26);
   isLinkALU <= s_out(13);
   isImmALU   <= s_out(12);
  BranchType <= s_out(11 downto 9);
  Bgtz_blez  <= s_out(8);
 JRegister  <= s_out(7);
 JorJAL     <= s_out(6);
  LoadUnsigned <= s_out(5);
  dataType  <= s_out(4 downto 3);
  isLink   <= s_out(2);
  LoadUpperImmediate <= s_out(1);
  signExtend  <=  s_out(0);
  regDest <= s_out(25);
  Jump <= s_out(24);
  Branch <= s_out(23);
  MemRead <= s_out(22);
  MemtoReg <= s_out(21);
  ALU_Code <= s_out(20 downto 17); -- ?? 6 to 3 ASK
  MemWrite <= s_out(16);
  ALUSrc   <= s_out(15);
  RegWrite  <=s_out(14);
  
         
end dataflow;          
 
        
        
        
             
  