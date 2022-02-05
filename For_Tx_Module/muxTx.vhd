library IEEE;
use IEEE.std_logic_1164.all;
entity muxTx is 
	generic(n_bits_Tx: integer:= 8);
	port(in_buffer: in std_logic_vector(n_bits_Tx - 1 downto 0);
		 enMux: in std_logic;
		 S: in std_logic_vector(7 downto 0);
		 Tx: out std_logic);
end entity;

architecture descp of MuxTx is


begin 

	comb: process(enMux, S, in_buffer)
	begin
		if enMux = '1' then
			case S is 
				when "00000001" => Tx <='1'; -- 1
				when "00000010" => Tx <= in_buffer(7); -- 2
				when "00000011" => Tx <= in_buffer(6); -- 3
				when "00000100" => Tx <= in_buffer(5); -- 4
				when "00000101" => Tx <= in_buffer(4); -- 5
				when "00000110" => Tx <= in_buffer(3); -- 6
				when "00000111" => Tx <= in_buffer(2); -- 7
				when "00001000" => Tx <= in_buffer(1); -- 8
				when "00001001" => Tx <= in_buffer(0); -- 9
				when "00001010" => Tx <= '0'; -- 10
				when others => Tx <= '1';
			end case;
		else
			Tx <= '1';
		end if;
	end process;

end architecture; 