library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity LUT_2k is 
	port(k: in integer range 0 to 40; 
		  two_k: out std_logic_vector(total_pi_bits-1 downto 0));
end entity;

architecture descp of LUT_2k is 

begin 

	process(k)
	begin 
		case k is 
			when 1 => two_k <= two_k_array(1);
			when 2 => two_k <= two_k_array(2);
			when 3 => two_k <= two_k_array(3);
			when 4 => two_k <= two_k_array(4);
			when 5 => two_k <= two_k_array(5);
			when 6 => two_k <= two_k_array(6);
			when 7 => two_k <= two_k_array(7);
			when 8 => two_k <= two_k_array(8);
			when 9 => two_k <= two_k_array(9);
			when others => two_k <= two_k_array(10);
		end case;
	end process;


end architecture; 