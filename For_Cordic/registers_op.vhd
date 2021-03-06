library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity registers_op is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  enr: in std_logic; 
		  xx: in std_logic_vector(total_pi_bits-1 downto 0); 
		  yy: in std_logic_vector(total_pi_bits-1 downto 0); 
		  x: out std_logic_vector(total_pi_bits-1 downto 0);
		  y: out std_logic_vector(total_pi_bits-1 downto 0));
end entity;

architecture struct of registers_op is 

component registerP2P is 
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end component; 

begin 

	XReg: registerP2P generic map(total_pi_bits) port map(rst, clk, enr, 
		xx, x);
	YReg: registerP2P generic map(total_pi_bits) port map(rst, clk, enr, 
		yy, y); 	

end architecture;