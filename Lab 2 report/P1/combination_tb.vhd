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
entity combination_tb is
  
  generic(N : integer := 32);

end combination_tb;

architecture behavior of combination_tb is

-- Declare the component we are going to instantiate
component ones_complement
  
  generic(N : integer := 32);
   
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
end component;

component ones_complement_dataflow
  
  generic(N : integer := 32);
  
   
  port(i_A  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));
       
end component;

-- Signals to connect to the and2 module
signal s_A, s_F1, s_F2  : std_logic_vector(N-1 downto 0);

begin

DUT1: ones_complement
  port map(i_A  => s_A,
  	        o_F  => s_F1);
  	        

DUT2: ones_complement_dataflow
  port map(i_A  => s_A,
  	        o_F  => s_F2);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= x"ffffffff";
    wait for 100 ns;
    
    s_A <= x"00000000";
    wait for 100 ns;


  end process;
  
end behavior;
