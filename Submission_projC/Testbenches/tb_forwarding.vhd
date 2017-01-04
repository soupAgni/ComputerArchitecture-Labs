library IEEE;
use IEEE.std_logic_1164.all;

entity tb_forwarding is
  
  generic(gCLK_HPER   : time := 50 ns);
 
end tb_forwarding;

architecture behavior of tb_forwarding  is
  component forwardingUnit  is
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
end component;

signal s_IFID_imem, s_IDEX_imem,  s_EXMEM_imem, s_MEMWB_imem  : std_logic_vector(31 downto 0);
signal s_MEMWB_RegDest, s_MEMWB_reg_w_en, s_MEMWB_isLink, s_EXMEM_reg_w_en, s_EXMEM_RegDest, s_isLoad, s_EXMEM_lui, s_MEMWB_lui, s_MEMWB_isLinkALU, s_IDEX_reg_w_en, s_IDEX_RegDest, s_IDEX_lui, s_EXMEM_isLinkALU, s_EXMEM_isLink: std_logic;
signal s_o_forwardA_ALU, s_o_forwardB_ALU, s_o_forwardA_branch, s_o_forwardB_branch  : std_logic_vector(2 downto 0);
begin 
DUT: forwardingUnit
port map(IFID_imem    => s_IFID_imem,
         IDEX_imem    => s_IDEX_imem,
         EXMEM_imem   => s_EXMEM_imem,
         MEMWB_imem   => s_MEMWB_imem,
         
         MEMWB_reg_w_en => s_MEMWB_reg_w_en,
         EXMEM_reg_w_en => s_EXMEM_reg_w_en,
         IDEX_reg_w_en  => s_IDEX_reg_w_en,

         MEMWB_RegDest  => s_MEMWB_RegDest,
         EXMEM_RegDest  => s_EXMEM_RegDest,
         IDEX_RegDest   => s_IDEX_RegDest, 
         
         MEMWB_isLink   => s_MEMWB_isLink, 
         MEMWB_islInkALU => s_MEMWB_isLinkALU,
         EXMEM_isLinkALU => s_EXMEM_isLinkALU,
         EXMEM_isLink    => s_EXMEM_isLink, 
         
         MEMWB_UpperImm  => s_MEMWB_lui, 
         EXMEM_UpperImm  => s_EXMEM_lui,
         IDEX_UpperImm  => s_IDEX_lui, 
         
         MEMWB_isLoad    => s_isLoad, 

         forwardA_ALU   => s_o_forwardA_ALU,
         forwardB_ALU   => s_o_forwardB_ALU,

         forwardA_branch   => s_o_forwardA_branch,
         forwardB_branch   => s_o_forwardB_branch 
    	    );
 P_TB: process
  begin
    --- case one :: needs to output 001 for all outputs
         s_IFID_imem    <= "00000011111111111111100000000000";
         s_IDEX_imem    <= "00000011111111111111100000000000";
         s_EXMEM_imem   <= "00000000000000001111100000000000";
         s_MEMWB_imem   <= "00000000000000000000000000000000";
         
         s_MEMWB_reg_w_en <= '1';
         s_EXMEM_reg_w_en <= '1';
         s_IDEX_reg_w_en  <= '1';

         s_MEMWB_RegDest  <= '0';
         s_EXMEM_RegDest  <= '0';
         s_IDEX_RegDest   <= '0';
         
         s_MEMWB_isLink   <='1';
         s_MEMWB_islInkALU <= '1';
         s_EXMEM_isLinkALU <= '1';
         s_EXMEM_isLink    <= '1'; 
         
         s_MEMWB_lui  <= '1'; 
         s_EXMEM_lui  <= '1';
         s_IDEX_lui  <= '1';
         
         s_isLoad    <= '0'; 
  wait for gCLK_HPER;
   --- all outputs should be 100
 
          s_IFID_imem    <= "00000000011000000000000000000000";
         s_IDEX_imem    <= "00000000111000000001100000000000";
         s_EXMEM_imem   <= "00000000000000110011100000000000";
         s_MEMWB_imem   <= "00000000000000000000000000000000";
         
         s_MEMWB_reg_w_en <= '1';
         s_EXMEM_reg_w_en <= '1';
         s_IDEX_reg_w_en  <= '0';

         s_MEMWB_RegDest  <= '0';
         s_EXMEM_RegDest  <= '0';
         s_IDEX_RegDest   <= '0'; 
         
         s_MEMWB_isLink   <= '0'; 
         s_MEMWB_islInkALU <= '0';
         s_EXMEM_isLinkALU <= '0';
         s_EXMEM_isLink    <= '0'; 
         
         s_MEMWB_lui  <= '0'; 
         s_EXMEM_lui  <= '1';
         s_IDEX_lui  <= '1';
        
         s_isLoad    <= '0'; 
  wait for gCLK_HPER;
  --- all outputs should be 010
  
         s_IFID_imem    <= "00000000100001000000000000000000";
        s_IDEX_imem    <= "00000000101001010000000000000000";
         s_EXMEM_imem   <= "00000000000000000010000000000000";
         s_MEMWB_imem   <= "00000000000000000010100000000000";
         
         s_MEMWB_reg_w_en <= '1';
         s_EXMEM_reg_w_en <= '1';
         s_IDEX_reg_w_en  <= '0';

         s_MEMWB_RegDest  <= '0';
         s_EXMEM_RegDest  <= '0';
         s_IDEX_RegDest   <= '0'; 
         
         s_MEMWB_isLink   <= '0'; 
         s_MEMWB_islInkALU <= '0';
         s_EXMEM_isLinkALU <= '0';
         s_EXMEM_isLink    <= '0'; 
         
         s_MEMWB_lui  <= '0'; 
         s_EXMEM_lui  <= '0';
         s_IDEX_lui  <= '0';
         
         s_isLoad    <= '1'; 
  wait for gCLK_HPER;
  ---  011 outputs   (forwards the pcp4 value)
         s_IFID_imem    <= "00000011111110000000000000000000";
         s_IDEX_imem    <= "00000011100110110000000000000000";
         s_EXMEM_imem   <= "00000000000110001111100000000000";
         s_MEMWB_imem   <= "00000000000110111110000000000000";
         
         s_MEMWB_reg_w_en <= '1';
         s_EXMEM_reg_w_en <= '1';
         s_IDEX_reg_w_en  <= '0';

         s_MEMWB_RegDest  <= '0';
         s_EXMEM_RegDest  <= '0';
         s_IDEX_RegDest   <= '0'; 
         
         s_MEMWB_isLink   <= '1';
         s_MEMWB_islInkALU <= '1';
         s_EXMEM_isLinkALU <= '1';
         s_EXMEM_isLink    <= '1'; 
         
         s_MEMWB_lui  <= '0';
         s_EXMEM_lui <= '0';
         s_IDEX_lui  <= '0';
         
         s_isLoad    <= '1';
  wait for gCLK_HPER;
  
   ---- all outputs 101  (for upperimms)
         s_IFID_imem    <= "00000011001000000000000000000000";
        s_IDEX_imem    <= "00000011111000000000000000000000";
         s_EXMEM_imem   <= "00000000000110011100100000000000";
         s_MEMWB_imem   <= "00000000000111111111100000000000";
         
         s_MEMWB_reg_w_en <= '1';
         s_EXMEM_reg_w_en <= '1';
         s_IDEX_reg_w_en  <= '0';

         s_MEMWB_RegDest  <= '0';
         s_EXMEM_RegDest  <= '0';
         s_IDEX_RegDest   <= '0'; 
         
         s_MEMWB_isLink   <= '0';
         s_MEMWB_islInkALU <= '0';
         s_EXMEM_isLinkALU <= '0';
         s_EXMEM_isLink    <= '0'; 
         
         s_MEMWB_lui  <= '1';
         s_EXMEM_lui  <= '1';
         s_IDEX_lui  <= '0';
         
         s_isLoad    <= '1';
  wait for gCLK_HPER;
  
 
 end process;
  
  
end behavior;

 