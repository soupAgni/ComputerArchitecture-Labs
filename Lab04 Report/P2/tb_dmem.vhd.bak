
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dmem is
  generic(
    
          depth_exp_of_2 	: integer := 10;
			    mif_filename 	: string := "mem.mif");
			    
			 
end tb_dmem;

architecture behavior of tb_dmem is
 
    
component mem is
    port(address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			   byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			   clock			  : IN STD_LOGIC := '1';
			   data			   : IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			   wren			   : IN STD_LOGIC := '0';
			   q				     : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_WREN  : std_logic;
  signal s_address : std_logic_vector(depth_exp_of_2-1 downto 0);
  signal s_byTeena : std_logic_vector(3 downto 0);
  signal s_data , s_data1   : std_logic_vector(31 downto 0);
  

begin

  dmem : mem 
  port map(clock => s_CLK, 
           wren  => s_WREN,
           address => s_address,
           byteena => s_byTeena,
           data   => s_data,
           q      => s_data1);

  -- Testbench process  
  P_TB: process
  begin
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000000";
    s_byTeena  <= "0000";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000001";
    s_byTeena  <= "0001";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000010";
    s_byTeena  <= "0010";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000011";
    s_byTeena  <= "0011";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000100";
    s_byTeena  <= "0100";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000101";
    s_byTeena  <= "0101";
    s_data   <= s_data1;
    wait for 100 ns;
    
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000110";
    s_byTeena  <= "0110";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000000111";
    s_byTeena  <= "0111";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001000";
    s_byTeena  <= "1000";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001001";
    s_byTeena  <= "1001";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001010";
    s_byTeena  <= "1010";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001011";
    s_byTeena  <= "1011";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001100";
    s_byTeena  <= "1100";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001101";
    s_byTeena  <= "1101";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001110";
    s_byTeena  <= "1110";
    s_data   <= s_data1;
    wait for 100 ns;
    
    
    -- Reset the FF
    s_WREN    <= '0';
    s_address <= "0000001111";
    s_byTeena  <= "1111";
    s_data   <= s_data1;
    wait for 100 ns;
    
    ---------------------------------
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000000";
    s_byTeena  <= "1111";
    s_data   <= x"00000001";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000001";
    s_byTeena  <= "1111";
    s_data   <= x"00000002";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000010";
    s_byTeena  <= "1111";
    s_data   <= x"FFFFFFFD";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000011";
    s_byTeena  <= "1111";
    s_data   <= s_data1;
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000100";
    s_byTeena  <= "1111";
    s_data   <= x"00000004";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000101";
    s_byTeena  <= "1111";
    s_data   <= x"FFFFFFFB";
    wait for 100 ns;
    
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000110";
    s_byTeena  <= "1111";
    s_data   <= x"00000006";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000000111";
    s_byTeena  <= "1111";
    s_data   <= x"FFFFFFF9";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000001000";
    s_byTeena  <= "1111";
    s_data   <= x"00000008";
    wait for 100 ns;
    
    -- Reset the FF
    s_WREN    <= '1';
    s_address <= "1000001001";
    s_byTeena  <= "1111";
    s_data   <= x"FFFFFFF7";
    wait for 100 ns;
    
    
wait;
  end process;
  
end behavior;