library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity QAM_Symbols is 
	port(sample: in std_logic_vector(7 downto 0); 
		  k_sample: in std_logic_vector(1 downto 0); 
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0);
		  fi: out std_logic_vector(total_ang_bits-1 downto 0)); 
end entity; 

architecture struct of QAM_Symbols is 

component mux_symbol is 
	port(sample: in std_logic_vector(7 downto 0); 
		  k_sample: in std_logic_vector(1 downto 0);
		  symbol: out std_logic_vector(3 downto 0));
end component;

component LUT_AMP_Fi is 
	port(sample: in std_logic_vector(3 downto 0);
		  fi: out std_logic_vector(total_ang_bits-1 downto 0);
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0));
end component;

--outs of mux_symbol
signal symbol: std_logic_vector(3 downto 0);
begin 

	MS: mux_symbol port map(sample, k_sample, symbol);
	LUTAmpFi: Lut_AMP_Fi port map(symbol, fi, Amp);
	
end architecture; 