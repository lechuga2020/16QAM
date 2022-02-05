library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity control_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init: in std_logic; 
		  enr: out std_logic;
		  k: out std_logic_vector(5 downto 0); 
		  eof_algor: out std_logic; 
		  eof_cordic: out std_logic);
end entity; 

architecture struct of control_module is 

component FSM_control is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init: in std_logic; 
		  ZH: in std_logic; 
		  ZC: in std_logic; 
		  OPH: out std_logic_vector(1 downto 0); 
		  enr: out std_logic;
		  OPC: out std_logic_vector(1 downto 0); 
		  eof_algor: out std_logic;
		  eof_cordic: out std_logic);
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

--outs FSM_control
signal OPH: std_logic_vector(1 downto 0); 
signal OPC: std_logic_vector(1 downto 0);
--outs of hold counter
signal ZH: std_logic; 
--outs it_counter
signal ZC: std_logic;
begin 

	FSM1: FSM_control port map(rst, clk, init, ZH, ZC, 
		OPH, enr, OPC, eof_algor, eof_cordic);
	HC: counter generic map(3) port map(rst, clk, OPH, "011", ZH);
	ITC: counter generic map(6) port map(rst, clk, OPC, it, ZC, k);

end architecture; 