-------------------------------------------------------------------------
-- Souparni Agnihotri
-- Iowa State University
-------------------------------------------------------------------------

-- fullAdder_tb
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity fullAdder_tb is
  
  generic(N : integer := 32);

end fullAdder_tb;

architecture behavior of fullAdder_tb is

-- Declare the component we are going to instantiate
component fullAdder_c
  
  generic(N : integer := 32);
   
  port(C_in      : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C_out     : out std_logic_vector(N-1 downto 0);
       S_out     : out std_logic_vector(N-1 downto 0));

end component;

component fullAdder_d
  
  generic(N : integer := 32);
  
   
  port(C_in         : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       C_out         : out std_logic_vector(N-1 downto 0);
       S_out         : out std_logic_vector(N-1 downto 0));
       
end component;

-- Signals to connect to the and2 module
signal s_A, s_B, s_Cin, s_C1, s_S1, s_C2, s_S2  : std_logic_vector(N-1 downto 0);

begin

DUT1: fullAdder_c
  port map(C_in  => s_Cin,
  	        A  => s_A,
  	        B  => s_B,
  	        C_out  => s_C1,
  	        S_out => s_S1);
  	        

DUT2: fullAdder_d
  port map(C_in  => s_Cin,
  	        A  => s_A,
  	        B  => s_B,
  	        C_out  => s_C2,
  	        S_out  => s_S2);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin
    
    s_A <= x"00000001";
    
    s_B <= x"00000001";
    
    s_Cin <= x"00000001";
    wait for 100 ns;
    


  end process;
  
end behavior;
