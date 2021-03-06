library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity GEN_QAM is 
	generic(UART_ticks: integer:= 10416); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_gen: in std_logic; 
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0);
		  Tx: out std_logic);
end entity;

architecture struct of GEN_QAM is 

component Ang_gen is 
	port(rst: in std_logic; 
		  clk: in std_logic;
		  eof_div: in std_logic;
		  init_gen: in std_logic;
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  ang: out std_logic_vector(total_ang_bits-1 downto 0); 
		  new_ang: out std_logic);
end component; 

component Ang_eq_And_Cordic is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  new_ang: in std_logic; 
		  ang: in std_logic_vector(total_ang_bits-1 downto 0); 
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0);
		  cos: out std_logic_vector(total_pi_bits-1 downto 0);
		  sine: out std_logic_vector(total_pi_bits-1 downto 0);
		  eof_cordic: out std_logic);
end component;

component Tx_Module is 
	generic(n_bits_Tx: integer:= 8; 
		     ticks_UART: integer:= 434);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  start_div: in std_logic; 
		  Tx: out std_logic; 
		  eof_div: out std_logic);
end component;

--outs of Ang_gen 
signal ang: std_logic_vector(total_ang_bits-1 downto 0); 
signal new_ang: std_logic; 
--outs Ang_eq_And_Cordic
signal cos: std_logic_vector(total_pi_bits-1 downto 0);
signal sine: std_logic_vector(total_pi_bits-1 downto 0);
signal eof_cordic: std_logic;
--outs of Tx Module
signal eof_div: std_logic;

begin 

	AG: Ang_gen port map(rst, clk, eof_div, init_gen, fi, ang, new_ang);
	ANGCORD: Ang_eq_And_Cordic port map(rst, clk, new_ang, ang, Amp, 
		cos, sine, eof_cordic);
	TxM: Tx_Module generic map(8, UART_ticks) 
		port map(rst, clk, cos, eof_cordic, Tx, eof_div);

end architecture;
