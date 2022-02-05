library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity cordic_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init: in std_logic; 
		  angle: in std_logic_vector(total_pi_bits-1 downto 0);
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0); 
		  sing_sine: in std_logic; 
		  sing_cos: in std_logic; 
		  cos: out std_logic_vector(total_pi_bits-1 downto 0); 
		  sine: out std_logic_vector(total_pi_bits-1 downto 0); 
		  eof_cordic: out std_logic);
end entity; 

architecture struct of cordic_module is 

component control_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init: in std_logic; 
		  enr: out std_logic;
		  k: out std_logic_vector(5 downto 0); 
		  eof_algor: out std_logic; 
		  eof_cordic: out std_logic);
end component; 


component algoritm_module is 
	port (rst: in std_logic;
		      clk: in std_logic; 
				ang_init: in std_logic_vector(total_pi_bits-1 downto 0); 
				enr: in std_logic; 
				k: in integer range 0 to 40; 
				x: out std_logic_vector(total_pi_bits-1 downto 0); 
				y: out std_logic_vector(total_pi_bits-1 downto 0));
end component; 

component sineCos_module is 
	port(rst: in std_logic; 
		  clk: in std_logic;
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0);
		  x: in std_logic_vector(total_pi_bits-1 downto 0);
		  y: in std_logic_vector(total_pi_bits-1 downto 0);
		  sing_cos: in std_logic;
		  sing_sine: in std_logic;
		  eof_algor: in std_logic;
		  cos: out std_logic_vector(total_pi_bits-1 downto 0);
		  sine: out std_logic_vector(total_pi_bits-1 downto 0));
end component; 

--outs control_module
signal enr: std_logic;
signal k: std_logic_vector(5 downto 0); 
signal eof_algor: std_logic; 
signal k_int: integer range 0 to 40; 
--outs algoritm_module
signal x,y: std_logic_vector(total_pi_bits-1 downto 0); 

begin 

	CM: control_module port map(rst, clk, init, enr, k, eof_algor, eof_cordic);
	k_int <= conv_integer(unsigned(k));
	AM: algoritm_module port map(rst, clk, angle, enr, k_int, x, y);
	SinCosM: sineCos_module port map(rst, clk, Amp, x, y, sing_cos, sing_sine, 
		eof_algor, cos, sine);

end architecture; 