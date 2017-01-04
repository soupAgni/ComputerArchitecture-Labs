-------------------------------------------------------------------------
-- Souparni Agnihotri
-- Iowa State University
-------------------------------------------------------------------------

-- combination_tb
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity multiplexer_tb is
  
  generic(N : integer := 32);

end multiplexer_tb;

architecture behavior of multiplexer_tb is

-- Declare the component we are going to instantiate
component multiplexer_c
  
  generic(N : integer := 32);
   
  port(x         : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       Y         : out std_logic_vector(N-1 downto 0));

end component;

component multiplexer_d
  
  generic(N : integer := 32);
  
   
  port(x         : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       Y         : out std_logic_vector(N-1 downto 0));
       
end component;

-- Signals to connect to the and2 module
signal s_A, s_B, s_C, s_F1, s_F2  : std_logic_vector(N-1 downto 0);

begin

DUT1: multiplexer_c
  port map(x  => s_A,
  	        A  => s_B,
  	        B  => s_C,
  	        Y  => s_F1);
  	        

DUT2: multiplexer_d
  port map(x  => s_A,
  	        A  => s_B,
  	        B  => s_C,
  	        Y  => s_F2);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= x"00000000";
    
    s_B <= x"00000001";
    
    s_C <= x"00000000";
    wait for 100 ns;
    
    s_A <= x"00000001";
    
    s_B <= x"00000001";
    
    s_C <= x"00000000";
    wait for 100 ns;
    


  end process;
  
end behavior;
