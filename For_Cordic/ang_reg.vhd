library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity ang_reg is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  enr: in std_logic; 
		  k: in integer range 0 to 40;
		  ang_init: in std_logic_vector(total_pi_bits-1 downto 0); 
		  new_angle: in std_logic_vector(total_pi_bits-1 downto 0); 
		  ang: out std_logic_vector(total_pi_bits-1 downto 0));
end entity;

architecture struct of ang_reg is

component registerP2P is 
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end component; 

signal ang_reg: std_logic_vector(total_pi_bits-1 downto 0);
begin 
	
	AR: registerP2P generic map(total_pi_bits) port map(rst, clk, enr, new_angle, ang_reg);
	ang <= ang_init when k >= it_int else ang_reg;
	

end architecture;