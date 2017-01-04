use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use work.array2D.all;

-- entity
entity my_32t1_mux is
  
  
port ( D_IN   : in  array32_bit(31 downto 0);
       sel: in std_logic_vector(4 downto 0);
       MX_OUT : out std_logic_vector(31 downto 0));

end my_32t1_mux;
-- architecture
architecture spec_dec of my_32t1_mux is
  
begin

MX_OUT <= D_IN(0) when (sel = "00000") else
          D_IN(1) when (sel = "00001")else
          D_IN(2) when (sel = "00010") else
          D_IN(3) when (sel = "00011")else
          D_IN(4) when (sel = "00100")else
          D_IN(5) when (sel = "00101")else
          D_IN(6) when (sel = "00110")else
          D_IN(7) when (sel = "00111")else
          D_IN(8) when (sel = "01000")else
          D_IN(9) when (sel = "01001")else
          D_IN(10) when (sel = "01010")else
          D_IN(11) when (sel = "01011")else
          D_IN(12) when (sel = "01100")else
          D_IN(13) when (sel = "01101")else
          D_IN(14) when (sel = "01110")else
          D_IN(15) when (sel = "01111")else
          D_IN(16) when (sel = "10000")else
          D_IN(17) when (sel = "10001")else
          D_IN(18) when (sel = "10010")else
          D_IN(19) when (sel = "10011")else
          D_IN(20) when (sel = "10100")else
          D_IN(21) when (sel = "10101")else
          D_IN(22) when (sel = "10110")else
          D_IN(23) when (sel = "10111")else
          D_IN(24) when (sel = "11000")else
          D_IN(25) when (sel = "11001")else
          D_IN(26) when (sel = "11010")else
          D_IN(27) when (sel = "11011")else
          D_IN(28) when (sel = "11100")else
          D_IN(29) when (sel = "11101")else
          D_IN(30) when (sel = "11110")else
          D_IN(31) when (sel = "11111")else
          
          
          x"00000000" ;
end spec_dec;