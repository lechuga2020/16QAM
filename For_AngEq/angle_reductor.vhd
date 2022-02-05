library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity angle_reductor is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  ang_red: buffer std_logic_vector(total_pi_bits-1 downto 0));
end entity;

architecture struct of angle_reductor is 

component calc_turns is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  k_turns: out std_logic_vector(9 downto 0)); 
end component; 

component reduce_angle is
	port(k_turns: in std_logic_vector(9 downto 0);
		  ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  ang_red: buffer std_logic_vector(total_pi_bits-1 downto 0));
end component;

--outs calc_turns
signal k_turns: std_logic_vector(9 downto 0);

begin 

	CT: calc_turns port map(ang_in, k_turns); 
	RD: reduce_angle port map(k_turns, ang_in, ang_red); 

end architecture; 