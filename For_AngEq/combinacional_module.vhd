library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity combinacional_module is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0); 
		  angle_out: out std_logic_vector(total_pi_bits-3 downto 0); --osea 13 downto 0= 14 bits
		  sing_sine: out std_logic; 
		  sing_cos: out std_logic);
end entity; 

architecture struct of combinacional_module is 

component angle_reductor is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0);
		  ang_red: buffer std_logic_vector(total_pi_bits-1 downto 0));
end component;

component Quadrant_reductor is 
	port(angle: in std_logic_vector(total_pi_bits-1 downto 0);
		  angle_out: out std_logic_vector(total_pi_bits-3 downto 0); --osea 13 downto 0= 14 bits
		  sing_sine: out std_logic; 
		  sing_cos: out std_logic); 
end component;

--outs angle_reductor
signal ang_red: std_logic_vector(total_pi_bits-1 downto 0);
begin 

	AR: angle_reductor port map(ang_in, ang_red);
	QR: Quadrant_reductor port map(ang_red, angle_out, sing_sine, sing_cos);

end architecture; 