library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity ang_calculator is 
	port(Wc: in std_logic_vector(total_ang_bits-1 downto 0);
		  k: in std_logic_vector(total_ang_bits-1 downto 0);
		  fi: in std_logic_vector(total_ang_bits-1 downto 0); 
		  ang: out std_logic_vector(total_ang_bits-1 downto 0));
end entity; 


architecture descp of ang_calculator is 

signal multp: std_logic_vector(2*total_ang_bits-1 downto 0);
signal Wck: std_logic_vector(total_ang_bits-1 downto 0); 
begin 

	multp <= signed(Wc)*signed(k); 
	Wck <= multp((2*total_ang_bits)-int_ang_bits-1 downto fraq_ang_bits);
	ang <= signed(WcK)+signed(fi);

end architecture;