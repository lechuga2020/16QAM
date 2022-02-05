library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;
entity registers_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  angle_red: in std_logic_vector(total_pi_bits-3 downto 0);
		  sing_sine: in std_logic; 
		  sing_cos: in std_logic;
		  angle_red_reg: out std_logic_vector(total_pi_bits-3 downto 0);
		  sing_sine_reg: out std_logic; 
		  sing_cos_reg: out std_logic);
end entity; 

architecture struct of registers_module is 

component registerP2P is
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end component;

component registerBit is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic;
		  Dout: out std_logic);
end component; 

begin 

	AngleReg: registerP2P generic map(total_pi_bits-2) port map(rst, clk, en, 
		angle_red, angle_red_reg);
	
	SSIneR:registerBit port map(rst, clk, en, sing_sine, sing_sine_reg);
	SCosR: registerBit port map(rst, clk, en, sing_cos, sing_cos_reg);
	
--	SSineR: registerBit port map(rst, clk, en, sing_sine, sing_sine_reg);
--	SCosR: registerBit port map(rst, clk, en, sing_cos, sing_cos_reg);

end architecture; 