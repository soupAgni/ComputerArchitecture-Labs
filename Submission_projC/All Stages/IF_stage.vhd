library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity IF_stage is
  generic(N : integer := 32;
          mif_filename 	: string := "i_mem.mif");
  port(CLK : in std_logic;
       PC_reset: in std_logic;
       IFID_reset : in std_logic;
       MEMWB_isJumpReg :in std_logic;
       mux_ORval : in std_logic;
       reg_WE     :in std_logic;
       IDEX_branchJump : in std_logic_vector(31 downto 0);
       IDEX_rs     : in std_logic_vector(31 downto 0);
       o_instMem: out std_logic_vector(31 downto 0);
		   o_PCplus4: out std_logic_vector(31 downto 0));
		 
end IF_stage;

architecture structure of IF_stage is
   
component mux2to1
  generic(N : integer := 32);
  port (i_A        : in  std_logic_vector(N-1 downto 0);
        i_B        : in  std_logic_vector(N-1 downto 0);
        i_S        : in  std_logic;
        o_F        : out std_logic_vector(N-1 downto 0));
end component;

component register_Nbit is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(32-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(32-1 downto 0));   -- Data value output
end component;

component i_mem
  	generic(depth_exp_of_2 	: integer := 10;
			     mif_filename 	: string := "i_mem.mif");
  port(address			: IN  STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
       byteena			: IN  STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
       clock			: IN  STD_LOGIC := '1';
       data			: IN  STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
       wren			: IN  STD_LOGIC := '0';
       q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)); 
end component;

component AddSub
  generic(N : integer := 32);
  port (A   		    : in  std_logic_vector(N-1 downto 0);
        B 		      : in  std_logic_vector(N-1 downto 0);
	      nAdd_Sub  : in  std_logic;
	      o_S 		    : out std_logic_vector(N-1 downto 0);
	      o_C 		    : out std_logic);
end component;	      
	      
component ifToIDReg 
	port(Clk      : in std_logic;
		   Reset    : in std_logic;
		   WE       : in std_logic;
		   instMem  : in std_logic_vector(31 downto 0);
		   PCplus4  : in std_logic_vector(31 downto 0);
		   o_instMem: out std_logic_vector(31 downto 0);
		   o_PCplus4: out std_logic_vector(31 downto 0));
end component;

       
 signal  s_IF_IMEM, s_PCp4, s_PC_val: std_logic_vector(31 downto 0);
 
 
 signal  s_mux1_out, s_mux2_out: std_logic_vector(31 downto 0);
 
 SIGNAL  s_reg_WE : std_logic;

 begin
   
   s_reg_WE   <= reg_WE;
   
   
   mux1: mux2to1
   port map(i_A => IDEX_rs,
            i_B => IDEX_branchJump,
            i_S => MEMWB_isJumpReg,
            o_F => s_mux1_out); 
   
  mux2: mux2to1
   port map(i_A => s_mux1_out,
            i_B => s_PCp4,
            i_S => mux_ORval,
            o_F => s_mux2_out);
   
   
    PC_reg : register_Nbit
   port map(i_CLK => CLK, 
            i_RST => PC_reset,
            i_WE  => '1',
            i_D   => s_mux2_out,
            o_Q   => s_PC_val); 

   
   instr_mem : i_mem
   generic map(mif_filename => mif_filename)
   port map(address => s_PC_val(11 downto 2),
	          byteena => "0000",
	          clock => CLK,
	          data => x"00000000",
            wren => '0',
	          q => s_IF_IMEM);
	          
	 PC_adder: AddSub
   port map(A => s_PC_val,
            B => x"00000004",
            nAdd_Sub => '0',
            o_S => s_PCp4);  
       
 
    
 IFID  : ifToIDReg
  
  port MAP  (Clk  => CLK,
		   Reset    => IFID_reset,
		   WE       => s_reg_WE,
		   instMem  => s_IF_IMEM,
		   PCplus4  => s_PCp4,
		   o_instMem=> o_instMem,
		   o_PCplus4=> o_PCplus4);
       
   --- Next Level ID/EX---
    
           
end structure;