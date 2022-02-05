library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity sineCos_module is 
	port(rst: in std_logic; 
		  clk: in std_logic;
		  Amp: in std_logic_vector(total_pi_bits-1 downto 0);
		  x: in std_logic_vector(total_pi_bits-1 downto 0);
		  y: in std_logic_vector(total_pi_bits-1 downto 0);
		  sing_cos: in std_logic;
		  sing_sine: in std_logic;
		  eof_algor: in std_logic;
		  cos: out std_logic_vector(total_pi_bits-1 downto 0);
		  sine: out std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture struct of sineCos_module is 

component SpecialCa2 is 
	port(sing: in std_logic; 
		  a: in std_logic_vector(total_pi_bits-1 downto 0); 
		  b: out std_logic_vector(total_pi_bits-1 downto 0));
end component;

component registerP2P is 
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end component; 
signal cos_ca2: std_logic_vector(total_pi_bits-1 downto 0); 
signal sine_ca2: std_logic_vector(total_pi_bits-1 downto 0);
signal cos_Reg: std_logic_vector(total_pi_bits-1 downto 0); 
signal sine_Reg: std_logic_vector(total_pi_bits-1 downto 0); 
signal Amp_reg: std_logic_vector(total_pi_bits-1 downto 0); 
signal MulpCos: std_logic_vector(2*total_pi_bits-1 downto 0);
signal MulpSine: std_logic_vector(2*total_pi_bits-1 downto 0);  
begin 

	CosCa2: SpecialCa2 port map(sing_cos, x, cos_ca2);
	SinCa2: SpecialCa2 port map(sing_sine, y, sine_ca2); 	
	AmpReg: registerP2P generic map(total_pi_bits) 
		port map(rst, clk, eof_algor, Amp, Amp_reg); 
	CosReg: registerP2P generic map(total_pi_bits) port map(rst, clk, eof_algor, 
		cos_ca2, cos_Reg);
	SinReg: registerP2P generic map(total_pi_bits) port map(rst, clk, eof_algor, 
		sine_ca2, sine_Reg);
	
	mulpCos <= signed(Amp_reg)*signed(cos_Reg); 
	mulpSine <= signed(Amp_reg)*signed(sine_Reg); 
	
	sine <= mulpSine(25 downto 10);
	cos <= mulpCos(25 downto 10);

end architecture;





