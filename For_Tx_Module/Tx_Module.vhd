library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity Tx_Module is 
	generic(n_bits_Tx: integer:= 8; 
		     ticks_UART: integer:= 434);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  start_div: in std_logic; 
		  Tx: out std_logic; 
		  eof_div: out std_logic);
end entity;


architecture struct of Tx_Module is 

component byte_divider is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_div: in std_logic;
		  eof_tx: in std_logic; 
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  byte: out std_logic_vector(7 downto 0); 
		  start_tx: out std_logic; 
		  eof_div: out std_logic);
end component; 

component UART_tx is 
	generic(n_bits_Tx: integer:= 8; 
			  ticks_UART: integer:= 434);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_tx: in std_logic; 
		  in_buffer: in std_logic_vector(n_bits_Tx-1 downto 0); 
		  Tx: out std_logic; 
		  eof_tx: out std_logic); 
end component; 

--outs byte_divider
signal byte: std_logic_vector(7 downto 0); 
signal start_tx: std_logic; 
signal eof_tx: STD_logic;

--signal buffer_in: std_logic_vector(total_pi_bits-1 downto 0);
begin
--	buffer_in(15 downto 8) <= conv_std_logic_vector(72, 8);
--	buffer_in(7 downto 0) <= conv_std_logic_vector(10, 8);

	BD: byte_divider port map(rst, clk, start_div, eof_tx, buffer_in, 
		byte, start_tx, eof_div);
	UTx: UarT_tx generic map(n_bits_Tx, ticks_UART) port map(rst, clk, start_tx, 
		byte, Tx, eof_tx);
	

end architecture;  