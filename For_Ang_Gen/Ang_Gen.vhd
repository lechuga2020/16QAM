library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity Ang_gen is 
	port(rst: in std_logic; 
		  clk: in std_logic;
		  eof_div: in std_logic;
		  init_gen: in std_logic;
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  ang: out std_logic_vector(total_ang_bits-1 downto 0); 
		  new_ang: out std_logic);
end entity; 

architecture struct of Ang_gen is

--recuerda para el angulo: 
--f = 200 Hz
--W = 2pi 
-- ts = 1/8,000pi
--Wc = (2pi*f)/(fs) = 0.05
--pero voy a poner el time base mas lento... 
	-- osea 1/400pi <-- esto se esta cambiando regularmente

component ang_calculator is 
	port(Wc: in std_logic_vector(total_ang_bits-1 downto 0);
		  k: in std_logic_vector(total_ang_bits-1 downto 0);
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  ang: out std_logic_vector(total_ang_bits-1 downto 0));
end component; 

component registerP2P is 
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end component; 

component FSM_Ang_Gen is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_gen: in std_logic; 
		  TB: in std_logic; 
		  ZS: in std_logic; 
		  eof_div: in std_logic;
		  enr: out std_logic; 
		  new_angle: out std_logic; 
		  OPB: out std_logic; 
		  OPS: out std_logic_vector(1 downto 0));
end component; 

component special_time_base is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  OPB: in std_logic;
		  limit: in integer; 
		  TB: out std_logic);
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

-- out ang_calculator
constant Wc: std_logic_vector(total_ang_bits-1 downto 0):= "000000000000000000110011";--0.05
signal ang_reg_in: std_logic_vector(total_ang_bits-1 downto 0);
--outs FSM1
signal enr: std_logic; 
signal OPB: std_logic; 
signal OPS: std_logic_vector(1 downto 0);
--outs time base 
signal TB: std_logic; 
--outs counter
signal ZS: std_logic; 
signal k: std_logic_vector(total_ang_bits-1 downto 0);
signal count: std_logic_vector(12 downto 0);

begin 

	ANGC: ang_calculator port map(Wc, k, fi, ang_reg_in);
	ANGR: registerP2P generic map(total_ang_bits) port map(rst, clk, 
		enr, ang_reg_in, ang);
	FSM1: FSM_Ang_Gen port map(rst, clk,init_gen, TB, ZS, eof_div, 
		enr, new_ang, OPB, OPS);
	STB: special_time_base port map(rst, clk, OPB, 7957, TB);
	SCNT: specialcounter generic map(13) port map(rst, clk, OPS, "1111111111111",  ZS, count); 
	
	k(total_ang_bits-1 downto 23) <= (others=>'0');
	k(22 downto 10) <= count;
	k(9 downto 0) <= (others=>'0');
	
end architecture; 




