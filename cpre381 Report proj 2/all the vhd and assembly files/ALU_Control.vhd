--- ALU control unit

--Souparni Agnihotri--


--Souparni Agnihotri--


use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity ALU_Control is
  
port(sel        :  in std_logic_vector(3 downto 0);
     shift      :  in std_logic_vector(4 downto 0);
     c_in       :  out std_logic;
     B_inv      :  out std_logic;
     A_inv      :  out std_logic;
     ALU_op     :  out std_logic_vector(2 downto 0);
     shift_op   :  out std_logic_vector(1 downto 0);
     shift_Amt  :  out std_logic_vector(4 downto 0);
     Unit_sel   :  out std_logic_vector(1 downto 0);
     sltu       :  out std_logic
     );
   
     
     end ALU_Control;

architecture behaviour of ALU_Control is
  
  signal Alu_out  : std_logic_vector(15 downto 0);   ---We need more outputs to handle jump and branch I think
       

begin
  
  
  
  Alu_out <="0000010000000010" when sel = "0000"  else   --ADD
      
            "0110010000000010" when sel = "0001"  else   --SUB
      
            "0110011000000010" when sel = "0010"  else   --SLT
      
            "1110011000000010" when sel = "0111"  else   --SLTU
            
            "0000001000000010" when sel = "0011"  else   --OR
      
            "0000100000000010" when sel = "0100"  else   --XOR
  
            "0011000000000010" when sel = "0101"  else   --NOR
      
            "0000000000000010" when sel = "0110"  else   --AND
  
            "0000000000000001" when sel = "1111"  else   --MUL

            "0000000100000000" when sel = "1001"  else   --SLL
      
            "0000000000000000" when sel = "1010"  else   --SRL
     
            "0000000010000000" when sel = "1100"  else   --SRA
    
            "0000000000000001";
            
      sltu <= Alu_out(15);
      c_in  <= Alu_out(14);
      B_inv <= Alu_out(13);
      A_inv <= Alu_out(12);
      ALU_op <= Alu_out(11 downto 9);
      shift_op <= Alu_out(8 downto 7);
      shift_Amt <= shift;
      Unit_sel <= Alu_out(1 downto 0);

end behaviour;