library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;


entity mux_buffer is 
	port(S: in std_logic_vector(2 downto 0);
		  buffer_in: in std_logic_vector(total_pi_bits-1 downto 0); 
		  byte: out std_logic_vector(7 downto 0)); 
end entity; 

architecture descop of mux_buffer is 
begin 

	process(S, buffer_in)
	begin 
		case S is 
			when "011" => byte <= buffer_in(15 downto 8);
			when "010" => byte <= buffer_in(7 downto 0);
			when others => byte <= buffer_in(15 downto 8);
		end case; 
	end process;
end architecture; 