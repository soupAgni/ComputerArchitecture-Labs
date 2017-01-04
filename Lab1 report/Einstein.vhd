-------------------------------------------------------------------------
-- Souparni Agnihotri
-- Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Einstein.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of Einstein's Energy/mass
-- equation Ax^2+Bx+C using invidual adder and multiplier units.
-------------------------------------------------------------------------
use work.all;

library IEEE;
use IEEE.std_logic_1164.all;


entity Einstein is

  port(iCLK             : in std_logic;
       iM 		            : in integer;
       oY 		            : out integer);

end Einstein;

architecture structure of Einstein is
 
  component Multiplier
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;

  -- Arbitrary constants for the c value. 
  constant cA : integer := 9487;

  -- Signals to store c*c
  signal sVALUE_cc : integer;
  
begin

  
  ---------------------------------------------------------------------------
  -- Level 1: Calculate A*x, B*x
  ---------------------------------------------------------------------------
  g_Mult1: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => cA,
             iB               => cA,
             oC               => sVALUE_cc);
             
 ---------------------------------------------------------------------------
  -- Level 2: Calculate mc^2
  ---------------------------------------------------------------------------
  g_Mult3: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => sVALUE_cc,
             iB               => iM,
             oC               => oY);

 
  
end structure;
