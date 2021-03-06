library IEEE;
use IEEE.std_logic_1164.all;

entity UART_tx is 
	generic(n_bits_Tx: integer:= 8; 
			  ticks_UART: integer:= 434);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_tx: in std_logic; 
		  in_buffer: in std_logic_vector(n_bits_Tx-1 downto 0); 
		  Tx: out std_logic; 
		  eof_tx: out std_logic); 
end entity; 

architecture struct of UART_tx is

component special_time_base is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  OPB: in std_logic;
		  limit: in integer; 
		  TB: out std_logic);
end component;

component FSM_UART_Tx is
	port(rst : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 start_tx: in std_logic; 
		 ZC: in std_logic; 
		 TB: in std_logic; 
		 OPC: out std_logic_vector(1 downto 0); 
		 enm: out std_logic; 
		 OPB: out std_logic; 
		 eof_tx: out std_logic);
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

component muxTx is 
	generic(n_bits_Tx: integer:= 8);
	port(in_buffer: in std_logic_vector(n_bits_Tx - 1 downto 0);
		 enMux: in std_logic;
		 S: in std_logic_vector(7 downto 0);
		 Tx: out std_logic);
end component;

--outs time_base
signal TB: std_LOGIC; 
--outs FSM
signal OPC: std_logic_vector(1 downto 0); 
signal enm: std_LOGIC; 
signal OPB: std_logic; 
--outs counter
signal ZC: std_logic; 
signal count: std_logic_vector(7 downto 0); 


begin 

	TB1: special_time_base port map(rst, clk, OPB, ticks_UART ,TB);
	FSM1: FSM_UART_Tx port map(rst, clk, start_tx, ZC, TB, OPC, enm, OPB, eof_tx);
	CNT: counter generic map(8) port map(rst, clk, OPC, "00001011", ZC, count);
	MUX: muxTx generic map(n_bits_Tx) port map(in_buffer, enm, count, Tx);
	

end architecture; 