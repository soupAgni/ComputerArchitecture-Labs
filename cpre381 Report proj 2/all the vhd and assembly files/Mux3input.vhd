use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;
entity mux3to1 is 
   generic(N : integer := 32);
port( A: in std_logic_vector(N-1 downto 0);
B: in std_logic_vector(N-1 downto 0); 
C: in std_logic_vector(N-1 downto 0);              
S: in std_logic_vector(1 downto 0);
O: out std_logic_vector(N-1 downto 0)
                 );

end mux3to1;

Architecture behavioral of mux3to1 is
Begin

Process(S,A,B,C)
variable temp : std_logic_vector(N-1 downto 0);           
Begin

if(S="00")then
temp:=A;

elsif(S="01")then                  
temp:=B;

else
temp:=C;
end if;                                

O<=temp;                        
end Process;
end behavioral; 