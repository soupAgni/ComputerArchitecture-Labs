-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- fullAdder_b.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder_b is

  port(C_in      : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       C_out     : out std_logic;
       S_out     : out std_logic);

end fullAdder_b;

architecture dataflow of fullAdder_b is
  
 component xor2
     port(i_A       : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

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

signal sValue_ABxor, sValue_AB, sValue_AC, sValue_BC, sValue_or : std_logic;
  
begin
  
   ---------------------------------------------------------------------------
  -- Level 1: Calculate XOR of A and B
  ---------------------------------------------------------------------------
  
  xor_1 : xor2
  
  port MAP(i_A => A,
           i_B => B,
           o_F => sValue_ABxor);
           
  ---------------------------------------------------------------------------
  -- Level 2: Calculate XOR of(A xor B) with C_in
  ---------------------------------------------------------------------------
  
  xor_2 : xor2
  
  port MAP(i_A => sValue_ABxor,
           i_B => C_in,
           o_F => s_out);
           
  ---------------------------------------------------------------------------
  -- Level 3: Calculate AND of A and B, A and C , and B and C
  ---------------------------------------------------------------------------  
        
  And_1 : and2
  
  port MAP(i_A => A,
           i_B => B,
           o_F => sValue_AB);
           
  And_2 : and2
  
  port MAP(i_A => A,
           i_B => C_in,
           o_F => sValue_AC);
           
                       
  And_3 : and2
  
  port MAP(i_A => B,
           i_B => C_in,
           o_F => sValue_BC);
           
   ---------------------------------------------------------------------------
  -- Level 4: Calculate OR of AB and AC, then OR the result with BC
  ---------------------------------------------------------------------------  
           
  Or_1 : or2
  
  port MAP(i_A => sValue_AB,
           i_B => sValue_AC,
           o_F => sValue_or);
           
           
   Or_2 : or2
  
  port MAP(i_A => sValue_or,
           i_B => sValue_BC,
           o_F => c_out);
  
end dataflow;
