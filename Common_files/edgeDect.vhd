library IEEE;
use IEEE.std_logic_1164.all;

entity edgeDect is
	port(rst: in std_logic;
		  clk: in std_logic;
		  Din: in std_logic; 
		  trig: out std_logic); 
end entity; 

architecture struct of edgeDect is

component FlipFlop is
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  Din: in std_logic; 
		  Dout: out std_logic);
end component; 

signal D1, D2, D3: std_logic; 

begin

	FF1: FlipFlop port map(rst, clk, Din, D1);
	FF2: FlipFlop port map(rst, clk, D1, D2);
	FF3: FlipFlop port map(rst, clk, D2, D3); 
	
	trig <= D2 and not D3; 

end architecture; 