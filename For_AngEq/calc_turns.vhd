library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity calc_turns is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  k_turns: out std_logic_vector(9 downto 0)); 
end entity; 

architecture desp of calc_turns is 
signal uno_entre_2pi: std_logic_vector(total_pi_bits-1 downto 0);
signal multp: std_logic_vector(total_pi_bits+total_ang_bits-1 downto 0);
constant temp1: integer:= fraq_pi_bits+fraq_ang_bits;
constant temp2: integer:= temp1+9;
begin 

	uno_entre_2pi <= "0000000010100010"; --1/2pi = 0.158203
	multp <= unsigned(ang_in)*unsigned(uno_entre_2pi);
	k_turns <= multp(temp2 downto temp1); -- esto me deberia dar solo 10 bits

end architecture; 
