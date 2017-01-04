use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is

  port(iX              : in std_logic;
       iY 		           : in std_logic;
       iC 		           : in std_logic;
       oS 		           : out std_logic;
       oC 		           : out std_logic
       );

end full_adder;

architecture structure of full_adder is
  
  component xor2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component and2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component or2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal s_A, s_B ,s_C, s_D,s_E : std_logic;

begin

xor_gate1: xor2
 port MAP(
             i_A               => iX,
             i_B               => iY,
             o_F              => s_E);
  
  
   
xor_gate2: xor2
 port MAP(
             i_A               => s_E,
             i_B               => iC,
             o_F              => oS);
  
 
   
   
   and_gate1: and2
 port MAP(
             i_A               => iX,
             i_B               => iY,
             o_F              => s_A);


and_gate2: and2
 port MAP(
             i_A               => iX,
             i_B               => iC,
             o_F              => s_B);
             
             
and_gate3: and2
 port MAP(
             i_A               => iY,
             i_B               => iC,
             o_F              => s_C);
             
or_gate1: or2
 port MAP(
             i_A               => s_A,
             i_B               => s_B,
             o_F              => s_D);
or_gate2: or2
 port MAP(
             i_A               => s_D,
             i_B               => s_C,
             o_F              => oC);  
             
             
end structure;         

