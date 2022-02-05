library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;


entity LUT_THETA is 
	port(k: in integer range 0 to 40; 
		  Z: out std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture desp of LUT_THETA is 

begin 
	process(k)
	begin 
		case k is 
			when 1 => Z <= THETHA(1);
			when 2 => Z <= THETHA(2);
			when 3 => Z <= THETHA(3);
			when 4 => Z <= THETHA(4);
			when 5 => Z <= THETHA(5);
			when 6 => Z <= THETHA(6);
			when 7 => Z <= THETHA(7);
			when 8 => Z <= THETHA(8);
			when 9 => Z <= THETHA(9);
			when others => Z <= THETHA(10);
		end case;
	end process;
end architecture;