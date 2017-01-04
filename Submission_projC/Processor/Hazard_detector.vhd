-------------------------------------------------------------------------
-- Fahmida Joyti
-- Fall 2016
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Hazard_detector is
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
end Hazard_detector;

architecture behavior of Hazard_detector is
signal s_IFID_rs ,s_IFID_rt : std_logic_vector(4 downto 0);
signal s_IDEX_rs, s_IDEX_rt  : std_logic_vector(4 downto 0);
signal s_IDEX_opcode        : std_logic_vector(5 downto 0);
signal s_IDEX_branchAnd ,s_IDEX_branch,  s_IDEX_jump ,s_IDEX_WriteEnable,s_IFID_WriteEnable ,s_IDEX_flush,s_IFID_flush,s_IDEX_reset,s_IFID_reset,s_IDEX_isLoad : std_logic;
   

begin
  
  s_IDEX_opcode  <= IFID_instMem(31 downto 26);
  s_IFID_rs <= IFID_instMem(25 downto 21);
  s_IFID_rt <= IFID_instMem(20 downto 16);
  s_IDEX_rs <= IDEX_instMem (25 downto 21);
  s_IDEX_rt <= IDEX_instMem (20 downto 16);
  s_IDEX_branchAnd <=  IDEX_branchAnd;
  s_IDEX_branch <=  IDEX_branch;
  s_IDEX_jump   <=  IDEX_jump ;
  s_IDEX_isLoad <= IDEX_isLoad ;
  IDEX_WriteEnable  <= s_IDEX_WriteEnable;
  IFID_WriteEnable <= s_IFID_WriteEnable;
  IDEX_flush <= s_IDEX_flush;
  IFID_reset <= s_IFID_reset;
  IDEX_reset <= s_IDEX_reset;
  IFID_flush <= s_IFID_flush;
  
  process(i_CLK ,s_IDEX_opcode,s_IFID_rs, s_IFID_rt,s_IDEX_rs,s_IDEX_rt,s_IDEX_branchAnd,s_IDEX_branch,s_IDEX_WriteEnable,s_IFID_WriteEnable,s_IDEX_flush,s_IFID_flush,s_IDEX_reset,s_IFID_reset,s_IDEX_isLoad)
    begin
if (rising_edge(i_CLK)) then       
  if ( (s_IDEX_isLoad = '1') 
    and (s_IDEX_rt = s_IFID_rs or s_IDEX_rt = s_IFID_rt) --load hazard
    and not (s_IDEX_rt =  "00000") ) then
       s_IDEX_WriteEnable <= '0';
        s_IFID_WriteEnable <= '0';
        s_IFID_flush <= '1';
        s_IDEX_flush <= '1';
        s_IDEX_reset  <= '1';---I am not sure if we need resets or not
        s_IFID_reset <= '1';
      
   
    
    elsif ((  s_IDEX_jump = '1')) then -- jump instruction flush the next instruction
          
        s_IDEX_WriteEnable <= '0';
        s_IFID_WriteEnable <= '0';
        
          s_IFID_flush <= '1';
        s_IDEX_flush <= '1';
        s_IDEX_reset  <= '1';---I am not sure if we need resets or not
        s_IFID_reset <= '1';
 
  

  
  elsif (s_IDEX_branchAnd = '1' and s_IDEX_branch = '1') then
    
       s_IDEX_WriteEnable <= '0';
        s_IFID_WriteEnable <= '0';
        
          s_IFID_flush <= '1';
        s_IDEX_flush <= '1';
        s_IDEX_reset  <= '1';---I am not sure if we need resets or not
        s_IFID_reset <= '1';
       
    else
           s_IDEX_WriteEnable <= '1';
        s_IFID_WriteEnable <= '1';
        
          s_IFID_flush <= '0';
        s_IDEX_flush <= '0';
        s_IDEX_reset  <= '0';---I am not sure if we need resets or not
        s_IFID_reset <= '0';
end if;
end if;
  end process;
  
end behavior;