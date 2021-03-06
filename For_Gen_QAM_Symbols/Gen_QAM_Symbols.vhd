library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;


entity Gen_QAM_Symbols is 
	generic(ticks_for_symbols: integer:= 100e6);
	port(rst: in std_logic; 
		  clk: in std_logic;
		  init_symb: in std_logic;
		  fi: out std_logic_vector(total_ang_bits-1 downto 0);
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0); 
		  init_gen_ang: out std_logic; 
		  eof_symb: out std_logic);
end entity;

architecture struct of Gen_QAM_Symbols is 

component special_time_base is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  OPB: in std_logic;
		  limit: in integer; 
		  TB: out std_logic);
end component;

component FSM_QAM_SYMBOLS is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_symb: in std_logic; 
		  TB: in std_logic; 
		  ZS: in std_logic; 
		  ZC: in std_logic; 
		  OPB: out std_logic; 
		  OPS: out std_logic_vector(1 downto 0); 
		  OPC: out std_logic_vector(1 downto 0); 
		  init_gen_ang: out std_logic; 
		  eof_symb: out std_logic);
end component; 

component Specialcounter is
	generic(n: integer:= 8); 
	port(rst: in std_logic;
		  clk: in std_logic; 
		  OP: in std_logic_vector(1 downto 0);
		  T: in std_logic_vector(n-1 downto 0); 
		  Z: out std_logic;
		  count: out std_logic_vector(n-1 downto 0));
end component; 

component QAM_Symbols is 
	port(sample: in std_logic_vector(7 downto 0); 
		  k_sample: in std_logic_vector(1 downto 0); 
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0);
		  fi: out std_logic_vector(total_ang_bits-1 downto 0)); 
end component; 

--outs Special_time_base
signal TB: std_logic; 
--outs FSM
signal OPB: std_logic; 
signal OPS: Std_logic_vector(1 downto 0); 
signal OPC: std_logic_vector(1 downto 0); 
--outs CNTSYMB
signal ZS: std_logic; 
signal k_samp: std_logic_vector(1 downto 0); 
--outs CNTsamp
signal ZC: std_logic; 
signal sample: std_logic_vector(7 downto 0); 

begin 

	STB: special_time_base port map(rst, clk, OPB, ticks_for_symbols, TB);
	FSM1: FSM_QAM_SYMBOLS port map(rst, clk, init_symb, TB, ZS, ZC, 
		OPB, OPS, OPC, init_gen_ang, eof_symb);
	CNTSYMB: specialcounter generic map(2) port map(rst, clk, OPS, "10",
		ZS, k_samp);
	CNTSAMP: specialcounter generic map(8) port map(rst, clk, OPC, "11111111", 
		ZC, sample);
	QAMSYM: QAM_Symbols port map(sample, k_samp, Amp, fi);
	
	

end architecture; 




