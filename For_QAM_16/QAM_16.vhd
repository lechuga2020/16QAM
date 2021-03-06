library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity QAM_16 is 
	generic (ticks_for_symbols: integer:= 300e6;
				   UART_ticks: integer:= 10416);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_QAM: in std_logic; 
		  eof_QAM: out std_logic; 
		  Tx: out std_logic);
end entity; 

architecture struct of QAM_16 is 

component Gen_QAM_Symbols is 
	generic(ticks_for_symbols: integer:= 100e6);
	port(rst: in std_logic; 
		  clk: in std_logic;
		  init_symb: in std_logic;
		  fi: out std_logic_vector(total_ang_bits-1 downto 0);
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0); 
		  init_gen_ang: out std_logic; 
		  eof_symb: out std_logic);
end component;

component GEN_QAM is 
	generic(UART_ticks: integer:= 10416); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_gen: in std_logic; 
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0);
		  Tx: out std_logic);
end component;

--outs of GEN_QAM_Symbols
signal fi: std_logic_vector(total_ang_bits-1 downto 0);
signal Amp: std_logic_vector(total_pi_bits-1 downto 0); 
signal init_gen_ang: std_logic; 
		 
begin 

	GQS: Gen_QAM_Symbols generic map(ticks_for_symbols) 
		port map(rst, clk, init_QAM, fi, Amp, init_gen_ang, eof_QAM);
	GQAM: Gen_QAM generic map(UART_ticks) 
		port map(rst, clk, init_gen_ang, fi, Amp, Tx);
	
end architecture; 