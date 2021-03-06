library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity byte_divider is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_div: in std_logic;
		  eof_tx: in std_logic; 
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  byte: out std_logic_vector(7 downto 0); 
		  start_tx: out std_logic; 
		  eof_div: out std_logic);
end entity; 

architecture struct of byte_divider is 

component mux_buffer is 
	port(S: in std_logic_vector(2 downto 0);
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  byte: out std_logic_vector(7 downto 0)); 
end component; 

component FSM_Byte_divider is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_div: in std_logic; 
		  eof_Tx: in std_logic; 
		  ZC: in std_logic; 
		  start_tx: out std_logic; 
		  OPC: out std_logic_vector(1 downto 0); 
		  eof_div: out std_logic);
end component; 

component counter is
	generic(n: integer:= 8); 
	port(rst: in std_logic;
		  clk: in std_logic; 
		  OP: in std_logic_vector(1 downto 0);
		  T: in std_logic_vector(n-1 downto 0); 
		  Z: out std_logic;
		  count: out std_logic_vector(n-1 downto 0));
end component; 

--outs FSM_Byte_divider
signal OPC: std_logic_vector(1 downto 0); 
--outs counter
signal count: std_logic_vector(2 downto 0);
signal ZC: std_logic; 
begin 

	MB: Mux_buffer port map(count, buffer_in, byte);
	FSM1: FSM_Byte_divider port map(rst, clk, start_div, eof_Tx, ZC, 
		start_tx, OPC, eof_div);
	CNT: counter generic map(3) port map(rst, clk, OPC, "011", ZC, count);
	



end architecture; 