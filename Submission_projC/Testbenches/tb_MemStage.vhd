-------------------------------------------------------------------------
-- Fahmida Joyti
--tb_MemStage
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity tb_MemStage is
  generic(gCLK_Hper : time := 50 ns);
end tb_MemStage;

architecture behavior of tb_MemStage is 

component MEM_stage is
  generic(N : integer := 32;
          dmem_mif_filename : string := "mem.mif");
	port(
		Clk             : in std_logic;
		MEMWB_Reg_Reset : in std_logic; 
		WE              : in std_logic;
		RegDst          : in std_logic; 
		reg_w_en        : in std_logic;
		dmem_w_en       : in std_logic;
		upperImm        : in std_logic;
		isLink          : in std_logic;
		isLoad          : in std_logic;
		isLoadU         : in std_logic;
		isLinkALU        : in std_logic;
		ALUwrite        : in std_logic;
		isJumpReg       : in std_logic;
		TypeSel         : in std_logic_vector(1 downto 0);
		EXMEM_ALU       : in std_logic_vector(31 downto 0);
		EXMEM_Rt        : in std_logic_vector(31 downto 0);
		MEMWB_PCp4      : in std_logic_vector(31 downto 0);
		IDEX_imem       : in std_logic_vector(31 downto 0);
		upperImmVal     : in std_logic_vector(31 downto 0);
		o_RegDst        : out std_logic;
		o_Reg_w_en      : out std_logic;
		o_ALUwrite      : out std_logic;
		o_isJumpReg     : out std_logic;
		o_isLink        : out std_logic;
		o_isLinkALU     : out std_logic;
		o_UpperImm      : out std_logic;
		o_ValToReg      : out std_logic_vector(31 downto 0);
		o_MEMWB_PCplus4 : out std_logic_vector(31 downto 0);
		o_instMem       : out std_logic_vector(31 downto 0);
		o_upperImmVal   : out std_logic_vector(31 downto 0));
		
end component;

 signal s_Clk, s_MEMWB_Reg_Reset,  s_WE,s_RegDst, s_reg_w_en,s_dmem_w_en, s_upperImm, s_isLink, s_isLoad, s_isLoadU, s_isLinkALU,s_ALUwrite, s_isJumpReg   :std_logic;
 
 signal s_TypeSel :std_logic_vector(1 downto 0);
 
 signal  s_EXMEM_ALU , s_EXMEM_Rt , s_MEMWB_PCp4 , s_IDEX_imem , s_upperImmVal : std_logic_vector(31 downto 0);
 
 signal s_o_RegDst, s_o_Reg_w_en , s_o_ALUwrite, s_o_isJumpReg , s_o_isLink , s_o_isLinkALU , s_o_UpperImm :std_logic;
 
 signal s_o_ValToReg , s_o_MEMWB_PCplus4, s_o_instMem, s_o_upperImmVal  : std_logic_vector(31 downto 0);
 
 
 begin
   
DUT: MEM_stage
   port map(
    CLK  => s_Clk,  
    MEMWB_Reg_Reset =>  s_MEMWB_Reg_Reset,
		WE             => s_WE,
		RegDst         => s_RegDst, 
		reg_w_en        => s_reg_w_en,
		dmem_w_en      => s_dmem_w_en,
		upperImm       => s_upperImm,
		isLink         => s_isLink,
		isLoad          => s_isLoad,
		isLoadU        => s_isLoadU, 
		isLinkALU      => s_isLinkALU,
		ALUwrite        => s_ALUwrite,
		isJumpReg       => s_isJumpReg,
		TypeSel         => s_TypeSel,
		EXMEM_ALU        => s_EXMEM_ALU,
		EXMEM_Rt        => s_EXMEM_Rt,
		MEMWB_PCp4      => s_MEMWB_PCp4,
		IDEX_imem       =>  s_IDEX_imem ,
		upperImmVal     => s_upperImmVal,
		o_RegDst        => s_o_RegDst,
		o_Reg_w_en      => s_o_Reg_w_en ,
		o_ALUwrite      => s_o_ALUwrite,
		o_isJumpReg     => s_o_isJumpReg,
		o_isLink        => s_o_isLink,
		o_isLinkALU     => s_o_isLinkALU ,
		o_UpperImm      => s_o_UpperImm,
		o_ValToReg     => s_o_ValToReg, 
		o_MEMWB_PCplus4 => s_o_MEMWB_PCplus4,
		o_instMem       => s_o_instMem,
		o_upperImmVal  => s_o_upperImmVal
    
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
  --Reset is set to 1  
    s_MEMWB_Reg_Reset  <= '1';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
      s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
  
  --Write Enable  is set to 0 
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '0';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
    s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
      s_IDEX_imem <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;
       
      --RegDest set is set to 0 
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '0';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
    s_IDEX_imem <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
      
       
      --Reg write enable is set to 0
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '0';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;
     
          
      --Data memory write enable is set to 0
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '0';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
    s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
   
      
     --When upper immediate is set to 0
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '0';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
      
    --When isLink is set to 0
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '0';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <=  x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
      
    --When isLoad is set to 0
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '0';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER; 
      
     --When isLoad Unisgned is set to 0  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '0';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
    
       
     --When isLinkALU  is set to 0  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '0';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
      
         
     -- ALUWrite is set to 0  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '0';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
      
    -- isJumpReg is set to 0  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "10";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
      s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
    
       -- Load a byte  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "00";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
     s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
    
      
       -- Load a half word  
    s_MEMWB_Reg_Reset  <= '0';
     s_WE <= '1';
     s_RegDst <= '1';
     s_reg_w_en <= '1';
     s_dmem_w_en  <= '1';
     s_upperImm  <= '1';
     s_isLink <= '1';
     s_isLoad <= '1';
     s_isLoadU <= '1';
     s_isLinkALU <= '1';
     s_ALUwrite <= '1';
     s_isJumpReg <= '1';
     s_TypeSel <= "01";
     s_EXMEM_ALU <= x"B00B1EE6";
     s_EXMEM_Rt <= x"A01B1DE7";
     s_MEMWB_PCp4 <= x"C01B1DE0";
      s_IDEX_imem  <= x"200D0007";--addi $13,0,$7
     s_upperImmVal <= x"10010000";
      wait for gCLK_HPER;  
         
     
    
  end process;

end behavior;