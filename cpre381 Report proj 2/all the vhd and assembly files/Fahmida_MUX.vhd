-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- inv.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1-input NOT 
-- gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity multiplexer is

  port(x         : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       Y         : out std_logic);

end multiplexer;

architecture dataflow of multiplexer is
  
 component inv
    port (i_A  : in std_logic;
          o_F  : out std_logic);
 end component;

 component and2
    port (i_A  : in std_logic;
          i_B  : in std_logic;
          o_F  : out std_logic);
 end component;

 component or2
    port (i_A  : in std_logic;
          i_B  : in std_logic;
          o_F  : out std_logic);
 end component;

signal sValue_Xnot, sValue_Add1, sValue_Add2 : std_logic;
  
begin
  
   ---------------------------------------------------------------------------
  -- Level 1: Calculate x inverse
  ---------------------------------------------------------------------------
  
  inv_1 : inv
  
  port MAP(i_A => X,
           o_F => sValue_Xnot);
           
  And_1 : and2
  
  port MAP(i_A => A,
           i_B => sValue_Xnot,
           o_F => sValue_Add1);
           
  And_2 : and2
  
  port MAP(i_A => B,
           i_B => x,
           o_F => sValue_Add2);
           
  Or_1 : or2
  
  port MAP(i_A => sValue_Add1,
           i_B => sValue_Add2,
           o_F => Y);
  
  
end dataflow;