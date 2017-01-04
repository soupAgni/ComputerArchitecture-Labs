-------------------------------------------------------------------------
-- Fahmida Joyti
--tb_IDstage
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity tb_IDStage is
  generic(gCLK_Hper : time := 50 ns);
end tb_IDStage;

architecture behavior of tb_IDStage is 

component ID_stage is
  generic(N : integer := 32);
  port(CLK              : in std_logic;
       IDEX_reset       : in std_logic;
       Regfile_reset    : in std_logic;
       IDEX_WE          : in std_logic;
       IDEX_Flush       : in std_logic;
       IFID_AdderVal    : in std_logic_vector(31 downto 0) ;
       IFID_instMem     : in std_logic_vector(31 downto 0);
       MEMWB_instMem    : in std_logic_vector(31 downto 0); 
       MEMWB_upperImmVal: in std_logic_vector(31 downto 0);
       ValtoReg_File    : in std_logic_vector(31 downto 0);
       MemWB_PCPlus4    : in std_logic_vector(31 downto 0);
       MEMWB_ALUWrite   : in std_logic;
       MEMWB_isLinkALU  : in std_logic;
       MEMWB_RegDest    : in std_logic;
       MEMWB_IsLink     : in std_logic;
       MemWB_upperImm   : in std_logic;
       MemWB_RegW_en    : in std_logic;
       forwardA_Branch  : in std_logic_vector(2 downto 0);
       forwardB_Branch  : in std_logic_vector(2 downto 0);
       ExMem_ALU        : in std_logic_vector(31 downto 0); --- gjfjgsghdz
       IDEX_ALUval      : in std_logic_vector(31 downto 0); ---
       EXMEM_PCplus4    : in std_logic_vector(31 downto 0);
       EXMEM_UpperImm   : in std_logic_vector(31 downto 0); 
       IDEX_UpperImm    : in std_logic_vector(31 downto 0); ---
       out_ID_rs_output : out std_logic_vector(31 downto 0);  -- new
       o_IFID_instMem   : out std_logic_vector(31 downto 0);
       o_branchAnd      : out std_logic;
		   o_operation      : out std_logic_vector(2 downto 0);
       o_ALUsel         : out std_logic_vector(1 downto 0);
       o_issv           : out std_logic;
       o_isJumpReg      : out std_logic;
       o_isLinkALU      : out std_logic;
       o_ALU_write      : out std_logic;
       o_isUnsignedALU  : out std_logic;
       o_IsImmALU       : out std_logic; 
       o_reg_w_enANDAlu_write : out std_logic; 
		   --o_IsRtype        : out std_logic;   -- dont need this anymore
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		 --  o_instMem        : out std_logic_vector(31 downto 0);
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_branch_jump_mux: out std_logic_vector(31 downto 0);
		   o_muxORval       : out std_logic;   ---  feeding as an output from ID stage and input to IF stage
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)
      );
		 end component;
      
      signal s_Clk, s_IDEX_reset, s_Regfile_reset, s_IDEX_WE, s_IDEX_Flush,s_MEMWB_ALUWrite,s_MEMWB_isLinkALU,s_MEMWB_RegDest, s_MEMWB_IsLink, s_MemWB_upperImm, s_MemWB_RegW_en  :std_logic;
      signal  s_IFID_AdderVal, s_IFID_instMem,s_MEMWB_instMem,s_MEMWB_upperImmVal, s_ValtoReg_File , s_MemWB_PCPlus4,s_ExMem_ALU,s_IDEX_ALUval,s_EXMEM_UpperImm,  s_IDEX_UpperImm,s_EXMEM_PCplus4   : std_logic_vector(31 downto 0);
      signal s_o_IFID_instMem,s_o_branch_jump_mux, s_o_RegData1,s_o_RegData2,s_o_ImmSignExt,s_o_PCplus4,s_o_upperImmVal,s_o_branchALU : std_logic_vector(31 downto 0);
      signal s_o_branchAnd ,s_o_issv,s_o_isJumpReg,s_o_isLinkALU,  s_o_ALU_write, s_o_isUnsignedALU, s_o_IsImmALU,s_o_IsRtype,s_o_RegDst,s_o_isLoadU,s_o_instMem, s_o_Reg_w_en,s_o_UpperImm,s_o_isLink,s_o_dmem_w_en,s_o_isLoad ,s_o_muxORval :std_logic;
      signal s_o_operation,s_forwardA_Branch, s_forwardB_Branch   : std_logic_vector (2 downto 0);
      signal s_o_ALUsel,s_o_TypeSel : std_logic_vector(1 downto 0);
      signal s_o_ALU_OP  : std_logic_vector(5 downto 0);
      
      begin
  
    DUT: ID_stage
   port map(
    CLK  => s_Clk,  
    IDEX_reset   => s_IDEX_reset ,
    Regfile_reset => s_Regfile_reset ,
    IDEX_WE   => s_IDEX_WE ,
    IDEX_Flush => s_IDEX_Flush,
    IFID_AdderVal => s_IFID_AdderVal,
    IFID_instMem      => s_IFID_instMem,
    MEMWB_instMem =>s_MEMWB_instMem,
    MEMWB_upperImmVal  => s_MEMWB_upperImmVal,
    ValtoReg_File  => s_ValtoReg_File,
    MemWB_PCPlus4  => s_MemWB_PCPlus4,
    MEMWB_ALUWrite  => s_MEMWB_ALUWrite,
    MEMWB_isLinkALU => s_MEMWB_isLinkALU,
    MEMWB_RegDest  => s_MEMWB_RegDest,
    MEMWB_IsLink  => s_MEMWB_IsLink,
    MemWB_upperImm  =>  s_MemWB_upperImm,
    MemWB_RegW_en   => s_MemWB_RegW_en,
    forwardA_Branch  => s_forwardA_Branch,
    forwardB_Branch  => s_forwardB_Branch,
    ExMem_ALU        => s_ExMem_ALU,
    IDEX_ALUval  => s_IDEX_ALUval,
    EXMEM_PCplus4  => s_EXMEM_PCplus4,
    EXMEM_UpperImm  => s_EXMEM_UpperImm,
    IDEX_UpperImm   => s_IDEX_UpperImm,
    o_IFID_instMem  => s_o_IFID_instMem,
    o_branchAnd     => s_o_branchAnd,
		o_operation     => s_o_operation,
    o_ALUsel        =>  s_o_ALUsel,
    o_issv          => s_o_issv,
    o_isJumpReg     => s_o_isJumpReg, 
    o_isLinkALU      => s_o_isLinkALU,
    o_ALU_write      => s_o_ALU_write,
    o_isUnsignedALU  => s_o_isUnsignedALU,
    o_IsImmALU     => s_o_IsImmALU,
		 o_RegDst       => s_o_RegDst,
		 o_isLoadU      => s_o_isLoadU,
		 o_Reg_w_en      => s_o_Reg_w_en,
		   o_UpperImm   => s_o_UpperImm,
		   o_isLink        => s_o_isLink,
		   o_dmem_w_en      => s_o_dmem_w_en,
		   o_isLoad         => s_o_isLoadU,
		   o_branch_jump_mux => s_o_branch_jump_mux,
		   o_muxORval      => s_o_muxORval,
		   o_TypeSel        => s_o_TypeSel,
		   o_ALU_OP	        => s_o_ALU_OP ,
		   o_RegData1       => s_o_RegData1,
		   o_RegData2       => s_o_RegData2,
		   o_ImmSignExt     => s_o_ImmSignExt,
		   o_PCplus4        => s_o_PCplus4,
		   o_upperImmVal  => s_o_upperImmVal,
		   o_branchALU      => s_o_branchALU 
    
     );
     
     
     P_CLK: process
  begin
    s_Clk <= '0';
    wait for gCLK_HPER;
    s_Clk <= '1';
    wait for gCLK_HPER;
  end process;
  
  TB: process
  begin
---  reset is 1 
  s_IDEX_reset <= '1';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '1';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
s_ExMem_ALU    <= x"FFFFF0F0";
s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;
    
  

---  Register file reset is set to 1
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '1';
	s_IDEX_WE <= '1';
	s_IDEX_Flush <= '0';
  s_IFID_AdderVal <= x"B00B1EE5";
  s_IFID_instMem 	 <= x"200D0007";
  s_MEMWB_instMem 	 <= x"F5DAEFBF";
  s_MEMWB_upperImmVal <= x"10010000";
  s_ValtoReg_File <= x"ABBAABBA"; 
  s_MemWB_PCPlus4  <= x"FFFFFFF0";
  s_ExMem_ALU   <= x"FFFFF0F0";
s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
  s_MEMWB_ALUWrite <= '1';
  s_MEMWB_isLinkALU <= '1';
  s_MEMWB_RegDest    <= '1';
  s_MEMWB_IsLink   <= '1';
  s_MemWB_upperImm   <= '1';
  s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;
    

---  Write enable for IDEX stage is zero
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
  s_IFID_AdderVal <= x"B00B1EE5";
  s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
  s_MEMWB_instMem 	 <= x"F5DAEFBF";
  s_MEMWB_upperImmVal <= x"10010000";
  s_ValtoReg_File <= x"ABBAABBA"; 
  s_MemWB_PCPlus4  <= x"FFFFFFF0";
  s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
  s_MEMWB_ALUWrite <= '1';
  s_MEMWB_isLinkALU <= '1';
  s_MEMWB_RegDest    <= '1';
  s_MEMWB_IsLink   <= '1';
  s_MemWB_upperImm   <= '1';
  s_MemWB_RegW_en    <= '1';
 s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;
    
  ---  IDEX Flush is set to 1
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '1';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;
  
---  Alu Write is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";

 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";

s_MEMWB_ALUWrite <= '0';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  

  ---  Alu Write is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '0';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  

---  RegDest is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '0';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  
  
---  MemWB_isLink is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '0';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  
    
    
---  MemWB_upperImm is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '0';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  
    
 ---  MemWB_RegW_en is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '0';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;  

--- forwardA_Branch is set to 0
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER;
  
 --- forwardB_Branch is set to 1
  s_IDEX_reset <= '0';
  s_Regfile_reset	 <= '0';
	s_IDEX_WE <= '0';
	s_IDEX_Flush <= '0';
s_IFID_AdderVal <= x"B00B1EE5";
s_IFID_instMem 	 <= x"200D0007";--addi $13,0,$7
s_MEMWB_instMem 	 <= x"F5DAEFBF";
s_MEMWB_upperImmVal <= x"10010000";
s_ValtoReg_File <= x"ABBAABBA"; 
s_MemWB_PCPlus4  <= x"FFFFFFF0";
 s_IDEX_ALUval <= x"ABFFF0F0";
s_EXMEM_PCplus4 <= x"0040003c";
 s_EXMEM_UpperImm <= x"10010000";
s_IDEX_UpperImm <= x"10010000";
s_MEMWB_ALUWrite <= '1';
s_MEMWB_isLinkALU <= '1';
 s_MEMWB_RegDest    <= '1';
s_MEMWB_IsLink   <= '1';
s_MemWB_upperImm   <= '1';
s_MemWB_RegW_en    <= '1';
s_forwardA_Branch  <= "000";
s_forwardB_Branch <= "000";
  wait for gCLK_HPER; 
  
  
  end process;
  
  
       

end behavior;

