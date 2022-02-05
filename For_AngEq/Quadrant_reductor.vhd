library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;
--total_pi_bits = 16 
entity Quadrant_reductor is 
	port(angle: in std_logic_vector(total_pi_bits-1 downto 0);
		  angle_out: out std_logic_vector(total_pi_bits-3 downto 0); --osea 13 downto 0= 14 bits
		  sing_sine: out std_logic; 
		  sing_cos: out std_logic); 
end entity;

architecture descp of Quadrant_reductor is 
begin 

	process(angle)
	variable rest: std_logic_vector(total_pi_bits-1 downto 0);
	begin 
		if angle <= vuelta and angle > tresMedios_pi then 
			rest := unsigned(vuelta) - unsigned(angle); 
			sing_sine <= '1';
			sing_cos <= '0'; 
		elsif angle <= tresMedios_pi and angle > pi then 
			rest := unsigned(angle) - unsigned(pi); 
			sing_sine <= '1'; 
			sing_cos <= '1';
		elsif angle <= pi and angle > pi_medios then
			rest := unsigned(pi) - unsigned(angle); 
			sing_sine <= '0'; 
			sing_cos <= '1';
		else
			rest := angle;
			sing_sine <= '0'; 
			sing_cos <= '0';
		end if; 
		angle_out <= rest(total_pi_bits-3 downto 0);
	end process; 
	
end architecture;
