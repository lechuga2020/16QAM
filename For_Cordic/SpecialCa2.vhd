library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity SpecialCa2 is 
	port(sing: in std_logic; 
		  a: in std_logic_vector(total_pi_bits-1 downto 0); 
		  b: out std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture descp of SpecialCa2 is 
signal one: std_logic_vector(total_pi_bits-1 downto 0);
begin 
	
	one <= conv_std_logic_vector(1, a'length);
	
	b <= a when sing = '0' 
		else signed(not(a)) + signed(one);

end architecture; 