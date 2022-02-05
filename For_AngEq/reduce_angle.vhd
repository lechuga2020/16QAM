library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity reduce_angle is
	port(k_turns: in std_logic_vector(9 downto 0);
		  ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  ang_red: buffer std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture descp of reduce_angle is 
signal ang_red_signal: std_logic_vector(total_pi_bits-1 downto 0);
begin 

	process(k_turns, ang_in)
	variable multp: std_logic_vector(total_pi_bits+9 downto 0); 
	variable multp2: std_logic_vector(total_ang_bits-1 downto 0); 
	variable rest: std_logic_vector(total_ang_bits-1 downto 0);
	begin
		if k_turns >= "0000000001" then 
			multp:= unsigned(k_turns)*unsigned(vuelta); 
			multp2:= multp(total_ang_bits-1 downto 0);
			rest  := unsigned(ang_in)-unsigned(multp2); 
			ang_red_signal <= rest(total_pi_bits-1 downto 0); 
		else
			ang_red_signal <= ang_in(total_pi_bits-1 downto 0);  
		end if; 
	end process; 
	
	check:process(ang_red_signal)
	begin 
		if ang_red_signal >= vuelta then
			ang_red <= unsigned(ang_red_signal) - unsigned(vuelta);
		else
			ang_red <= ang_red_signal;
		end if;
	end process;
end architecture; 