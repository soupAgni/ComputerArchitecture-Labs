library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity ID_stage is
  generic(N : integer := 32);
  port(CLK              : in std_logic;
       IDEX_reset       : in std_logic;
       Regfile_reset    : in std_logic;
       IDEX_WE          : in std_logic;
       IDEX_Flush       : in std_logic;
       IFID_AdderVal    : in std_logic_vector(31 downto 0) ;
       IFID_instMem     : in std_logic_vector(31 downto 0);
       MEMWB_instMem    : in std_logic_vector(31 downto 0); 
       MEMWB_upperImmVal: in std_logic_vector(31 downto 0);
       ValtoReg_File    : in std_logic_vector(31 downto 0);
       MemWB_PCPlus4    : in std_logic_vector(31 downto 0);
       MEMWB_ALUWrite   : in std_logic;
       MEMWB_isLinkALU  : in std_logic;
       MEMWB_RegDest    : in std_logic;
       MEMWB_IsLink     : in std_logic;
       MemWB_upperImm   : in std_logic;
       MemWB_RegW_en    : in std_logic;
       forwardA_Branch  : in std_logic_vector(2 downto 0);
       forwardB_Branch  : in std_logic_vector(2 downto 0);
       ExMem_ALU        : in std_logic_vector(31 downto 0); --- 
       IDEX_ALUval      : in std_logic_vector(31 downto 0); ---
       EXMEM_PCplus4    : in std_logic_vector(31 downto 0);
       EXMEM_UpperImm   : in std_logic_vector(31 downto 0); 
       IDEX_UpperImm    : in std_logic_vector(31 downto 0); ---
       out_ID_rs_output : out std_logic_vector(31 downto 0);  -- new
       o_IFID_instMem   : out std_logic_vector(31 downto 0);
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
		   --o_IsRtype        : out std_logic;   -- dont need this anymore
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		 --  o_instMem        : out std_logic_vector(31 downto 0);
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_branch_jump_mux: out std_logic_vector(31 downto 0);
		   o_muxORval       : out std_logic;   ---  feeding as an output from ID stage and input to IF stage
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)
      );
		 
end ID_stage;

architecture structure of ID_stage is
  
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
		 --  IsRtype          : in std_logic;
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
		  -- branch_jump_mux  : in std_logic_vector(31 downto 0);
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
		 --  o_IsRtype        : out std_logic;
		   o_RegDst         : out std_logic;
		   o_isLoadU        : out std_logic;
		   o_Reg_w_en       : out std_logic;
		   o_UpperImm       : out std_logic;
		   o_isLink         : out std_logic;
		   o_dmem_w_en      : out std_logic;
		   o_isLoad         : out std_logic;
		   o_TypeSel        : out std_logic_vector(1 downto 0);
		   o_ALU_OP	        : out std_logic_vector(5 downto 0);
		  -- o_branch_jump_mux: out std_logic_vector(31 downto 0);  --remove
		   o_instMem        : out std_logic_vector(31 downto 0);
		   o_RegData1       : out std_logic_vector(31 downto 0);
		   o_RegData2       : out std_logic_vector(31 downto 0);
		   o_ImmSignExt     : out std_logic_vector(31 downto 0);
		   o_PCplus4        : out std_logic_vector(31 downto 0);
		   o_upperImmVal    : out std_logic_vector(31 downto 0);
		   o_branchALU      : out std_logic_vector(31 downto 0)); 
end component;
  
component or2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component and2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;
   
component mux2to1
  generic(N : integer := 32);
  port (i_A        : in  std_logic_vector(N-1 downto 0);
        i_B        : in  std_logic_vector(N-1 downto 0);
        i_S        : in  std_logic;
        o_F        : out std_logic_vector(N-1 downto 0));
end component;

component MIPS_register_file is
  generic (N : integer := 32);
  port(CLK            : in  std_logic;
       rs_sel         : in  std_logic_vector(4 downto 0);     
       rt_sel         : in  std_logic_vector(4 downto 0);
       w_data         : in  std_logic_vector(31 downto 0);
       w_sel          : in  std_logic_vector(4 downto 0);
       w_en           : in  std_logic;
       reset          : in  std_logic;
       rs_data        : out std_logic_vector(31 downto 0);
       rt_data        : out std_logic_vector(31 downto 0));
       
 end component;
 
 component Branch_Architecture is
  port(Branch_Sel     : in  std_logic_vector(2 downto 0);
       i_Zero         : in  std_logic;
       i_ALU_Out      : in  std_logic;
       o_F            : out std_logic);
end component;
 

component extender16to32
  port(i_con        : in  std_logic;
       i_data       : in  std_logic_vector(15 downto 0);  
       o_F          : out std_logic_vector(31 downto 0));   
end component;
	      

component AddSub is
  generic(N : integer := 32);
	port (A   		    : in  std_logic_vector(N-1 downto 0);
		    B 		      : in  std_logic_vector(N-1 downto 0);
		    nAdd_Sub  : in  std_logic;
		    o_S 		    : out std_logic_vector(N-1 downto 0);
		    o_C 		    : out std_logic);
end component;


component ALU is
  port(operation     : in  std_logic_vector(2 downto 0);
       ALUsel        : in  std_logic_vector(1 downto 0);
       shamt         : in  std_logic_vector(4 downto 0);
       i_A           : in  std_logic_vector(31 downto 0);
       i_B           : in  std_logic_vector(31 downto 0);
       issv          : in  std_logic;
       isUnsignedALU : in  std_logic;
       zero          : out std_logic;
       carry_out     : out std_logic;
       overflow      : out std_logic;
       ALU_out       : out std_logic_vector(31 downto 0));
end component;

component control
  port(Instr          : in  std_logic_vector(5 downto 0);
       rt_Addr       : in  std_logic_vector(4 downto 0);
       bgtz_blez      : out std_logic;
       isLink         : out std_logic;
       Branch         : out std_logic;
       isJump         : out std_logic;
       Reg_w_en       : out std_logic;
       dmem_w_en      : out std_logic;
       RegDst         : out std_logic;
       UpperImm       : out std_logic;
       isImmALU       : out std_logic;
       isLoad         : out std_logic;
       isRtype        : out std_logic;
       compareZero    : out std_logic;
       isLoadU        : out std_logic;
       isBranchLink   : out std_logic;
       ALU_OP         : out std_logic_vector(5 downto 0);
       Branch_Sel     : out std_logic_vector(2 downto 0);
       lsTypeSel      : out std_logic_vector(1 downto 0));
end component;


component ALU_32bit 
  generic(N : integer := 32);
  port(operation     : in  std_logic_vector(2 downto 0);
       isUnsignedALU : in  std_logic;
       i_A           : in  std_logic_vector(N-1 downto 0);
       i_B           : in  std_logic_vector(N-1 downto 0);
       o_F           : out std_logic_vector(N-1 downto 0);
       o_C           : out std_logic;
       zero          : out std_logic;
       overflow      : out std_logic);
end component;

component ALU_control is
  port(funct_code    : in  std_logic_vector(5 downto 0);
       isRtype       : in  std_logic;
       ALUOp         : in  std_logic_vector(5 downto 0);
       operation     : out std_logic_vector(2 downto 0);
       ALUsel        : out std_logic_vector(1 downto 0);
       issv          : out std_logic;
       isJumpReg     : out std_logic;
       isLinkALU     : out std_logic;
       ALU_write     : out std_logic;
       isUnsignedALU : out std_logic);
end component;

 
 signal  s_mux7, s_mux8, s_mux20_Out, s_mux9_Out, ALU_out, s_muxX_Out, s_mux12_Out: std_logic_vector(31 downto 0);
 
 signal  s_mux4, s_mux5 ,s_mux6 : std_logic_vector(4 downto 0);
 
 signal   s_mux15 , s_mux8_select, s_mux20sel, s_BranchOut, s_zero, s_mux_ORVAlue, isRtype, s_isJumpReg, s_isLinkALU, s_ALU_write, s_isUnsignedALU, s_issv , s_o_reg_w_enANDAlu_write: std_logic;  
 
 signal s_branch_Sel, s_operation     : std_logic_vector(2 downto 0);
 
 signal ALUOp : std_logic_vector(5 downto 0);
 
 signal lstypesel, s_ALUsel : std_logic_vector(1 downto 0);
 
 signal  s_ImmSignExt , branch_shifter_out,s_NbitAdder, s_jump_addr, fwd_out_1, fwd_out_2 , s_o_RegData1, s_o_RegData2 , s_UpperImmVal :  std_logic_vector(31 downto 0);
 
 signal link, bgtz_blez, isLink, s_BranchControl, s_Jump, isJumpReg, s_isBranchLink, s_Reg_wen, dmem_w_en, isLoadU, isLoad, RegDst, UpperImm, isImmALU, CompareZero, isBranch : std_logic;
 
--signal o_branch_jump_mux : std_logic_vector(31 downto 0);

 begin
  
  control_unit : control
    port map(Instr         => IFID_instMem(31 downto 26),
       	     rt_Addr       => IFID_instMem(20 downto 16),
             bgtz_blez      => bgtz_blez,
             isLink         => isLink,
             Branch         => s_BranchControl,
             isJump         => s_Jump,
             Reg_w_en       => s_Reg_wen,
             dmem_w_en      => dmem_w_en,
             RegDst         => RegDst,
             UpperImm       => UpperImm,
             isImmALU       => isImmALU,
             isLoad         => isLoad,
             isRtype        => isRtype,
             compareZero    => compareZero,
             isLoadU        => isLoadU,
             isBranchLink   => s_isBranchLink,
             ALU_OP         => ALUOp,
             Branch_Sel     => s_branch_Sel,
             lsTypeSel      => lsTypeSel);

   
   mux7: mux2to1
   port map(i_A =>  MEMWB_upperImmVal ,
            i_B =>  ValtoReg_File,
            i_S =>  MemWB_upperImm,
            o_F =>  s_mux7 ); 
            
  or1 :  or2 

  port map(i_A =>  MEMWB_IsLink,
       i_B =>   MEMWB_isLinkALU ,
       o_F   => s_mux8_select );
   
   mux8: mux2to1
   port map(i_A => MemWB_PCPlus4 ,
            i_B => s_mux7 ,
            i_S => s_mux8_select,
            o_F => s_mux8);
            
  
     s_mux6 <=  MEMWB_instMem(15 downto 11) WHEN MEMWB_isLinkALU = '1' ELSE
         "11111";
    
     s_mux4 <=  MEMWB_instMem(20 downto 16) WHEN  MEMWB_RegDest = '1' ELSE
        MEMWB_instMem(15 downto 11);
     
     s_mux5 <=   s_mux4  WHEN s_mux8_select = '0' ELSE
       s_mux6; 
    
    
     and_gate1: and2
   port map(
        i_A        =>  MemWB_RegW_en,
        i_B        => MEMWB_ALUWrite,
        o_F        => s_o_reg_w_enANDAlu_write );   
         
     s_mux15 <=  s_o_reg_w_enANDAlu_write   WHEN s_isBranchLink = '0' ELSE
       s_BranchOut;  
       
  -- s_Reg_wen  <=  s_mux15;   
   
    Register_file : MIPS_register_file
   port map(
       CLK    => CLK,
       rs_sel =>   IFID_instMem( 25 downto 21) ,       
       rt_sel =>   IFID_instMem( 20 downto 16) ,
       w_data  =>  s_mux8,      
       w_sel   =>   s_mux5,      
       w_en     =>  s_mux15,    
       reset    =>   Regfile_reset,     
       rs_data   =>  s_o_RegData1 ,    
       rt_data  =>   s_o_RegData2       
   ); 
    out_ID_rs_output  <= s_o_RegData1;
   

 sign_extend_imm : extender16to32
   port map(i_con => '1',
	          i_data =>  IFID_instMem( 15 downto 0),
            o_F   =>  s_ImmSignExt );
            
            
   s_UpperImmVal(31 downto 16) <= IFID_instMem(15 downto 0);
   s_UpperImmVal(15 downto 0) <= (others => '0');   --- For Upper Immediate
-- remove this mux if reverting back to original diagram--

--Test: with zero and sign extend--

 muxX: mux2to1
   port map(i_A =>  x"00000000",
            i_B =>  s_ImmSignExt,
            i_S =>  compareZero,
            o_F =>  s_muxX_Out);
            
-------
            
  branch_shifter_out(1 downto 0) <= (others => '0');
  branch_shifter_out(31 downto 2) <= s_ImmSignExt(29 downto 0);  
  
  NbitAdder: AddSub
   port map(A =>  IFID_AdderVal,
            B => branch_shifter_out,
            nAdd_Sub => '0',
            o_S => s_NbitAdder ,
            o_C => open
            );         
 ---------Nb      
 
      
 and2_1 : and2

  port map(i_A      => s_BranchOut, -- Output from branch control
       i_B          => s_BranchControl, -- Branch control signal
       o_F          => s_mux20sel);




 mux20: mux2to1
   port map(i_A =>  s_NbitAdder,
            i_B =>  IFID_AdderVal,
            i_S =>  s_mux20sel,
            o_F =>  s_mux20_Out);
     
   s_jump_addr(1 downto 0) <= (others => '0');
   s_jump_addr(27 downto 2) <= IFID_instMem(25 downto 0);
   s_jump_addr(31 downto 28) <= IFID_AdderVal(31 downto 28);
   
   
 mux9: mux2to1
   port map(i_A =>  s_jump_addr,
            i_B =>  s_mux20_Out,
            i_S =>  s_Jump,
            o_F =>  s_mux9_Out);     

 o_branch_jump_mux  <= s_mux9_Out;
            
Branch_arch: Branch_Architecture
   port map(Branch_Sel => s_branch_Sel,
            i_Zero => s_zero,
            i_ALU_out => ALU_out(0),
            o_F => s_BranchOut);     
                   

or3 :  or2 
  port map(i_A =>  s_Jump,
       i_B =>   s_mux20sel ,  --s_branchOut
       o_F   => s_mux_ORVAlue );
       
 o_muxORval  <=  s_mux_ORVAlue;   
 
 
---forwarding and branch logic
     
    fwd_out_1  <= s_o_RegData1 when forwardA_Branch = "000" else
                  ExMem_ALU when forwardA_Branch = "001" else
                  IDEX_ALUval when forwardA_Branch = "010" else
                  EXMEM_PCplus4 when forwardA_Branch = "011" else
                  EXMEM_UpperImm when forwardA_Branch = "100" else
                  IDEX_UpperImm;
                  
    fwd_out_2  <= s_o_RegData2 when forwardB_Branch = "000" else
                  ExMem_ALU when forwardB_Branch = "001" else
                  IDEX_ALUval when forwardB_Branch = "010" else
                  EXMEM_PCplus4 when forwardB_Branch = "011" else
                  EXMEM_UpperImm when forwardB_Branch = "100" else
                  IDEX_UpperImm;
      
 mux12: mux2to1
   port map(i_A =>  s_muxX_Out,
            i_B =>  fwd_out_2,
            i_S =>  isImmALU,
            o_F =>  s_mux12_Out);
         
  --  s_mux_ALUoperation  <=    "001" when    
   ---  "001" when "100010", 
   
ALU_simple:  ALU_32bit 
  port map(operation     => s_operation,
           isUnsignedALU => s_isUnsignedALU,
           i_A           => fwd_out_1,
           i_B           => s_mux12_Out,
           o_F           =>  ALU_out,
           o_C           =>  open,
           zero          =>  s_zero,
           overflow      =>  open
       );
       

       
 idToExReg1: idToExReg
	port map(Clk          => CLK,
		       Reset            => IDEX_reset,
		       Flush            => IDEX_Flush,
		       WE               => IDEX_WE,
		       RegDst           => RegDst,
		       IsLoad           => isLoad,
		       IsLink           => isLink,
		       Reg_w_en         => s_Reg_wen,
		       UpperImm         => UpperImm,
		       dmem_w_en        => dmem_w_en,
		       IsImmALU         => isImmALU,
		       --IsRtype          => isRtype,
		       IsLoadU          => isLoadU,
		       branchAnd        => s_mux20sel,
		       operation        => s_operation,
           ALUsel           => s_ALUsel,
           issv             => s_issv,
           isJumpReg        => s_isJumpReg,
           isLinkALU        => s_isLinkALU,
           reg_w_enANDAlu_write  => s_o_reg_w_enANDAlu_write,
           ALU_write        => s_ALU_write,
           isUnsignedALU    => s_isUnsignedALU,
		       TypeSel          => lsTypeSel,
		       ALU_OP	          => ALUOp,
		      --- branch_jump_mux  => s_mux9_Out,
		       RegData1         => s_o_RegData1,
		       RegData2         => s_o_RegData2,
		       instMem          => IFID_instMem,
		       PCplus4          => IFID_AdderVal,
		       upperImmVal      => s_UpperImmVal,
		       branchALU        => ALU_out,
		       ImmSignExt       => s_ImmSignExt,
           o_branchAnd      => o_branchAnd,
           o_operation      => o_operation,
           o_ALUsel         => o_ALUsel,
           o_issv           => o_issv,
           o_isJumpReg      => o_isJumpReg,
           o_isLinkALU      => o_isLinkALU,
           o_ALU_write      => o_ALU_write,
           o_isUnsignedALU  => o_isUnsignedALU,
		       o_IsImmALU       => o_isImmALU,
		       o_reg_w_enANDAlu_write  => o_reg_w_enANDAlu_write,
		      -- o_IsRtype        => isRtype,
		       o_RegDst         => o_RegDst,
		       o_isLoadU        => o_isLoadU,
		       o_instMem        => o_IFID_instMem,
		       o_Reg_w_en       => o_Reg_w_en,
		       o_UpperImm       => o_UpperImm,
		       o_isLink         => o_isLink,
		       o_dmem_w_en      => o_dmem_w_en,
		       o_isLoad         => o_isLoad,
		     --  o_branch_jump_mux=> o_branch_jump_mux,
		       o_TypeSel        => o_TypeSel, 
		       o_ALU_OP	        => o_ALU_OP,
		       o_RegData1       => o_RegData1,
		       o_RegData2       => o_RegData2,
		       o_ImmSignExt     => o_ImmSignExt,
		       o_PCplus4        => o_PCplus4,
		       o_upperImmVal    => o_upperImmVal,
		       o_branchALU      => o_branchALU); 
		       
		   
aluControl : ALU_control 
  port map(funct_code    => IFID_instMem(5 downto 0),
           isRtype       => isRtype,
           ALUOp         => ALUOp,
           operation     => s_operation,
           ALUsel        => s_ALUsel,
           issv          => s_issv,
           isJumpReg     => s_isJumpReg,
           isLinkALU     => s_isLinkALU,
           ALU_write     => s_ALU_write,
           isUnsignedALU => s_isUnsignedALU);
           
           
end structure;