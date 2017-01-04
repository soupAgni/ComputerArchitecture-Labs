-------------------------------------------------------------------------
-- Souparni Agnihotri
-- Fall 2016
-- handling all RAW to forward those values
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity forwardingUnit is

   port(
         IFID_imem    : in std_logic_vector(31 downto 0);
         IDEX_imem    : in std_logic_vector(31 downto 0);
         EXMEM_imem   : in std_logic_vector(31 downto 0);
         MEMWB_imem   : in std_logic_vector(31 downto 0);
         
         MEMWB_reg_w_en : in std_logic;
         EXMEM_reg_w_en : in std_logic;
         IDEX_reg_w_en  : in std_logic;

         MEMWB_RegDest  : in std_logic;
         EXMEM_RegDest  : in std_logic;
         IDEX_RegDest   : in std_logic;
         
         MEMWB_isLink   : in std_logic;
         MEMWB_islInkALU : in std_logic;
         EXMEM_isLinkALU : in std_logic;
         EXMEM_isLink    : in std_logic;
         
         MEMWB_UpperImm  : in std_logic;
         EXMEM_UpperImm  : in std_logic;
         IDEX_UpperImm  : in std_logic;
         
         MEMWB_isLoad    : in std_logic;

         forwardA_ALU   :  out std_logic_vector(2 downto 0);
         forwardB_ALU   :  out std_logic_vector(2 downto 0);

         forwardA_branch   :  out std_logic_vector(2 downto 0);
         forwardB_branch   :  out std_logic_vector(2 downto 0));

end forwardingUnit;

architecture dataflow of forwardingUnit is

---signals ---

signal s_IFID_rs, s_IFID_rt, s_IFID_rd, s_IDEX_rs, s_IDEX_rt, s_IDEX_rd, s_EXMEM_rs, s_EXMEM_rt, s_EXMEM_rd, s_MEMWB_rs, s_MEMWB_rt, s_MEMWB_rd  : std_logic_vector(4 downto 0);
signal s_MEMWB_RegDest, s_MEMWB_reg_w_en, s_MEMWB_isLink, s_EXMEM_reg_w_en, s_EXMEM_RegDest, s_isLoad, s_EXMEM_lui, s_MEMWB_lui, s_MEMWB_isLinkALU, s_IDEX_reg_w_en, s_IDEX_RegDest, s_IDEX_lui, s_EXMEM_isLinkALU, s_EXMEM_isLink: std_logic;

begin

s_IDEX_rs   <=  IDEX_imem(25 downto 21);
s_IDEX_rt   <=  IDEX_imem(20 downto 16);
s_IDEX_rd   <=  IDEX_imem(15 downto 11);

s_IFID_rs   <=  IFID_imem(25 downto 21);
s_IFID_rt   <=  IFID_imem(20 downto 16);
s_IFID_rd   <=  IFID_imem(15 downto 11);

s_EXMEM_rs   <=  EXMEM_imem(25 downto 21);
s_EXMEM_rt   <=  EXMEM_imem(20 downto 16);
s_EXMEM_rd   <=  EXMEM_imem(15 downto 11);

s_MEMWB_rs   <=  MEMWB_imem(25 downto 21);
s_MEMWB_rt   <=  MEMWB_imem(20 downto 16);
s_MEMWB_rd   <=  MEMWB_imem(15 downto 11);

s_MEMWB_reg_w_en <= MEMWB_reg_w_en;
s_EXMEM_reg_w_en <= EXMEM_reg_w_en;
s_EXMEM_RegDest <= EXMEM_RegDest;
s_MEMWB_RegDest <= MEMWB_RegDest;
s_MEMWB_isLink <= MEMWB_isLink;
s_MEMWB_isLinkALU <= MEMWB_isLinkALU;
s_isLoad <= MEMWB_isLoad;
s_EXMEM_lui  <= EXMEM_UpperImm;
s_MEMWB_lui  <= MEMWB_UpperImm;
s_IDEX_reg_w_en  <= IDEX_reg_w_en; 
 s_IDEX_RegDest  <=  IDEX_RegDest;
 s_IDEX_lui  <= IDEX_UpperImm;
 
 s_EXMEM_isLinkALU <= EXMEM_isLinkALU;
s_EXMEM_isLink <= EXMEM_isLink;


process(s_EXMEM_reg_w_en,s_EXMEM_RegDest, s_MEMWB_RegDest, s_MEMWB_reg_w_en, s_MEMWB_rd, s_MEMWB_rt,s_MEMWB_isLink,s_MEMWB_isLinkALU, s_IDEX_rs, s_EXMEM_rd, s_EXMEM_rt, s_isLoad, s_EXMEM_lui, s_MEMWB_lui )

begin

   --Reg values = 00
   -- EXMEM aluval = 01
   -- MEMWB val = 10

   ---Default:
    
   forwardA_ALU    <= "000";
        
   -- add $1, $2, $3
   -- add $4, $1, $5
   -- RAW hazard and need to forward EXMEM Aluvalue

    if(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rd = s_IDEX_rs) and (not(s_EXMEM_rd = "00000") and s_isLoad = '0')) then --check if we really nead isLoad here
                      
                forwardA_ALU <= "001";
                
   -- addi $1, $2, 3
   -- add $4, $1, $5
   -- RAW hazard 

    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rt = s_IDEX_rs) and (not(s_EXMEM_rt = "00000") and s_isLoad = '0')) then 
                      
                forwardA_ALU <= "001";
                
                
    --- isUpperImm from EXMEM
               
    elsif(s_EXMEM_lui = '1' and s_MEMWB_reg_w_en = '1' and (s_IDEX_rs = s_EXMEM_rd)) then 
    
               forwardA_ALU <= "100";
               
    -- add $1, $2, $3
    -- nop
    -- add $4, $1, $5 
    -- RAW
    elsif(s_MEMWB_reg_w_en = '1' and s_MEMWB_RegDest = '0' and (s_MEMWB_rd = s_IDEX_rs) and (not(s_MEMWB_rd = "00000")) and s_isLoad = '1') then 
            
               forwardA_ALU <= "010";

    -- addi $1, $2, 3  -- so we have $1 writing to the rt register since its addi
    -- nop
    -- add $4, $1. $5 
    -- RAW

    elsif(s_MEMWB_reg_w_en = '1' and s_MEMWB_RegDest = '0' and (s_MEMWB_rt = s_IDEX_rs) and (not(s_MEMWB_rt = "00000")) and s_isLoad = '1') then 
            
               forwardA_ALU <= "010";

   -- If it is a jr instruction then forward the MEMWB register value 

    elsif((s_MEMWB_isLink = '1' or s_MEMWB_isLinkALU = '1') and s_MEMWB_reg_w_en = '1' and (s_IDEX_rs = s_MEMWB_rd) and s_isLoad = '1') then 
             
               forwardA_ALU <= "011";  ---forward pcp4
               
    --- isUpperImmm from MEMWB
               
    elsif(s_MEMWB_lui = '1' and s_MEMWB_reg_w_en = '1' and (s_IDEX_rs = s_MEMWB_rd) and s_isLoad = '1') then 
    
               forwardA_ALU <= "101";
               

end if;

end process;

process(s_EXMEM_RegDest, s_MEMWB_RegDest, s_MEMWB_reg_w_en, s_MEMWB_rd, s_MEMWB_rt, s_IDEX_rt, s_EXMEM_reg_w_en, s_MEMWB_isLink,s_MEMWB_isLinkALU, s_EXMEM_rd, s_EXMEM_rt, s_EXMEM_lui, s_MEMWB_lui)

begin 
  
   forwardB_ALU    <= "000";
  -- for the second mux (dealing with rt. Everything else remains the same)
  
               
    -- add $1, $2, $3
    -- add $4, $5, $1
    -- RAW

    if(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rd = s_IDEX_rt) and (not(s_EXMEM_rd = "00000")) and s_isLoad = '0') then 
                      
                forwardB_ALU <= "001";
                
    -- addi $1, $2, 3
    -- add  $4, $5, $1

    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rt = s_IDEX_rt) and (not(s_EXMEM_rt = "00000")) and s_isLoad = '0') then 
                      
                forwardB_ALU <= "001";
                
    --- isUpperImm from EXMEM
               
    elsif(s_EXMEM_lui = '1' and s_MEMWB_reg_w_en = '1' and (s_IDEX_rs = s_EXMEM_rt)) then 
    
               forwardB_ALU <= "100";
 -- add $1, $2, $3
    -- nop
    -- add $4, $5. $1 
    -- RAW with rt

    elsif(s_MEMWB_reg_w_en = '1' and s_MEMWB_RegDest = '0' and (s_MEMWB_rd = s_IDEX_rt) and (not(s_MEMWB_rd = "00000")) and s_isLoad = '1') then 
              
               forwardB_ALU <= "010";
               
    -- addi $1, $2, 3
    -- nop
    -- add $4, $5. $1 
    -- RAW with rt for $1

    elsif(s_MEMWB_reg_w_en = '1' and s_MEMWB_RegDest = '0' and (s_MEMWB_rt = s_IDEX_rt) and (not(s_MEMWB_rt = "00000")) and s_isLoad = '1') then 
            
               forwardB_ALU <= "010";
               
    --Same thing for jr as shown above but with reg rt also has 2 nops

    elsif((s_MEMWB_isLink = '1' or s_MEMWB_isLinkALU = '1') and s_MEMWB_reg_w_en = '1' and s_IDEX_rt = s_MEMWB_rt) then 
             
               forwardB_ALU <= "011";
               
     --- isUpperImm from MEMWB
               
    elsif(s_MEMWB_lui = '1' and s_MEMWB_reg_w_en = '1' and (s_IDEX_rs = s_MEMWB_rt) and s_isLoad = '1') then 
    
               forwardB_ALU <= "101";
end if;

end process;

----for branches:

process(s_IDEX_reg_w_en, s_IDEX_RegDest, s_IDEX_rd, s_IFID_rs, s_IDEX_rt) 
  
  begin
    
    forwardA_Branch    <= "000";
        
   -- add $1, $2, $3
   -- add $4, $1, $5
   -- RAW hazard and need to forward EXMEM Aluvalue

    if(s_IDEX_reg_w_en = '1' and s_IDEX_RegDest = '0' and (s_IDEX_rd = s_IFID_rs) and (not(s_IDEX_rd = "00000") and s_isLoad = '0')) then --check if we really nead isLoad here
                      
                forwardA_Branch <= "001";
                
   -- addi $1, $2, 3
   -- add $4, $1, $5
   -- RAW hazard 

    elsif(s_IDEX_reg_w_en = '1' and s_IDEX_RegDest = '0' and (s_IDEX_rt = s_IFID_rs) and (not(s_IDEX_rt = "00000") and s_isLoad = '0')) then 
                      
                forwardA_Branch <= "001";
                
                
    --- isUpperImm from EXMEM
               
    elsif(s_IDEX_lui = '1' and s_EXMEM_reg_w_en = '1' and (s_IFID_rs = s_IDEX_rd)) then 
    
               forwardA_Branch <= "100";
               
    -- add $1, $2, $3
    -- nop
    -- add $4, $1, $5 
    -- RAW
    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rd = s_IFID_rs) and (not(s_EXMEM_rd = "00000")) and s_isLoad = '1') then 
            
               forwardA_Branch <= "010";

    -- addi $1, $2, 3  -- so we have $1 writing to the rt register since its addi
    -- nop
    -- add $4, $1. $5 
    -- RAW

    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rt = s_IFID_rs) and (not(s_EXMEM_rt = "00000")) and s_isLoad = '1') then 
            
               forwardA_Branch <= "010";

   -- If it is a jr instruction then forward the MEMWB register value 

    elsif((s_EXMEM_isLink = '1' or s_EXMEM_isLinkALU = '1') and s_EXMEM_reg_w_en = '1' and (s_IFID_rs = s_EXMEM_rd) and s_isLoad = '1') then 
             
               forwardA_Branch <= "011";  ---forward pcp4
               
    --- isUpperImmm from MEMWB
               
    elsif(s_EXMEM_lui = '1' and s_EXMEM_reg_w_en = '1' and (s_IFID_rs = s_EXMEM_rd) and s_isLoad = '1') then 
    
               forwardA_Branch <= "101";
               

end if;

end process;

process(s_IDEX_reg_w_en, s_IDEX_RegDest, s_IDEX_rd, s_IFID_rt)
  
  begin
    
   forwardB_Branch    <= "000";
  -- for the second mux (dealing with rt. Everything else remains the same)
  
               
    -- add $1, $2, $3
    -- add $4, $5, $1
    -- RAW

    if(s_IDEX_reg_w_en = '1' and s_IDEX_RegDest = '0' and (s_IDEX_rd = s_IFID_rt) and (not(s_IDEX_rd = "00000")) and s_isLoad = '0') then 
                      
                forwardB_Branch <= "001";
                
    -- addi $1, $2, 3
    -- add  $4, $5, $1

    elsif(s_IDEX_reg_w_en = '1' and s_IDEX_RegDest = '0' and (s_IDEX_rt = s_IFID_rt) and (not(s_IDEX_rt = "00000")) and s_isLoad = '0') then 
                      
                forwardB_Branch <= "001";
                
    --- isUpperImm from EXMEM
               
    elsif(s_IDEX_lui = '1' and s_EXMEM_reg_w_en = '1' and (s_IFID_rs = s_EXMEM_rt)) then 
    
               forwardB_Branch <= "100";
 -- add $1, $2, $3
    -- nop
    -- add $4, $5. $1 
    -- RAW with rt

    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rd = s_IFID_rt) and (not(s_EXMEM_rd = "00000")) and s_isLoad = '1') then 
              
               forwardB_Branch <= "010";
               
    -- addi $1, $2, 3
    -- nop
    -- add $4, $5. $1 
    -- RAW with rt for $1

    elsif(s_EXMEM_reg_w_en = '1' and s_EXMEM_RegDest = '0' and (s_EXMEM_rt = s_IDEX_rt) and (not(s_EXMEM_rt = "00000")) and s_isLoad = '1') then 
            
               forwardB_Branch <= "010";
               
    --Same thing for jr as shown above but with reg rt also has 2 nops

    elsif((s_EXMEM_isLink = '1' or s_EXMEM_isLinkALU = '1') and s_EXMEM_reg_w_en = '1' and s_IFID_rt = s_EXMEM_rt) then 
             
               forwardB_Branch <= "011";
               
     --- isUpperImm from MEMWB
               
    elsif(s_EXMEM_lui = '1' and s_EXMEM_reg_w_en = '1' and (s_IFID_rs = s_EXMEM_rt) and s_isLoad = '1') then 
    
               forwardB_Branch <= "101";
end if;

end process;
end dataflow;