library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity mux_op_module is 
	port(bigger: in std_logic;
		  z: in std_logic_vector(total_pi_bits-1 downto 0);  
		  multpx: in std_logic_vector(total_pi_bits-1 downto 0); 
		  x: in std_logic_vector(total_pi_bits-1 downto 0);
		  multpy: in std_logic_vector(total_pi_bits-1 downto 0); 
		  y: in std_logic_vector(total_pi_bits-1 downto 0); 
		  ang: in std_logic_vector(total_pi_bits-1 downto 0); 
		  xx: out std_logic_vector(total_pi_bits-1 downto 0);
		  yy: out std_logic_vector(total_pi_bits-1 downto 0);
		  new_ang: out std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture descp of mux_op_module is 
begin
	
	process(bigger, multpx, x, multpy, y, ang, z)
	begin 
		if bigger = '1' then 
			xx <= signed(x)-signed(multpy); 
			yy <= signed(y)+signed(multpx); 
			new_ang <= signed(ang) - signed(z);
		else
			xx <= signed(x)+signed(multpy); 
			yy <= signed(y)-signed(multpx); 
			new_ang <= signed(ang) + signed(z);
		end if; 
	end process; 


end architecture;