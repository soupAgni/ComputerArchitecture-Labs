-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- register_file.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- a register file with 32 32-bit registers and a selector, with write capability. (structural)

library IEEE;
use IEEE.std_logic_1164.all;

use work.array_of_vectors_32_type.all;
use work.all;

entity register_file is
	port(	i_reg1 : in std_logic_vector(4 downto 0); -- address of rs
		i_reg2 : in std_logic_vector(4 downto 0); -- address of rt
		i_writereg : in std_logic_vector(4 downto 0); -- address to write to
		i_data : in std_logic_vector(31 downto 0); -- data to write at i_writereg address
		i_WE : in std_logic; -- write enable
		i_CLK : in std_logic;
		i_RST : in std_logic; -- resets entire register file
		o_reg1 : out std_logic_vector(31 downto 0); -- output data of rs address
		o_reg2 : out std_logic_vector(31 downto 0)); -- output data of rt address
end register_file;

architecture structural of register_file is

	-- 5 to 32 decoder
	component decoder_5_32 is
		port( 	input : in std_logic_vector(4 downto 0);
			output : out std_logic_vector(31 downto 0)	);
	end component;
	
	-- 32 bit register
	component n_bit_reg is
		generic(N : integer := 32);
		port(	i_CLK        : in std_logic;     -- Clock input
		       	i_RST        : in std_logic;     -- Reset input
		       	i_WE         : in std_logic;     -- Write enable input
		       	i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
		       	o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
	end component;
	
	-- 32 to 1 mux
	component mux_32_1 is
		port(	i_Sel : in std_logic_vector(4 downto 0);
			data_inputs : in arrayVectors32;
			output : out std_logic_vector(31 downto 0)	);
	end component;

signal decoder_output : std_logic_vector(31 downto 0);

-- the output of the register file, holds all registers' data
signal reg_file_data : arrayVectors32;

-- intermediate value to hold (i_WE and decoder output)
signal write_enable : std_logic_vector(31 downto 0);

begin
	
	-- i_reg1 is the write select register so it is the register that gets decoded
	decoder : decoder_5_32
		port map(	input => i_writereg,
				output => decoder_output);

    G1: for j in 0 to 31 generate
		write_enable(j) <= (decoder_output(j) and i_WE);
	end generate;	
	
	-- the bank of 32-bit registers; reg_0 is created by itself so the reset can always be 1 (because reg_0 data should always be 0)
	reg_0 : n_bit_reg
		port map(	i_CLK => i_CLK,
				i_RST => '1',
				i_WE => '0',
				i_D => reg_file_data(0),
				o_Q => reg_file_data(0));
		
	
    G2: for i in 1 to 31 generate
		reg_i : n_bit_reg
			port map(	i_CLK => i_CLK,
					i_RST => i_RST,
					i_WE => write_enable(i),
					i_D => i_data,
					o_Q => reg_file_data(i));
	end generate;

	--end bank of registers
	
	-- this mux selects the data from the register specified by i_reg1
	mux_1 : mux_32_1
		port map(	i_Sel => i_reg1,
				data_inputs => reg_file_data,
				output => o_reg1);

	-- this mux selects the data from the register specified by i_reg2
	mux_2 : mux_32_1
		port map(	i_Sel => i_reg2,
				data_inputs => reg_file_data,
				output => o_reg2);

end structural;






