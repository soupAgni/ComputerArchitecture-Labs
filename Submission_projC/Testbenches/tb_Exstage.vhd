-------------------------------------------------------------------------
-- Fahmida Joyti
--tb_ExStage
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity tb_ExStage is
  generic(gCLK_Hper : time := 50 ns);
end tb_ExStage;

architecture behavior of tb_ExStage is 

component EX_stage is
  generic(N : integer := 32);
	port(
		Clk             : in std_logic;
		EXMEM_Reg_Reset : in std_logic; 
		WE              : in std_logic;
		RegDst          : in std_logic; -- might need to change to vectors
		reg_w_en        : in std_logic;
		dmem_w_en       : in std_logic;
		upperImm        : in std_logic;
		isLink          : in std_logic;
		isLoad          : in std_logic;
		isLoadU         : in std_logic;
		isImmALU        : in std_logic;
		operation       : in std_logic_vector(2 downto 0);
    ALUsel          : in std_logic_vector(1 downto 0);
    issv            : in std_logic;
    isJumpReg       : in std_logic;
    isLinkALU       : in std_logic;
    ALU_write       : in std_logic;
    isUnsignedALU   : in std_logic;
		TypeSel         : in std_logic_vector(1 downto 0);
		forwardA_ALU    : in std_logic_vector(2 downto 0);
		forwardB_ALU    : in std_logic_vector(2 downto 0);
		IDEX_ALUop      : in std_logic_vector(5 downto 0);
		EXMEM_ALU       : in std_logic_vector(31 downto 0);
		MEMWB_memOut    : in std_logic_vector(31 downto 0);
		MEMWB_PCp4      : in std_logic_vector(31 downto 0);
		EXMEM_UpperImm  : in std_logic_vector(31 downto 0);
		MEMWB_UpperImm  : in std_logic_vector(31 downto 0);
		IDEX_Rs         : in std_logic_vector(31 downto 0);
		IDEX_Rt         : in std_logic_vector(31 downto 0);
		IDEX_mux12      : in std_logic_vector(31 downto 0);
		IDEX_imem       : in std_logic_vector(31 downto 0);
		IDEX_PCp4       : in std_logic_vector(31 downto 0);
		o_RegDst        : out std_logic;
		o_isLoad        : out std_logic;
		o_isLoadU       : out std_logic;
		o_Reg_w_en      : out std_logic;
		o_dmem_w_en     : out std_logic;
		o_ALUwrite      : out std_logic;
		o_isJumpReg     : out std_logic;
		o_isLink        : out std_logic;
		o_isLinkALU     : out std_logic;
		o_UpperImm      : out std_logic;
		o_TypeSel       : out std_logic_vector(1 downto 0);
		o_ALUVal        : out std_logic_vector(31 downto 0);
		o_RegData2      : out std_logic_vector(31 downto 0);
		o_PCplus4       : out std_logic_vector(31 downto 0);
		o_instMem       : out std_logic_vector(31 downto 0);
		o_upperImmVal   : out std_logic_vector(31 downto 0));
end component;

signal s_Clk, s_EXMEM_Reg_Reset,  s_WE,s_RegDst, s_reg_w_en,s_dmem_w_en, s_upperImm, s_isLink, s_isLoad, s_isLoadU,	s_isImmALU  :std_logic;

signal s_operation :std_logic_vector(2 downto 0);

signal s_ALUsel :std_logic_vector(1 downto 0);

signal s_issv, s_isJumpReg, s_isLinkALU , s_ALU_write, s_isUnsignedALU :std_logic;

signal s_TypeSel :std_logic_vector(1 downto 0);

signal s_forwardA_ALU , s_forwardB_ALU :std_logic_vector(2 downto 0);

signal s_IDEX_ALUop :std_logic_vector(5 downto 0);

signal s_EXMEM_ALU,s_MEMWB_memOut , s_MEMWB_PCp4 ,s_EXMEM_UpperImm, s_MEMWB_UpperImm , s_IDEX_Rs, s_IDEX_Rt, s_IDEX_mux12 , s_IDEX_imem, s_IDEX_PCp4  :std_logic_vector(31 downto 0);

signal s_o_RegDst, s_o_isLoad, s_o_isLoadU , s_o_Reg_w_en  , s_o_dmem_w_en , s_o_ALUwrite , s_o_isJumpReg , s_o_isLink  ,s_o_isLinkALU,s_o_UpperImm :std_logic;

signal s_o_TypeSel :std_logic_vector(1 downto 0);

signal s_o_ALUVal,s_o_RegData2, s_o_PCplus4 , s_o_instMem , s_o_upperImmVal  :std_logic_vector(31 downto 0);

begin
  
 DUT: EX_stage
   port map(
    CLK  => s_Clk, 
 	EXMEM_Reg_Reset =>   s_EXMEM_Reg_Reset,
		WE            =>  s_WE,
		RegDst        =>  s_RegDst,
		reg_w_en      =>  s_reg_w_en,
		dmem_w_en     =>  s_dmem_w_en,
		upperImm      => s_upperImm, 
		isLink        => s_isLink,
		isLoad        => s_isLoad,
		isLoadU       => s_isLoadU,
		isImmALU      => s_isImmALU ,
		operation     => s_operation,
    ALUsel        => s_ALUsel,
    issv          => s_issv,
    isJumpReg     => s_isJumpReg,
    isLinkALU     => s_isLinkALU ,
    ALU_write     => s_ALU_write,
    isUnsignedALU  => s_isUnsignedALU,
		TypeSel        => s_TypeSel,
		forwardA_ALU    => s_forwardA_ALU ,
		forwardB_ALU   =>  s_forwardB_ALU,
		IDEX_ALUop      => s_IDEX_ALUop,
		EXMEM_ALU       => s_EXMEM_ALU,
		MEMWB_memOut   => s_MEMWB_memOut,
		MEMWB_PCp4     => s_MEMWB_PCp4 ,
		EXMEM_UpperImm  => s_EXMEM_UpperImm,
		MEMWB_UpperImm  => s_MEMWB_UpperImm,
		IDEX_Rs         => s_IDEX_Rs,
		IDEX_Rt         =>  s_IDEX_Rt,
		IDEX_mux12      =>  s_IDEX_mux12 ,
		IDEX_imem      => s_IDEX_imem,
		IDEX_PCp4       => s_IDEX_PCp4,
		o_RegDst        => s_o_RegDst,
		o_isLoad        => s_o_isLoad,
		o_isLoadU       => s_o_isLoadU,
		o_Reg_w_en      => s_o_Reg_w_en, 
		o_dmem_w_en    => s_o_dmem_w_en,
		o_ALUwrite     => s_o_ALUwrite,
		o_isJumpReg    => s_o_isJumpReg,
		o_isLink        => s_o_isLink,
		o_isLinkALU     => s_o_isLinkALU,
		o_UpperImm      => s_o_UpperImm,
		o_TypeSel      => s_o_TypeSel,
		o_ALUVal       => s_o_ALUVal, 
		o_RegData2     => s_o_RegData2,
		o_PCplus4      => s_o_PCplus4 ,
		o_instMem      => s_o_instMem ,
		o_upperImmVal   => s_o_upperImmVal
   
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
 --- Reset is 1   
  s_EXMEM_Reg_Reset  <= '1';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
    
     ---  s_WE  is 1   
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
    
     ---   RegDst is 0   
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '0';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
       
         --- Dmem  is 0   
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '0';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
  
--- Upper immediate is set to 0
    
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '0';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
  
--- isLink  is set to 0
    
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '0';
  s_isLoad <= '1';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
     
     --- isLoad  is set to 0
    
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '0';
  s_isLoadU <= '1';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
      
         --- isLoadU  is set to 0
    
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '0';
  s_isImmALU <= '1';
  s_operation <= "000";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
     
             --- AluOp 001
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '0';
  s_isImmALU <= '1';
  s_operation <= "001";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
      
        
             --- AluOp 010
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '0';
  s_isImmALU <= '1';
  s_operation <= "010";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
                  --- AluOp 011
  s_EXMEM_Reg_Reset  <= '0';
  s_WE <= '1';
  s_RegDst <= '1';
  s_reg_w_en <= '1';
  s_dmem_w_en  <= '1';
  s_upperImm  <= '1';
  s_isLink <= '1';
  s_isLoad <= '1';
  s_isLoadU <= '0';
  s_isImmALU <= '1';
  s_operation <= "011";
  s_ALUsel <= "00";
  s_issv <= '1';
   s_isJumpReg <= '1';
   s_isLinkALU <= '1';
  s_ALU_write <= '1';
   s_isUnsignedALU  <= '1'; 
   s_TypeSel <= "10";
    s_forwardA_ALU  <= "000";
    s_forwardB_ALU <= "000";
    s_IDEX_ALUop  <= "000000";
    s_EXMEM_ALU <= x"B00B1EE6";
     s_MEMWB_memOut <= x"0DCBBCCA";
    s_MEMWB_PCp4  <= x"C01B1DEC";
    s_EXMEM_UpperImm <=  x"10010000";
    s_MEMWB_UpperImm <= x"10020000";
     s_IDEX_Rs <= x"DCBADCBA";
     s_IDEX_Rt <= x"ABCDABCD";
    s_IDEX_mux12 <= x"FFFF0000";
    s_IDEX_imem 	 <= x"200D0007";--addi $13,0,$7
    s_IDEX_PCp4 <= x"C01B1DE4";
      wait for gCLK_HPER;
end process;
end behavior;