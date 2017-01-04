use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity AddSub_n is
  
  generic(N : integer := 32);
  port(nAdd_Sub         : in std_logic_vector(N-1 downto 0);
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       Y         : out std_logic_vector(N-1 downto 0);
       Z         : out std_logic_vector(N-1 downto 0));

end AddSub_n;

architecture dataflow of AddSub_n is
  
  component AddSub is
    
  port(nAdd_Sub  : in std_logic;
       A         : in std_logic;
       B         : in std_logic;
       Y         : out std_logic;
       Z         : out std_logic);


end component;

begin

G1: for i in 0 to N-1 generate
  
  AddSub_1 : AddSub
  
  port map(
  
  nAdd_Sub  => nAdd_Sub(i),
  A  => A(i),
  B  => B(i),
  Y  => Y(i),
  Z => Z(i));
 
end generate;
  
end dataflow;
