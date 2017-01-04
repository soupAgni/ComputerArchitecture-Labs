library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Pipereg is
  generic(gCLK_Hper : time := 50 ns);
end tb_Pipereg;


architecture behavior of tb_Pipereg  is
   constant cCLK_Per : time := gCLK_HPER * 2;
  component ifToIDReg is
	port(Clk      : in std_logic;
		   Reset    : in std_logic;
		   WE       : in std_logic;
		   instMem  : in std_logic_vector(31 downto 0);
		   PCplus4  : in std_logic_vector(31 downto 0);
		   o_instMem: out std_logic_vector(31 downto 0);
		   o_PCplus4: out std_logic_vector(31 downto 0));
end component;

component idToExReg is
	port(Clk              : in std_logic;
		   Reset            : in std_logic;
		   Flush            : in std_logic;
		   WE               : in std_logic;
		   RegDst           : in std_logic;
		   IsLoad           : in std_logic;
		   IsLink           : in std_logic;
		   Reg_w_en         : in std_logic;
		   UpperImm         : in std_logic;
		   dmem_w_en        : in std_logic;
		   IsImmALU         : in std_logic;
		  -- IsRtype          : in std_logic;
		   IsLoadU          : in std_logic;
		   branchAnd        : in std_logic;
		   operation        : in std_logic_vector(2 downto 0);
       ALUsel           : in std_logic_vector(1 downto 0);
       issv             : in std_logic;
       isJumpReg        : in std_logic;
       isLinkALU        : in std_logic;
       reg_w_enANDAlu_write : in std_logic;
       ALU_write        : in std_logic;
       isUnsignedALU    : in std_logic;
		   TypeSel          : in std_logic_vector(1 downto 0);
		   ALU_OP	          : in std_logic_vector(5 downto 0);
		  --- branch_jump_mux  : in std_logic_vector(31 downto 0);
		   RegData1         : in std_logic_vector(31 downto 0);
		   RegData2         : in std_logic_vector(31 downto 0);
		   instMem          : in std_logic_vector(31 downto 0); 
		   PCplus4          : in std_logic_vector(31 downto 0); 
		   upperImmVal      : in std_logic_vector(31 downto 0); 
		   branchALU        : in std_logic_vector(31 downto 0); 
		   ImmSignExt       : in std_logic_vector(31 downto 0);
       o_branchAnd      : out std_logic;
		   o_operation      : out std_logic_vector(2 downto 0);
       o_ALUsel         : out std_logic_vector(1 downto 0);
       o_issv           : out std_logic;
       o_isJumpReg      : out std_logic;
       o_isLinkALU      : out std_logic;
       o_ALU_write      : out std_logic;
       o_isUnsignedALU  : out std_logic;
		   o_IsImmALU       : out std_logic;
		   o_reg_w_enANDAlu_write : out std_logic;
		  -- o_IsRtype        : out std_logic;
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		   o_instMem        : out std_logic_vector(31 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)); 
end component;


component exToMemReg is
	port(Clk           : in std_logic;
	     Reset         : in std_logic;
		   WE            : in std_logic;
	    	RegDst        : in std_logic;
		   isLoad        : in std_logic;
		   isLoadU       : in std_logic;
		   reg_w_en      : in std_logic;
		   dmem_w_en     : in std_logic;
		   isLinkALU     : in std_logic;
		   ALU_write     : in std_logic;
		   isJumpReg     : in std_logic;
		   isLink        : in std_logic;
		   upperImm      : in std_logic;
		   TypeSel       : in std_logic_vector(1 downto 0);
		   ALUVal        : in std_logic_vector(31 downto 0);
		   RegData2      : in std_logic_vector(31 downto 0);
		   PCplus4       : in std_logic_vector(31 downto 0);
		   instMem       : in std_logic_vector(31 downto 0);
		   upperImmVal   : in std_logic_vector(31 downto 0);
		   o_RegDst      : out std_logic;
		   o_isLoad      : out std_logic;
	    	o_isLoadU     : out std_logic;
		   o_Reg_w_en    : out std_logic;
		   o_dmem_w_en   : out std_logic;
		   o_ALUwrite    : out std_logic;
		   o_isJumpReg   : out std_logic;
		   o_isLink      : out std_logic;
		   o_isLinkALU   : out std_logic;
		   o_UpperImm    : out std_logic;
		   o_TypeSel     : out std_logic_vector(1 downto 0);
		   o_ALUVal      : out std_logic_vector(31 downto 0);
		   o_RegData2    : out std_logic_vector(31 downto 0);
		   o_PCplus4     : out std_logic_vector(31 downto 0);
		   o_instMem     : out std_logic_vector(31 downto 0);
		   o_upperImmVal : out std_logic_vector(31 downto 0));
end component;

component memToWritebackReg is
	port(Clk             : in std_logic;
		   Reset           : in std_logic;
		   WE              : in std_logic;
		   RegDst          : in std_logic;
		   Reg_w_en        : in std_logic;
		   ALUwrite        : in std_logic;
		   isJumpReg       : in std_logic;
		   isLink          : in std_logic;
		   isLinkALU       : in std_logic;
		   UpperImm        : in std_logic;
		   ValToReg        : in std_logic_vector(31 downto 0);
		   MEMWB_PCplus4   : in std_logic_vector(31 downto 0);
		   instMem         : in std_logic_vector(31 downto 0);
		   upperImmVal     : in std_logic_vector(31 downto 0);
		   o_RegDst        : out std_logic;
		   o_Reg_w_en      : out std_logic;
		   o_ALUwrite      : out std_logic;
		   o_isJumpReg     : out std_logic;
		   o_isLink        : out std_logic;
		   o_isLinkALU     : out std_logic;
		   o_UpperImm      : out std_logic;
		   o_ValToReg      : out std_logic_vector(31 downto 0);
		   o_MEMWB_PCplus4 : out std_logic_vector(31 downto 0);
		   o_instMem       : out std_logic_vector(31 downto 0);
		   o_upperImmVal   : out std_logic_vector(31 downto 0));
end component;

signal s_Clk,s_IFID_reset, s_IFID_WE: std_logic;

signal s_o_instMem ,s_o_PCplus4 , s_instMem, s_PCplus4: std_logic_vector(31 downto 0);
signal s_IDEX_reset ,s_IDEX_Flush, s_IDEX_WE, s_IDEX_RegDst , s_IDEX_IsLoad, s_IDEX_IsLink , s_IDEX_Reg_w_en  , s_IDEX_UpperImm, s_IDEX_dmem_w_en , s_IDEX_IsImmALU ,s_IDEX_IsRtype,s_IDEX_IsLoadU,s_IDEX_branchAnd  : std_logic;
signal s_IDEX_operation : std_logic_vector(2 downto 0);
signal s_IDEX_ALUsel    : std_logic_vector(1 downto 0);
signal s_IDEX_issv,s_IDEX_isJumpReg,s_IDEX_isLinkALU ,s_reg_w_enANDAlu_write,s_IDEX_ALU_write,s_IDEX_isUnsignedALU   : std_logic;
signal  s_IDEX_TypeSel : std_logic_vector(1 downto 0);
signal s_IDEX_ALU_OP : std_logic_vector(5 downto 0);
signal s_IDEX_RegData1,s_IDEX_RegData2, s_IDEX_upperImmVal,s_IDEX_branchALU ,s_IDEX_ImmSignExt : std_logic_vector(31 downto 0);
signal  s_IDEX_o_branchAnd : std_logic;
signal s_IDEX_o_operation :std_logic_vector(2 downto 0);
signal s_IDEX_o_ALUsel  :std_logic_vector(1 downto 0);
signal s_IDEX_o_issv, s_IDEX_o_isJumpReg , s_IDEX_o_isLinkALU, s_IDEX_o_ALU_write ,s_IDEX_o_isUnsignedALU,s_IDEX_o_IsImmALU ,s_IDEX_o_RegDst,s_IDEX_o_isLoadU,s_IDEX_o_Reg_w_en ,s_IDEX_o_UpperImm ,s_IDEX_o_isLink,s_IDEX_o_dmem_w_en,s_IDEX_o_isLoad   : std_logic;
signal s_IDEX_o_TypeSel : std_logic_vector(1 downto 0);
signal s_IDEX_o_ALU_OP  : std_logic_vector(5 downto 0);
signal  s_IDEX_o_instMem,s_ExMem_ALUVal  : std_logic_vector(31 downto 0);
signal s_IDEX_o_RegData1 , s_IDEX_o_RegData2,s_IDEX_o_ImmSignExt,s_IDEX_o_PCplus4,s_IDEX_o_upperImmVal,s_IDEX_o_branchALU   : std_logic_vector(31 downto 0);
signal s_ExMem_reset ,s_ExMem_WE : std_logic;
signal s_ExMem_o_RegDst , s_ExMem_o_isLoad,s_ExMem_o_isLoadU ,s_ExMem_o_Reg_w_en,s_ExMem_o_dmem_w_en,s_ExMem_o_ALU_write,s_ExMem_o_isJumpReg,s_ExMem_o_isLink,s_ExMem_o_isLinkALU,s_ExMem_o_UpperImm : std_logic;
signal s_ExMem_o_TypeSel : std_logic_vector(1 downto 0);
signal s_ExMem_o_ALUVal,s_ExMem_o_RegData2 ,s_ExMem_o_PCplus4,s_ExMem_o_instMem,s_ExMem_o_upperImmVal : std_logic_vector(31 downto 0);
signal s_MemWB_reset ,s_MemWB_WE : std_logic;
---signal s_MemWB_valToReg : std_logic_vector(31 downto 0);
signal s_MemWB_o_RegDst,s_MemWB_o_Reg_w_en ,s_MemWB_o_ALUwrite ,s_MemWB_o_isJumpReg ,s_MemWB_o_isLink,s_MemWB_o_isLinkALU,s_MemWB_o_UpperImm : std_logic;
signal s_MemWB_o_ValToReg,s_o_MEMWB_PCplus4 ,s_MemWB_o_instMem,s_MemWB_o_upperImmVal : std_logic_vector(31 downto 0);

begin
DUT: ifToIDReg
   port map(
    CLK  => s_Clk,  
    Reset   =>  s_IFID_reset,
    WE      => s_IFID_WE,
    instMem => s_instMem,
    PCplus4 => s_PCplus4,
    o_instMem => s_o_instMem,
    o_PCplus4  =>s_o_PCplus4  
     );

DUT2: idToExReg

port map(Clk              => s_Clk,
		   Reset            => s_IDEX_reset,
		   Flush           => s_IDEX_Flush,
		   WE              => s_IDEX_WE,
		   RegDst           => s_IDEX_RegDst ,
		   IsLoad           => s_IDEX_IsLoad,
		   IsLink           => s_IDEX_IsLink ,
		   Reg_w_en         => s_IDEX_Reg_w_en  ,
		   UpperImm         => s_IDEX_UpperImm,
		   dmem_w_en       => s_IDEX_dmem_w_en ,
		   IsImmALU         => s_IDEX_IsImmALU ,
		   IsLoadU          => s_IDEX_IsLoadU,
		   branchAnd      => s_IDEX_branchAnd,
		   operation        => s_IDEX_operation,
       ALUsel           => s_IDEX_ALUsel,
       issv             => s_IDEX_issv,
       isJumpReg        => s_IDEX_isJumpReg,
       isLinkALU       => s_IDEX_isLinkALU ,
       reg_w_enANDAlu_write => s_reg_w_enANDAlu_write,
       ALU_write       => s_IDEX_ALU_write,
       isUnsignedALU    => s_IDEX_isUnsignedALU ,
		   TypeSel          =>  s_IDEX_TypeSel,
		   ALU_OP	         => s_IDEX_ALU_OP ,
		   RegData1         => s_IDEX_RegData1,
		   RegData2         => s_IDEX_RegData2,
		   instMem          => s_o_instMem,
		   PCplus4         =>  s_o_PCplus4,
		   upperImmVal      => s_IDEX_UpperImmVal,
		   branchALU        => s_IDEX_branchALU ,
		   ImmSignExt       => s_IDEX_ImmSignExt,
       o_branchAnd      => s_IDEX_o_branchAnd,
		   o_operation      => s_IDEX_o_operation ,
       o_ALUsel         => s_IDEX_o_ALUsel,
       o_issv          => s_IDEX_o_issv,
       o_isJumpReg      => s_IDEX_o_isJumpReg ,
       o_isLinkALU     => s_IDEX_o_isLinkALU,
       o_ALU_write      => s_IDEX_o_ALU_write ,
       o_isUnsignedALU  => s_IDEX_o_isUnsignedALU,
		   o_IsImmALU       => s_IDEX_o_IsImmALU ,
		   o_RegDst        => s_IDEX_o_RegDst,
		   o_isLoadU        => s_IDEX_o_isLoadU,
		   o_Reg_w_en       => s_IDEX_o_Reg_w_en,
		   o_UpperImm       => s_IDEX_o_UpperImm,
		   o_isLink         => s_IDEX_o_isLink,
		   o_dmem_w_en      => s_IDEX_o_dmem_w_en,
		   o_isLoad         => s_IDEX_o_isLoad ,
		   o_TypeSel       => s_IDEX_o_TypeSel ,
		   o_ALU_OP	       => s_IDEX_o_ALU_OP,
		   o_instMem        => s_IDEX_o_instMem ,
		   o_RegData1      => s_IDEX_o_RegData1 ,
		   o_RegData2     => s_IDEX_o_RegData2,
		   o_ImmSignExt     => s_IDEX_o_ImmSignExt,
		   o_PCplus4        => s_IDEX_o_PCplus4,
		   o_upperImmVal    => s_IDEX_o_upperImmVal,
		   o_branchALU      => s_IDEX_o_branchALU
		   );

DUT3: exToMemReg
port map(Clk           => s_Clk,
	     Reset        => s_ExMem_reset ,
		   WE            => s_ExMem_WE,
	    	RegDst        => s_IDEX_o_RegDst,
		   isLoad        => s_IDEX_o_isLoad,
		   isLoadU      => s_IDEX_o_isLoadU,
		   reg_w_en      => s_IDEX_o_Reg_w_en,
		   dmem_w_en    => s_IDEX_o_dmem_w_en,
		   isLinkALU    => s_IDEX_o_isLinkALU,
		   ALU_write    => s_IDEX_o_ALU_write ,
		   isJumpReg   =>  s_IDEX_o_isJumpReg ,
		   isLink       => s_IDEX_o_isLink,
		   upperImm      => s_IDEX_o_UpperImm,
		   TypeSel     =>  s_IDEX_o_TypeSel ,
		   ALUVal     =>    s_ExMem_ALUVal,
		   RegData2   =>   s_IDEX_o_RegData2,
		   PCplus4     => s_IDEX_o_PCplus4,  
		   instMem     => s_IDEX_o_instMem ,
		   upperImmVal  =>  s_IDEX_o_upperImmVal,
		   o_RegDst      => s_ExMem_o_RegDst ,
		   o_isLoad      => s_ExMem_o_isLoad,
	    	o_isLoadU    => s_ExMem_o_isLoadU ,
		   o_Reg_w_en    => s_ExMem_o_Reg_w_en,
		   o_dmem_w_en   => s_ExMem_o_dmem_w_en,
		   o_ALUwrite   => s_ExMem_o_ALU_write,
		   o_isJumpReg   => s_ExMem_o_isJumpReg,
		   o_isLink      => s_ExMem_o_isLink,
		   o_isLinkALU   => s_ExMem_o_isLinkALU,
		   o_UpperImm   => s_ExMem_o_UpperImm ,
		   o_TypeSel    => s_ExMem_o_TypeSel,
		   o_ALUVal     => s_ExMem_o_ALUVal ,
		   o_RegData2   => s_ExMem_o_RegData2,
		   o_PCplus4     => s_ExMem_o_PCplus4,
		   o_instMem   => s_ExMem_o_instMem,
		   o_upperImmVal => s_ExMem_o_upperImmVal
		   );

DUT4: memToWritebackReg 
	port map(Clk         => s_Clk,
		   Reset           => s_MemWB_reset,
		   WE              => s_MemWB_WE,
		   RegDst          => s_ExMem_o_RegDst ,
		   Reg_w_en        => s_ExMem_o_Reg_w_en,
		   ALUwrite       =>  s_ExMem_o_ALU_write,
		   isJumpReg      => s_ExMem_o_isJumpReg,
		   isLink         => s_ExMem_o_isLink,
		   isLinkALU       => s_ExMem_o_isLinkALU, 
		   UpperImm        => s_ExMem_o_UpperImm,
		   ValToReg        =>  s_ExMem_o_ALUVal,
		   MEMWB_PCplus4  => s_ExMem_o_PCplus4,
		   instMem        => s_ExMem_o_instMem,
		   upperImmVal    => s_ExMem_o_upperImmVal,
		   o_RegDst        =>s_MemWB_o_RegDst,
		   o_Reg_w_en     => s_MemWB_o_Reg_w_en,
		   o_ALUwrite     => s_MemWB_o_ALUwrite ,
		   o_isJumpReg     => s_MemWB_o_isJumpReg, 
		   o_isLink        => s_MemWB_o_isLink,
		   o_isLinkALU     => s_MemWB_o_isLinkALU,
		   o_UpperImm     => s_MemWB_o_UpperImm,
		   o_ValToReg      => s_MemWB_o_ValToReg ,
		   o_MEMWB_PCplus4 => s_o_MEMWB_PCplus4 ,
		   o_instMem      => s_MemWB_o_instMem,
		   o_upperImmVal  =>s_MemWB_o_upperImmVal  );

  P_CLK: process
  begin
    s_Clk <= '1';
    wait for gCLK_HPER;
    s_Clk <= '0';
    wait for gCLK_HPER;
  end process;
  
  
  
 TB: process
    begin
 -- confused on what to put through here     
 s_IFID_reset <= '0';
 s_IFID_WE <= '0';
 s_instMem <= x"20810008";-- addi $1, $4, 8
 s_PCplus4 <= x"00000000";
 s_IDEX_reset <= '0';
 s_IDEX_Flush <= '0';
 s_IDEX_WE <= '0';
 s_IDEX_RegDst <= '0';
 s_IDEX_IsLoad <= '0';
 s_IDEX_IsLink <= '0';
 s_IDEX_Reg_w_en <= '1';
  s_IDEX_UpperImm <= '0';
  s_IDEX_dmem_w_en <= '0';
  s_IDEX_IsImmALU <= '1';
  s_IDEX_IsRtype <= '0';
  s_IDEX_IsLoadU <= '0';
  s_IDEX_branchAnd <= '0';
  s_IDEX_operation <= "010";
  s_IDEX_ALUsel <= "10";
  s_IDEX_issv <= '0';
  s_IDEX_isJumpReg <= '0';
  s_IDEX_isLinkALU <= '0';
  s_reg_w_enANDAlu_write <= '1';
  s_IDEX_isUnsignedALU  <= '0';
  s_IDEX_TypeSel <= "11";
  s_IDEX_ALU_OP <= "001000";
  s_IDEX_RegData1 <= x"FFFFFFFF";
   s_IDEX_RegData2 <= x"0ABBCDEF";
   s_IDEX_UpperImmVal <= x"10010000";
   s_IDEX_branchALU <= x"0FBB1000";
   s_IDEX_ImmSignExt <= x"FDBB0000";
    s_ExMem_ALUVal <= x"00000100";
  s_IDEX_ALU_write <= '0';
 s_ExMem_reset <= '0';
  s_ExMem_WE <= '0';
  s_MemWB_reset <= '0';
 s_MemWB_WE <= '0';
 
 
--- wait for gCLK_HPER; 
 s_IFID_reset <= '0';
 s_IFID_WE <= '1';
 s_instMem <= x"20810008";-- addi $1, $4, 8
 s_PCplus4 <= x"00000000";
 s_IDEX_reset <= '0';
 s_IDEX_Flush <= '0';
 s_IDEX_WE <= '1';
 s_IDEX_RegDst <= '0';
 s_IDEX_IsLoad <= '0';
 s_IDEX_IsLink <= '0';
 s_IDEX_Reg_w_en <= '1';
  s_IDEX_UpperImm <= '0';
  s_IDEX_dmem_w_en <= '0';
  s_IDEX_IsImmALU <= '1';
  s_IDEX_IsRtype <= '0';
  s_IDEX_IsLoadU <= '0';
  s_IDEX_branchAnd <= '0';
  s_IDEX_operation <= "010";
  s_IDEX_ALUsel <= "10";
  s_IDEX_issv <= '0';
  s_IDEX_isJumpReg <= '0';
  s_IDEX_isLinkALU <= '0';
  s_reg_w_enANDAlu_write <= '1';
  s_IDEX_isUnsignedALU  <= '0';
  s_IDEX_TypeSel <= "11";
  s_IDEX_ALU_OP <= "001000";
  s_IDEX_RegData1 <= x"FFFFFFFF";
   s_IDEX_RegData2 <= x"0ABBCDEF";
   s_IDEX_UpperImmVal <= x"10010000";
   s_IDEX_branchALU <= x"0FBB1000";
   s_IDEX_ImmSignExt <= x"FDBB0000";
    s_ExMem_ALUVal <= x"00000100";
  s_IDEX_ALU_write <='0';
 s_ExMem_reset <= '0';
  s_ExMem_WE <= '1';
  s_MemWB_reset <= '0';
 s_MemWB_WE <= '1';
 
-- wait for gCLK_HPER; 
 -- wait for gCLK_HPER; 
 s_IFID_reset <= '0';
 s_IFID_WE <= '1';
 s_instMem <= x"20810008";-- addi $1, $4, 8
 s_PCplus4 <= x"00000000";
 s_IDEX_reset <= '0';
 s_IDEX_Flush <= '0';
 s_IDEX_WE <= '1';
 s_IDEX_RegDst <= '0';
 s_IDEX_IsLoad <= '0';
 s_IDEX_IsLink <= '0';
 s_IDEX_Reg_w_en <= '1';
  s_IDEX_UpperImm <= '1';
  s_IDEX_dmem_w_en <= '0';
  s_IDEX_IsImmALU <= '1';
  s_IDEX_IsRtype <= '0';
  s_IDEX_IsLoadU <= '1';
  s_IDEX_branchAnd <= '0';
  s_IDEX_operation <= "001";
  s_IDEX_ALUsel <= "10";
  s_IDEX_issv <= '1';
  s_IDEX_isJumpReg <= '1';
  s_IDEX_isLinkALU <= '1';
  s_reg_w_enANDAlu_write <= '1';
  s_IDEX_isUnsignedALU  <= '0';
  s_IDEX_TypeSel <= "10";
  s_IDEX_ALU_OP <= "001000";
  s_IDEX_RegData1 <= x"FFFFFFFF";
   s_IDEX_RegData2 <= x"0ABBCDEF";
   s_IDEX_UpperImmVal <= x"10010000";
   s_IDEX_branchALU <= x"0FBB1000";
   s_IDEX_ImmSignExt <= x"FDBB0000";
    s_ExMem_ALUVal <= x"00000100";
  s_IDEX_ALU_write <='1';
 s_ExMem_reset <= '0';
  s_ExMem_WE <= '1';
  s_MemWB_reset <= '0';
 s_MemWB_WE <= '1';
 
-- wait for gCLK_HPER; 
wait for 1000 ms;
 
end process;

end behavior;
