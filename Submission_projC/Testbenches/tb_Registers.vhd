library IEEE;
use IEEE.std_logic_1164.all;
use work.arrays.all;
--use ieee.numeric_std.all;

entity tb_pipereg is
  generic(gCLK_Hper : time := 50 ns);
end tb_pipereg;

architecture behavioral of tb_pipereg is
  constant cCLK_Per : time := gCLK_HPER * 2;

component EX_MEM is
	port(
		i_Clk : in std_logic;
		i_Rst : in std_logic;
		i_We : in std_logic;
		i_RegDst, i_memToReg, i_RegWrite, i_andLink, i_lui : in std_logic_vector(0 downto 0);
		o_RegDst, o_memToReg, o_RegWrite, o_andLink, o_lui : out std_logic_vector(0 downto 0);
		i_memOP : in std_logic_vector(2 downto 0);
		o_memOP : out std_logic_vector(2 downto 0);
		i_ALU, i_Rdata2, i_PCplus4, i_imem, i_luiVal : in std_logic_vector(31 downto 0);
		o_ALU, o_Rdata2, o_PCplus4, o_imem, o_luiVal : out std_logic_vector(31 downto 0));
end component;

component ID_EX 
	port(
		i_Clk : in std_logic;
		i_Rst : in std_logic;
		i_Flush : in std_logic;
		i_We : in std_logic;
		i_RegDst, i_memToReg, i_ALUSrc, i_RegWrite, i_andLink, i_lui, i_jr, i_or : in std_logic_vector(0 downto 0);
		o_RegDst, o_memToReg, o_ALUSrc, o_RegWrite, o_andLink, o_lui, o_jr, o_or : out std_logic_vector(0 downto 0);
		i_ALUBOX_op : in std_logic_vector(1 downto 0);
		o_ALUBOX_op : out std_logic_vector(1 downto 0);
		i_memOP : in std_logic_vector(2 downto 0);
		o_memOP : out std_logic_vector(2 downto 0);
		i_ALUOP	: in std_logic_vector(3 downto 0);
		o_ALUOP	: out std_logic_vector(3 downto 0);
		i_Rdata1, i_Rdata2, i_Mux12, i_imem, i_PCplus4,  i_luiVal, i_alu_32_o_F_1, i_mux_9 : in std_logic_vector(31 downto 0); --i_uin,
		o_Rdata1, o_Rdata2, o_Mux12, o_imem, o_PCplus4,  o_luiVal, o_alu_32_o_F_1, o_mux_9 : out std_logic_vector(31 downto 0)); --o_uin,
end component;

component IF_ID
	port(
		i_Clk : in std_logic;
		i_Rst : in std_logic;
		i_We : in std_logic;
		i_IMem, i_PC : in std_logic_vector(31 downto 0);
		o_IMem, o_PC : out std_logic_vector(31 downto 0)) ;
end component;

component MEM_WB
	port(
		i_Clk : in std_logic;
		i_Rst : in std_logic;
		i_We : in std_logic;
		i_RegDst, i_RegWrite, i_andLink, i_lui : in std_logic_vector(0 downto 0);
		o_RegDst, o_RegWrite, o_andLink, o_lui : out std_logic_vector(0 downto 0);
		i_valueToWrite, i_PCplus4, i_imem, i_luiVal : in std_logic_vector(31 downto 0);
		o_valueToWrite, o_PCplus4, o_imem, o_luiVal : out std_logic_vector(31 downto 0));
end component;

-- signal for Clock
signal s_clock : std_logic;

-- signal for pipeline stalls
signal s_IFID_stall, s_IDEX_stall, s_EXMEM_stall, s_MEMWB_stall : std_logic;

--Notted version of the stall signals because the We needs to be high when we are writing, not low.
signal s_NOT_IFID_stall, s_NOT_IDEX_stall, s_NOT_EXMEM_stall, s_NOT_MEMWB_stall : std_logic;

--signals for pipeline flush
signal s_IFID_flush, s_IDEX_flush, s_EXMEM_flush, s_MEMWB_flush : std_logic;

signal s_RegDst : std_logic_vector(0 downto 0);
signal s_jump : std_logic_vector(0 downto 0);
signal s_branch : std_logic;
signal s_memRead : std_logic_vector(0 downto 0);
signal s_memtoReg : std_logic_vector(0 downto 0);
signal s_memWrite : std_logic_vector(0 downto 0);
signal s_ALUSrc : std_logic_vector(0 downto 0);
signal s_regWrite : std_logic_vector(0 downto 0);
signal s_andLink : std_logic_vector(0 downto 0);
signal s_bitwise : std_logic_vector(0 downto 0);
signal s_lui : std_logic_vector(0 downto 0);
signal s_jr : std_logic_vector(0 downto 0);
signal s_memOP : std_logic_vector(2 downto 0);
signal s_ALUBOX_op : std_logic_vector(1 downto 0);
signal s_alu_ctrl : std_logic_vector(1 downto 0);
signal s_ALUOp : std_logic_vector(3 downto 0);
-- signal s_controlConcat : std_logic_vector(18 downto 0);

-- signals for shifters
signal s_shift_left_2_0 : std_logic_vector(31 downto 0);
signal s_shift_left_2_1 : std_logic_vector(31 downto 0);
signal s_extender_16_32_signed : std_logic_vector(31 downto 0);
signal s_extender_16_32_unsigned_0 : std_logic_vector(31 downto 0);
signal s_shift_left_16 : std_logic_vector(31 downto 0);  -- added for lui

-- signals for alu's
signal s_alu_32_o_F_0 : std_logic_vector(31 downto 0);
signal s_alu_32_o_F_1 : std_logic_vector(31 downto 0);
signal s_alu_32_o_zero_1 : std_logic;
signal s_n_bit_adder_0 : std_logic_vector(31 downto 0); 
signal s_n_bit_adder_1 : std_logic_vector(31 downto 0);
signal s_n_bit_adder_2 : std_logic_vector(31 downto 0);
--signal s_Full_ALU : std_logic_vector(31 downto 0); --TODO commented by Curtis. This was never used. Was it supposed to by the same signal as s_mux_7?

-- signals for reg
signal s_RData1 : std_logic_vector(31 downto 0);
signal s_RData2 : std_logic_vector(31 downto 0);
  
-- signal for imem.
signal s_imem : std_logic_vector(31 downto 0);

-- signal for PC.
signal s_PC : std_logic_vector(31 downto 0); -- Diagram comment suggests that this is a 28-bit signal.

-- signal for AND gate.
--signal s_AND : std_logic;

-- signal for barrel shifter
signal s_barrel_shifter : std_logic_vector(31 downto 0);

-- signal for mult_32
signal s_mult_32 : std_logic_vector(31 downto 0);

--signal for luiVal after calulating it in IF
signal s_luiVal : std_logic_vector(31 downto 0);

-- signals for multiplexers.  Each multiplexer is named for the signals it selects between.
--signal s_mux_0 : std_logic_vector(31 downto 0); 
signal s_mux_1 : std_logic_vector(31 downto 0);
signal s_mux_2 : std_logic_vector(31 downto 0);
signal s_mux_3 : std_logic_vector(31 downto 0);
signal s_mux_4 : std_logic_vector(4 downto 0); -- Both of these registers 
signal s_mux_5 : std_logic_vector(4 downto 0); -- form the input for WReg on the reg component
signal s_mux_6 : std_logic_vector(31 downto 0);
signal s_mux_7 : std_logic_vector(31 downto 0);
signal s_mux_8 : std_logic_vector(31 downto 0);
signal s_mux_9 : std_logic_vector(31 downto 0);
signal s_mux_10: std_logic_vector(31 downto 0);
signal s_mux_11: std_logic_vector(4 downto 0);
signal s_mux_12: std_logic_vector(31 downto 0);
signal s_mux_13: std_logic_vector(31 downto 0);
signal s_mux_14: std_logic_vector(31 downto 0);
signal s_shiftedPC : std_logic_vector(11 downto 0); --TODO added by curtis

-- signals for forwarding muxes
signal s_forwarding_mux_0 : std_logic_vector(31 downto 0);
signal s_forwarding_mux_1 : std_logic_vector(31 downto 0);
signal s_forwarding_mux_2 : std_logic_vector(31 downto 0);
signal s_forwarding_mux_3 : std_logic_vector(31 downto 0);

-- signal for branch control
signal s_branch_control : std_logic_vector(0 downto 0);

-- signal for alu control
signal s_alu_control : std_logic_vector(6 downto 0);

-- signal for dmem
signal s_dmem : std_logic_vector(31 downto 0);

--signal for pipelined registers
----EX_MEM
signal s_EXMEM_RegDst, s_EXMEM_memToReg, s_EXMEM_RegWrite, s_EXMEM_andLink, s_EXMEM_lui : std_logic_vector(0 downto 0);
signal s_EXMEM_memOP : std_logic_vector(2 downto 0);
signal s_EXMEM_ALU, s_EXMEM_Rdata2, s_EXMEM_PCplus4, s_EXMEM_imem, s_EXMEM_luiVal : std_logic_vector(31 downto 0);

----ID_EX  
signal s_IDEX_RegDst, s_IDEX_memToReg, s_IDEX_ALUSrc, s_IDEX_RegWrite, s_IDEX_andLink, s_IDEX_lui, s_IDEX_jr, s_IDEX_or: std_logic_vector(0 downto 0);
signal s_IDEX_ALUBOX_op : std_logic_vector(1 downto 0);
signal s_IDEX_memOP : std_logic_vector(2 downto 0);
signal s_IDEX_ALUOP : std_logic_vector(3 downto 0); 
signal s_IDEX_Rdata1, s_IDEX_Rdata2, s_IDEX_Mux12, s_IDEX_imem, s_IDEX_PCplus4, s_IDEX_luiVal, s_IDEX_alu_32_o_F_1, s_IDEX_mux_9 : std_logic_vector(31 downto 0);

----IF_ID
signal s_IFID_IMem, s_IFID_PC : std_logic_vector(31 downto 0);

----MEM_WB     
signal s_MEMWB_RegDst, s_MEMWB_RegWrite, s_MEMWB_andLink, s_MEMWB_lui : std_logic_vector(0 downto 0);
signal s_MEMWB_valueToWrite, s_MEMWB_PCplus4, s_MEMWB_imem, s_MEMWB_luiVal : std_logic_vector(31 downto 0);

---- Forwarding_Control_Module
signal s_forwardA_branch : std_logic;
signal s_forwardB_branch : std_logic;
signal s_forwardA_ALU    : std_logic_vector(1 downto 0);
signal s_forwardB_ALU    : std_logic_vector(1 downto 0);

---- hazardControl
signal s_stall_IFIDandPC : std_logic;
signal s_stall_IDEX: std_logic;
signal s_flush_IDEX: std_logic_vector(0 downto 0);
signal s_flush_EXMEM : std_logic_vector(0 downto 0);
signal s_NOT_stall_IFIDandPC : std_logic;
signal s_NOT_stall_IDEX: std_logic;
signal s_branchHazard : std_logic;

--or
signal s_or : std_logic_vector(0 downto 0);


begin


s_NOT_IFID_stall <= not s_IFID_stall;
s_NOT_IDEX_stall <= not s_IDEX_stall;
s_NOT_EXMEM_stall <= not s_EXMEM_stall;
s_NOT_MEMWB_stall <= not s_MEMWB_stall;


-- -- start pipelined registers
-- IF_ID
  IFID : IF_ID
    port map(
      i_Clk => s_clock,
      i_Rst => s_IFID_flush,
      i_We  =>  s_NOT_IFID_stall,--'1',
      i_IMem => s_imem,
      i_PC => s_PC,
      o_IMem => s_IFID_IMem,
      o_PC => s_IFID_PC
             );

-- ID_EX
  IDEX : ID_EX
    port map(
      i_Clk => s_clock,
      i_Rst => s_IDEX_flush,
      i_Flush => s_IDEX_flush,
      i_We  => s_NOT_IDEX_stall,--'1',
      i_RegDst => s_RegDst,
      i_jr => s_jr,
      o_jr => s_IDEX_jr,
      i_or => s_or,
      o_or => s_IDEX_or,
      i_alu_32_o_F_1 => s_alu_32_o_F_1,
      o_alu_32_o_F_1 => s_IDEX_alu_32_o_F_1,
      i_mux_9 => s_mux_9,
      o_mux_9 => s_IDEX_mux_9,
      i_memToReg => s_memToReg,
      i_ALUSrc => s_ALUSrc,
      i_RegWrite => s_RegWrite,
      i_andlink => s_andlink,
      i_lui => s_lui,
      o_RegDst => s_IDEX_RegDst,
      o_memToReg => s_IDEX_memToReg,
      o_ALUSrc => s_IDEX_ALUSrc,
      o_RegWrite => s_IDEX_RegWrite,
      o_andLink => s_IDEX_andLink,
      o_lui => s_IDEX_lui,
      i_ALUBOX_op => s_ALUBOX_op,
      o_ALUBOX_op => s_IDEX_ALUBOX_op,
      i_ALUOP => s_ALUOP,
      i_memOP => s_memOP,
      o_ALUOP => s_IDEX_ALUOP,
      o_memOP => s_IDEX_memOP,
      i_Rdata1 => s_RData1,
      i_Rdata2 => s_RData2,
      i_Mux12 => s_mux_12,
      i_imem => s_IFID_IMem,
      i_PCplus4 => s_n_bit_adder_1,
      i_luiVal => s_luiVal,
      o_Rdata1 => s_IDEX_Rdata1,
      o_Rdata2 => s_IDEX_Rdata2,
      o_Mux12 => s_IDEX_Mux12,
      o_imem => s_IDEX_imem,
      o_PCplus4 => s_IDEX_PCplus4,
      o_luiVal => s_IDEX_luiVal
		);

-- EX_MEM
  EXMEM : EX_MEM
    port map(
      i_Clk => s_clock,
      i_Rst => s_EXMEM_flush,--i_regReset,
      i_We  => s_NOT_EXMEM_stall,
      i_RegDst  => s_IDEX_RegDst,
      i_memToReg  => s_IDEX_memToReg, 
      i_RegWrite  => s_IDEX_RegWrite, 
      i_andLink  => s_IDEX_andLink, 
      i_lui   => s_IDEX_lui,
      o_RegDst  => s_EXMEM_RegDst, 
      o_memToReg  => s_EXMEM_memToReg, 
      o_RegWrite  => s_EXMEM_RegWrite, 
      o_andLink  => s_EXMEM_andLink, 
      o_lui  => s_EXMEM_lui,
      i_memOP  => s_IDEX_memOP,
      o_memOP  => s_EXMEM_memOP,
      i_ALU  => s_mux_7, 
      i_Rdata2  => s_IDEX_Rdata2, 
      i_PCplus4  => s_IDEX_PCplus4, 
      i_imem   => s_IDEX_imem,
      i_luiVal => s_IDEX_luiVal,
      o_ALU  => s_EXMEM_ALU , 
      o_Rdata2  => s_EXMEM_Rdata2, 
      o_PCplus4  => s_EXMEM_PCplus4, 
      o_imem => s_EXMEM_imem,
      o_luiVal => s_EXMEM_luiVal
            );

-- MEM_WB
  MEMWB : MEM_WB
    port map(
      i_Clk => s_clock,
      i_Rst => s_MEMWB_flush,
      i_We  => s_NOT_MEMWB_stall,
      i_RegDst => s_EXMEM_RegDst, 
      i_RegWrite => s_EXMEM_RegWrite, 
      i_andLink => s_EXMEM_andLink, 
      i_lui => s_EXMEM_lui,
      o_RegDst => s_MEMWB_RegDst, 
      o_RegWrite => s_MEMWB_RegWrite, 
      o_andLink => s_MEMWB_andLink, 
      o_lui  => s_MEMWB_lui,
      i_valueToWrite => s_mux_10, 
      i_PCplus4 => s_EXMEM_PCplus4,
      i_imem => s_EXMEM_imem, 
      i_luiVal => s_EXMEM_luiVal,
      o_valueToWrite => s_MEMWB_valueToWrite, 
      o_PCplus4 => s_MEMWB_PCplus4, 
      o_imem => s_MEMWB_imem, 
      o_luiVal => s_MEMWB_luiVal
            );
-- -- end pipelined registers


  P_CLK: process
  begin
    s_clock <= '0';
    wait for gCLK_HPER;
    s_clock <= '1';
    wait for gCLK_HPER;
  end process;
  
  TB: process
    begin
	s_imem <= x"BA5EBA11"; --baseball!
	s_IDEX_flush <= '1';
	s_IFID_flush <= '1';
	s_EXMEM_flush <= '1';
	s_MEMWB_flush <= '1';

	s_IDEX_stall <= '0';
	s_IFID_stall <= '0';
	s_EXMEM_stall <= '0';
	s_MEMWB_stall <= '0';
		
wait for cClk_per;
	s_IDEX_flush <= '0';
	s_IFID_flush <= '0';
	s_EXMEM_flush <= '0';
	s_MEMWB_flush <= '0';


	wait for cClk_per;
	s_imem <= x"00000000";
	wait for cClk_per*3;

	s_imem <= x"B00B1EE5"; --stuff!
	s_IFID_stall <= '1';
	wait for cClk_per;
	s_IFID_stall <= '0';
	s_IDEX_stall <= '1';
	s_EXMEM_stall <= '1';
	s_MEMWB_stall <= '1';
	wait for cClk_per;
	wait for cClk_per;
	s_IDEX_stall <= '0';
	wait for cClk_per;
	wait for cClk_per;
	s_EXMEM_stall <= '0';
	wait for cClk_per;
	wait for cClk_per;
	s_MEMWB_stall <= '0';
	wait for cClk_per;
	s_IFID_stall <= '1';
	s_IDEX_stall <= '1';
	s_EXMEM_stall <= '1';
	s_MEMWB_stall <= '1';
	s_IFID_flush <= '1';
	wait for cClk_per;
	s_IFID_flush <= '0';
	s_IDEX_flush <= '1';
	wait for cClk_per;
	s_IDEX_flush <= '0';
	s_EXMEM_flush <= '1';
	wait for cClk_per;
	s_EXMEM_flush <= '0';
	s_MEMWB_flush <= '1';
	wait for cClk_per;
	s_MEMWB_flush <= '0';


    wait;  
  end process;

end behavioral;