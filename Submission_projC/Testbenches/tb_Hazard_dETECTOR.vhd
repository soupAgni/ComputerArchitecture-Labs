library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Hazard_detector is
  
  generic(gCLK_HPER   : time := 50 ns);
 
end tb_Hazard_detector;

architecture behavior of tb_Hazard_detector  is
  component Hazard_detector is
	port (i_CLK        : in std_logic;  
        IDEX_isLoad  : in std_logic;
        IFID_instMem  : in std_logic_vector(31 downto 0);
        IDEX_instMem   : in std_logic_vector(31 downto 0);
        IDEX_branch      : in std_logic;
        IDEX_branchAnd  : in std_logic;
        IDEX_jump  : in std_logic;
       
        IDEX_WriteEnable : out std_logic;
        IFID_WriteEnable :out std_logic;
        IDEX_flush       : out std_logic;
        IFID_flush       :out std_logic;
        IDEX_reset       :out std_logic;
        IFID_reset      :out std_logic
        
    	    );
end component;

signal s_clock,s_IDEX_isLoad,s_IDEX_branch ,s_IDEX_branchAnd,s_IDEX_jump     :std_logic;
signal s_IFID_instMem,s_IDEX_instMem : std_logic_vector(31 downto 0);
signal s_o_IDEX_WriteEnable :  std_logic;
signal s_o_IFID_WriteEnable : std_logic;
signal s_o_IDEX_flush,s_o_IFID_flush,s_o_IDEX_reset,s_o_IFID_reset  : std_logic;

begin 
DUT: Hazard_detector
port map(i_CLK        => s_clock,
        IDEX_isLoad  => s_IDEX_isLoad,
        IFID_instMem  => s_IFID_instMem,
        IDEX_instMem  => s_IDEX_instMem,
        IDEX_branch    => s_IDEX_branch ,
        IDEX_branchAnd => s_IDEX_branchAnd,
        IDEX_jump  => s_IDEX_jump ,
       
        IDEX_WriteEnable => s_o_IDEX_WriteEnable,
        IFID_WriteEnable => s_o_IFID_WriteEnable ,
        IDEX_flush       => s_o_IDEX_flush,
        IFID_flush   => s_o_IFID_flush,
        IDEX_reset     => s_o_IDEX_reset,
        IFID_reset     => s_o_IFID_reset 
        
    	    );
    	    
 	   P_CLK: process
  begin
    s_clock <= '0';
    wait for gCLK_HPER;
    s_clock <= '1';
    wait for gCLK_HPER;
  end process;
  
 P_TB: process
  begin
 s_IDEX_isLoad <= '1';
 s_IFID_instMem <= x"000a5820"; -- add $t3, $zero, $t2
 s_IDEX_instMem <= x"8c0a2004"; -- lw   $t2, 0x00002004
 s_IDEX_branch <= '0';
 s_IDEX_branchAnd <= '0';
 s_IDEX_jump <= '0';
  wait for gCLK_HPER;
 
 
  s_IDEX_isLoad <= '0';
 s_IFID_instMem <= x"116c0000"; -- beq $t3,$t4,L1
 s_IDEX_instMem <= x"200c0007"; -- addi $t4, $zero,7
 s_IDEX_branch <= '1';
 s_IDEX_branchAnd <= '1';
 s_IDEX_jump <= '0';
  wait for gCLK_HPER;
  
  
   s_IDEX_isLoad <= '0';
 s_IFID_instMem <= x"200c0007"; -- beq $t3,$t4,L1
 s_IDEX_instMem <= x"08000003"; -- addi $t4, $zero,7
 s_IDEX_branch <= '0';
 s_IDEX_branchAnd <= '0';
 s_IDEX_jump <= '1';
  wait for gCLK_HPER;
  
 
 end process;
  
  
end behavior;

 