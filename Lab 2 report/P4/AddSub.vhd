-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- AddSub.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity AddSub is

  port(nAdd_Sub      : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       Y         : out std_logic;
       Z         : out std_logic);

end AddSub;

architecture dataflow of AddSub is
  
 component multiplexer
   
  port(x         : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       Y         : out std_logic);

 end component;

 component inv
   
  port(i_A          : in std_logic;
       o_F          : out std_logic);
       
 end component;

 component fullAdder_b
 

  port(C_in      : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       C_out     : out std_logic;
       S_out     : out std_logic);

 end component;

signal sValue_inv, sValue_Mux : std_logic;
  
begin
  
   ---------------------------------------------------------------------------
  -- Level 1: Calculate not of B
  ---------------------------------------------------------------------------
  
  inv_1 : inv
  
  port MAP(i_A    => B,
          o_F     => sValue_inv);
           
  ---------------------------------------------------------------------------
  -- Level 2: Calculate into MUX
  ---------------------------------------------------------------------------
  
  multiplexer_1 : multiplexer
  
  port MAP(x     => nAdd_Sub,
       A         => B,
       B         => sValue_inv,
       Y         => sValue_Mux);
       
       
 
           
  ---------------------------------------------------------------------------
  -- Level 3: Putting Values into full adder
  ---------------------------------------------------------------------------  
        
  fullAdder_1 : fullAdder_b
  
  port MAP(C_in   => nAdd_Sub,
       A         => A,
       B         => sValue_Mux,
       C_out     => Y,
       S_out     => Z);
           
  
end dataflow;
