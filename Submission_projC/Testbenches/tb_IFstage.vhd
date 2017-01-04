-------------------------------------------------------------------------
-- Fahmida Joyti
--tb_IFstage
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity tb_IFStage is
  generic(gCLK_Hper : time := 50 ns);
end tb_IFStage;

architecture behavior of tb_IFStage is 

entity IF_stage is
  generic(N : integer := 32;
          mif_filename 	: string := "i_mem.mif");
  port(CLK : in std_logic;
       PC_reset: in std_logic;
       IFID_reset : in std_logic;
       MEMWB_isJumpReg :in std_logic;
       mux_ORval : in std_logic;
       reg_WE     :in std_logic;
       IDEX_branchJump : in std_logic_vector(31 downto 0);
       IDEX_rs     : in std_logic_vector(31 downto 0);
       o_instMem: out std_logic_vector(31 downto 0);
		   o_PCplus4: out std_logic_vector(31 downto 0));
		 
end IF_stage;
		 
end component;

signal s_Clk, s_PC_reset,  s_MEMWB_isJumpReg, s_mux_ORval,s_reg_WE   :std_logic;
signal s_IDEX_branchJump, s_IDEX_rs,  s_o_instMem, s_o_PCplus4       :std_logic_vector(31 downto 0);

begin
  
   DUT: IF_stage
   port map(
    CLK  => s_Clk,  
    PC_reset   =>  s_PC_reset,
    MEMWB_isJumpReg  =>  s_MEMWB_isJumpReg,
    mux_ORval   => s_mux_ORval,
    reg_WE       => s_reg_WE,
    IDEX_branchJump => s_IDEX_branchJump,
    IDEX_rs     => s_IDEX_rs,
    o_instMem => s_o_instMem,
    o_PCplus4  =>s_o_PCplus4  
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
---   Reset is set to 1 
  s_PC_reset<= '1';
	s_MEMWB_isJumpReg <= '1';
	s_mux_ORval <= '1';
	s_reg_WE <= '1';
  s_IDEX_branchJump <= x"B00B1EE5";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
 ------Cases where reset is zero
  s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '0';
	s_mux_ORval <= '0';
	s_reg_WE <= '1';
  s_IDEX_branchJump <= x"B00B1EE5";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
   
  s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '0';
	s_mux_ORval <= '1';
	s_reg_WE <= '1';
  s_IDEX_branchJump <= x"B00B1EE5";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
   s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '1';
	s_mux_ORval <= '0';
	s_reg_WE <= '1';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
   s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '1';
	s_mux_ORval <= '1';
	s_reg_WE <= '1';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  ------------- Testing for reg_w_en is 0
   s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '1';
	s_mux_ORval <= '1';
	s_reg_WE <= '0';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
   s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '0';
	s_mux_ORval <= '1';
	s_reg_WE <= '0';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
   s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '0';
	s_mux_ORval <= '0';
	s_reg_WE <= '0';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  
  
    s_PC_reset<= '0';
	s_MEMWB_isJumpReg <= '1';
	s_mux_ORval <= '0';
	s_reg_WE <= '0';
  s_IDEX_branchJump <= x"B00B1EE6";
 	s_IDEX_rs <= x"FFFFFFFF";
  wait for gCLK_HPER;
  	
  	
  
    
  end process;
   


end behavior;

