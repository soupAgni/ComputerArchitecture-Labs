-------------------------------------------------------------------------
-- Souparni Agnihotri
-------------------------------------------------------------------------


-- processor.vhd
-------------------------------------------------------------------------
-------------------------------------------------------------------------
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity processor is
  
    generic(N : integer := 32);

  port(nAdd_Sub  : in std_logic;
       ALUSrc    : in std_logic;    
       Clk       : in std_logic;
       rs_addr   : in std_logic_vector(4 downto 0);
       rt_addr   : in std_logic_vector(4 downto 0);
       w_data    : in std_logic_vector(31 downto 0);
       w_addr    : in std_logic_vector(4 downto 0);
       w_en      : in std_logic;
       reset      : in std_logic;
       val       : out std_logic_vector(31 downto 0);
       carry     : out std_logic_vector(31 downto 0));

end processor;



architecture dataflow of processor is
  

  
 component register_file
   
  port(rs_adder      : in std_logic_vector(4 downto 0);
       rt_adder         : in std_logic_vector(4 downto 0);
       w_data         : in std_logic_vector(31 downto 0);
       w_adder         : in std_logic_vector(4 downto 0);
       w_en         : in std_logic;
       clock         :in std_logic;
       reset          : in std_logic;
       rs            : out std_logic_vector(31 downto 0);
       rt             : out std_logic_vector(31 downto 0));

 end component;
 


 component n_Add_Sub_P2 
  
  
  port(nAdd_Sub  : in std_logic;
       A         : in std_logic_vector(N-1 downto 0);
       B         : in std_logic_vector(N-1 downto 0);
       ALUSrc    : in std_logic;
       Y         : out std_logic_vector(N-1 downto 0);
       Z         : out std_logic_vector(N-1 downto 0));

 end component;

signal sValue_rs, sValue_rt, s_val : std_logic_vector(N-1 downto 0);
  
begin
  
   ---------------------------------------------------------------------------
  -- Level 1: Calculate not of B
  ---------------------------------------------------------------------------
  
  
  
  registerFile_1 : register_file
  
  port MAP(rs_adder    => rs_addr,
       rt_adder        => rt_addr,
       w_data         => s_val,
       w_adder        => w_addr,
       w_en           => w_en,
       clock          => clk,
       reset          => reset,
       rs             => sValue_rs,
       rt             => sValue_rt);
           
  ---------------------------------------------------------------------------
  -- Level 2: Calculate into Add Sub
  ---------------------------------------------------------------------------
  n_Add_Sub_P2_1 : n_Add_Sub_P2
  
  port MAP(nAdd_Sub  => nAdd_Sub,
       A         => sValue_rs,
       B         => sValue_rt,
       ALUSrc    => ALUSrc,
       Y         => s_val,
       Z         => carry);
       
       

           
  
end dataflow;