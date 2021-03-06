library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity mux_symbol is 
	port(sample: in std_logic_vector(7 downto 0); 
		  k_sample: in std_logic_vector(1 downto 0);
		  symbol: out std_logic_vector(3 downto 0));
end entity; 

architecture despc of mux_symbol is 

begin
	
	symbol <= sample(3 downto 0) when k_sample = "00" 
		else sample(7 downto 4); 

end architecture;