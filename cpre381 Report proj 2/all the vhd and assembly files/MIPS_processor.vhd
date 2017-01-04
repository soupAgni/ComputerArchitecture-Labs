use work.all;
library IEEE;
use IEEE.std_logic_1164.all;


entity MIPS_processor is
  
  generic(N : integer := 32);
  port(
  
    WriteEnable   : in std_logic;
    reset         : in std_logic;
    clock         : in std_logic 
  );

end MIPS_processor;

architecture dataflow of MIPS_processor is

component mem is
	generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "mem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			    byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			    clock			  : IN STD_LOGIC := '1';
			    data		   	: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			    wren		   	: IN STD_LOGIC := '0';
			    q				     : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));         
end component;

component dataMem is
	generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "DataMem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			    byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			    clock			: IN STD_LOGIC := '1';
			    data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			    wren			: IN STD_LOGIC := '0';
			    q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));         
end component;


component I_Fetch is
  
port(BorJ       :  in std_logic;
     JR         :  in std_logic;
     Branch_op  :  in std_logic;
     Jump_op    :  in std_logic;
     WE         :  in std_logic;
     reset      :  in std_logic;
     clock      :  in std_logic;
     instr_25to0:  in std_logic_vector(25 downto 0);
     readData1  :  in std_logic_vector(31 downto 0);
     imm_val    :  in std_logic_vector(31 downto 0);
     PC_Val_final :  out std_logic_vector(31 downto 0);
     PC_add_four   : out std_logic_vector(31 downto 0));
     
end component;

component and2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component ALU_Control is
  
port(sel        :  in std_logic_vector(3 downto 0);
     shift      :  in std_logic_vector(4 downto 0);
     c_in       :  out std_logic;
     B_inv      :  out std_logic;
     A_inv      :  out std_logic;
     ALU_op     :  out std_logic_vector(2 downto 0);
     shift_op   :  out std_logic_vector(1 downto 0);
     shift_Amt  :  out std_logic_vector(4 downto 0);
     Unit_sel   :  out std_logic_vector(1 downto 0);
      sltu       :  out std_logic
    );
     
end component;

component ALU is
  
port(Unit_Sel  :  in std_logic_vector(1 downto 0);
     Shift_Amt :  in std_logic_vector(4 downto 0);
     Shift_op  :  in std_logic_vector(1 downto 0);
     AlU_op    :  in std_logic_vector(2 downto 0);
     Data1     :  in std_logic_vector(31 downto 0);
     Data2     :  in std_logic_vector(31 downto 0);
     Sltu      :  in std_logic;
     selectData:  in std_logic;
     A_inv     :  in std_logic;
     B_inv     :  in std_logic;
     C_in      :  in std_logic;
     Zero      :  out std_logic;
     Result    :  out std_logic_vector(31 downto 0));   ---We need more outputs to handle jump and branch I think
       
end component;

component storeArchitecture is 
	port( A			    : in std_logic_vector(31 downto 0);
		  dataType 	: in std_logic_vector(1 downto 0);
      aluOut: in std_logic_vector(1 downto 0);
		  MEM_DATA	 : out std_logic_vector(31 downto 0);
      BE		  : out std_logic_vector(3 downto 0)
         );
end component;


component loadArchitecture is 
	port( MEM_DATA		: in std_logic_vector(31 downto 0);
		  dataType 		: in std_logic_vector(1 downto 0);
          aluOut 		: in std_logic_vector(1 downto 0);
		  loadUnsigned	: in std_logic;
          O				: out std_logic_vector(31 downto 0)
         );
end component;


component branchLogic is 
	port( A :  in std_logic;
		    B : in std_logic;
       sel: in std_logic_vector(2 downto 0);
       O  : out std_logic
         );
end component;

component Control_Unit is
port(
       OpCode   :  in std_logic_vector(5 downto 0);
       funct    :  in std_logic_vector(5 downto 0);
       rt       :  in std_logic_vector(4 downto 0);
       regDest  :  out std_logic;
       Jump     :  out std_logic;
       Branch   :  out std_logic;
       MemRead  :  out std_logic;
       MemtoReg :  out std_logic;  --- This will be 1 for loads and 0 for everything else
       ALU_Code :  out std_logic_vector(3 downto 0);  ---this is a 4 bit value. Gotta change name to resolve conflict with original ALUOp 
       MemWrite :  out std_logic;
       ALUSrc   :  out std_logic;
       RegWrite :  out std_logic;
      SignExtend :  out std_logic;   -------- zero or sign
      LoadUpperImmediate :  out std_logic;
      isLink     : out std_logic;
      dataType   : out std_logic_vector(1 downto 0);
      LoadUnsigned : out std_logic;
      JorJAL      :  out std_logic;
      JRegister   : out std_logic;
      Bgtz_blez   :out std_logic;
      BranchType  :out std_logic_vector(2 downto 0);
      isLinkALU   : out std_logic;
      isImmALU     : out std_logic;
      BorJ       :  out std_logic );
      
end component;

component Sign_extend_32 is

  port(input          : in std_logic_vector(15 downto 0);
       sign           : in std_logic;
       output         : out std_logic_vector(31 downto 0));

end component;

component register_file 
	port(	i_reg1 : in std_logic_vector(4 downto 0); -- address of rs
		i_reg2 : in std_logic_vector(4 downto 0); -- address of rt
		i_writereg : in std_logic_vector(4 downto 0); -- address to write to
		i_data : in std_logic_vector(31 downto 0); -- data to write at i_writereg address
		i_WE : in std_logic; -- write enable
		i_CLK : in std_logic;
		i_RST : in std_logic; -- resets entire register file
		o_reg1 : out std_logic_vector(31 downto 0); -- output data of rs address
		o_reg2 : out std_logic_vector(31 downto 0)); -- output data of rt address
end component;


----signals from control unit
 signal s_BorJ, s_JR_op, s_Branch ,  s_Jump, s_regDest, s_MemRead, s_MemtoReg, s_MemWrite, s_ALUSrc, s_RegWrite,  s_SignExtend, s_LoadUpperImmediate :  std_logic; 
 signal s_isLink, s_LoadUnsigned, s_JorJAL, s_bgtzORblez  :  std_logic;
-- signal s_JRegister   : std_logic;
 signal s_BranchOp : std_logic;
 signal s_ALU_Code  : std_logic_vector(3 downto 0);
 signal s_BranchType: std_logic_vector(2 downto 0);
 signal s_DataTypemem: std_logic_vector(1 downto 0);
 signal s_isImmALU  : std_logic ;
 -----signal from Alu control
 
 signal isLink_ALU   : std_logic;
 signal isImm_ALU   : std_logic;
 signal s_ALU_write    : std_logic;
 
-------signal from PC

signal PC_out, s_PC_add_four : std_logic_vector(31 downto 0);

----signals from memory

signal s_ImemOut, s_DmemOut   : std_logic_vector(31 downto 0);
signal s_toLoadArch : std_logic_vector(31 downto 0);

----signals to Register file

   --- mux outputs

signal s_rtORrd , s_link, s_wsel : std_logic_vector(4 downto 0);
signal s_linkANDalu : std_logic;

signal s_upperImm   : std_logic_vector(31 downto 0);

     ----Signal from random muxes and random signals
     signal s_write  : std_logic;
signal s_forWen   : std_logic;
signal s_load_RT  : std_logic_vector(31 downto 0);

     ---RegFile outputs
signal s_RD1  : std_logic_vector(31 downto 0);
signal s_RD2  : std_logic_vector(31 downto 0);

signal s_MuxOutToALUa : std_logic_vector(31 downto 0);
signal s_rd2MuxOut : std_logic_vector(31 downto 0);
signal s_MuxOutToALUb : std_logic_vector(31 downto 0);
signal s_Imemextended , s_wData: std_logic_vector(31 downto 0);
---Output from sign and zero extenders

signal s_zeroExtImm  : std_logic_vector(31 downto 0);
signal s_signExtImm , s_zeroORsign_imm : std_logic_vector(31 downto 0);


-----Output from Branch logic

signal s_branch_Out  :  std_logic;


   ---outputs	from store arch
signal s_StoreData : std_logic_vector(31 downto 0);
signal s_memByteEn : std_logic_vector(3 downto 0);

   
   
-----------------signals ALU \
  signal s_Unit_Sel  :    std_logic_vector(1 downto 0);
  signal s_sShift_Amt:  std_logic_vector(4 downto 0);
  signal s_Shift_op  :   std_logic_vector(1 downto 0);
  signal s_AlU_op    :   std_logic_vector(2 downto 0);
  signal s_Data1     :   std_logic_vector(31 downto 0);
  signal s_Data2     :   std_logic_vector(31 downto 0);
  signal s_Sltu      :   std_logic;
  signal s_selectData:   std_logic;
  signal s_A_inv     :   std_logic;
  signal s_B_inv     :   std_logic;
  signal s_C_in      :   std_logic;
  signal s_Zero      :   std_logic;
  signal s_Result    :   std_logic_vector(31 downto 0);

begin 
  
  
  -----IFETCH---
  
  I_Fetch1 :  I_Fetch 
  
port map 
    (BorJ   =>  s_BorJ,
    JR         =>  s_JR_op,
     Branch_op  => s_BranchOp,
     Jump_op    => s_Jump,
     WE         => WriteEnable,
     reset      => reset,
     clock      => clock,
     instr_25to0=> s_ImemOut(25 downto 0),
     readData1  => s_RD1,
     imm_val    => s_signExtImm,
     PC_Val_final => PC_out,
     PC_add_four  =>  s_PC_add_four);
     
----IMEM----

mem1 : mem
	port  map
	       (address			=> PC_out(11 downto 2),
			    byteena			=> "1111",
			    clock			  => clock,
			    data			   => x"00000000",
			    wren			   => '0',
			    q				     => s_ImemOut);         


----- And Gate for isLink and isLinkALU

s_linkANDalu <= s_isLink and isLink_ALU;

-----muxes and path for output from RF---

-----reg DEst
s_rtORrd <= s_ImemOut(20 downto 16) when s_regDest = '0' else
            s_ImemOut(15 downto 11);

----isLinkALU
s_link <= "11111" when isLink_ALU = '0' else
            s_ImemOut(15 downto 11);

------is_link and ALU
s_wsel <= s_rtORrd when s_linkANDalu = '0' else
            s_link;


--- upper Immediate
s_Imemextended   <=  s_ImemOut(15 downto 0)   & "0000000000000000";

s_upperImm <= s_toLoadArch when  s_LoadUpperImmediate = '0' else
              s_Imemextended;
          
              
---------mux to write data

s_wData <= s_upperImm when  s_linkANDalu = '0' else
              s_PC_add_four;

---------------------DONE WITH MUXES FOR REG FILE -------------

-----Sign extend and Zero Extemd Immediate----

s_zeroExtImm  <= "0000000000000000" & s_ImemOut(15 downto 0);

Sign_extend_32_1  : Sign_extend_32

  port map(input      => s_ImemOut(15 downto 0),
       sign           => s_ImemOut(15),
       output         => s_signExtImm);

s_zeroORsign_imm  <= s_zeroExtImm when  s_SignExtend = '0' else
                     s_signExtImm;

----------------------------------------------- done with the extending
---- handling wen
--s_write <= s_RegWrite and s_ALU_write;

-----reg DEst
s_forWen <= s_RegWrite when s_Branch = '0' else
            s_branch_Out;

----Adding the values into reg file 
regFile:  register_file 
  port map(i_reg1     => s_ImemOut(25 downto 21),
           i_reg2     => s_ImemOut(20 downto 16),
           i_data       => s_wData,
           i_writereg      => s_wsel,
           i_WE         => s_forWen,
           i_CLK        => clock,
           i_RST        => reset,
           o_reg1        => s_RD1,
           o_reg2        => s_RD2);



-----reg file output logic
s_MuxOutToALUa <= s_RD1 when s_bgtzORblez = '0' else
                  s_rd2MuxOut;
                  
s_Data1   <= s_MuxOutToALUa;

s_rd2MuxOut <= s_RD2 when s_isImmALU = '0' else
               s_zeroORsign_imm;
            
s_MuxOutToALUb <= s_RD1 when s_bgtzORblez = '1' else
                  s_rd2MuxOut;
s_Data2    <= s_MuxOutToALUb;

-------------ALU
  ALU1:  ALU 
  port map (Unit_Sel  => s_Unit_Sel,
            Shift_Amt => s_sShift_Amt,
            Shift_op  => s_Shift_op,
            AlU_op    => s_AlU_op,
            Data1     => s_Data1,
            Data2     => s_Data2,
            Sltu      => s_Sltu,
            selectData=> '1',
            A_inv     => s_A_inv,
            B_inv     => s_B_inv,
            C_in      => s_C_in,
            Zero      => s_Zero,
            Result    => s_Result);   


-------- Branch Logic
branchLogic1 : branchLogic 
	port map(A  => s_Zero,
		       B  => s_Result(0),
           sel=> s_BranchType,
           O  => s_branch_Out);

s_BranchOp <= s_branch_Out and s_Branch;



------------------ store Architecture ------------
storeArchitecture1 : storeArchitecture 
	port map( A			       => s_Result,
		        dataType 	 => s_DataTypemem,
            aluOut     => s_Result(1 downto 0),
		        MEM_DATA	  => s_StoreData,
            BE		       => s_memByteEn);


----------------- data mem ----------------------
mem_data : dataMem
	port  map
	       (address			=> s_Result(11 downto 2),
			    byteena			=> s_memByteEn,
			    clock			  => clock,
			    data			   => s_StoreData,
			    wren			   => s_MemWrite,
			    q				     => s_DmemOut);  


s_toLoadArch <= s_load_RT when s_MemtoReg = '1' else
                s_Result;


---------------------- load Architecture ------
loadArchitecture1 : loadArchitecture 
	port map(MEM_DATA		   => s_DmemOut,
		       dataType 	   => s_DataTypemem,
           aluOut 		    => s_Result(1 downto 0),
		       loadUnsigned => s_LoadUnsigned,
           O            => s_load_RT);
           
           
---------------- control Unit -----------------

Control_Unit_1  : Control_Unit
port map(
       OpCode   => s_ImemOut(31 downto 26),
       funct    => s_ImemOut(5 downto 0),
       rt       => s_ImemOut(20 downto 16),
       regDest  => s_regDest,
       Jump     => s_Jump,
       Branch   => s_Branch,
       MemRead  => s_MemRead,
       MemtoReg => s_MemtoReg,  --- This will be 1 for loads and 0 for everything else
       ALU_Code => s_ALU_Code,  ---this is a 4 bit value. Gotta change name to resolve conflict with original ALUOp 
       MemWrite => s_MemWrite,
       ALUSrc   => s_ALUSrc,
       RegWrite => s_RegWrite,
       SignExtend => s_SignExtend,  -------- zero or sign
       LoadUpperImmediate => s_LoadUpperImmediate,
       isLink     => s_isLink,
       dataType   => s_DataTypemem,
       LoadUnsigned=> s_LoadUnsigned,
       JorJAL      => s_JorJAL,
       JRegister   => s_JR_op,
       Bgtz_blez   => s_bgtzORblez,
      BranchType  => s_BranchType, 
      isLinkALU   => isLink_ALU,
      isImmALU    => s_isImmALU,
       BorJ       => s_BorJ);


------------------- alu control ---------------

ALU_Control2 : ALU_Control

port map(sel        => s_ALU_Code,
     shift      => s_ImemOut(10 downto 6),
     c_in       => s_C_in,
     B_inv      => s_B_inv,
     A_inv      => s_A_inv,
     ALU_op     => s_AlU_op,
     shift_op   => s_Shift_op,
     shift_Amt  => s_sShift_Amt,
     Unit_sel   => s_Unit_Sel,
     sltu       => s_sltu
    );
    
    
    

end dataflow;