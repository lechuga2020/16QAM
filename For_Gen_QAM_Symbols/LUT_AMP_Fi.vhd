library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity LUT_AMP_Fi is 
	port(sample: in std_logic_vector(3 downto 0);
		  fi: out std_logic_vector(total_ang_bits-1 downto 0);
		  Amp: out std_logic_vector(total_pi_bits-1 downto 0));
end entity;

architecture descp of LUT_AMP_Fi is 

begin 

	process(sample)
	begin 
		case sample is 
			when "0000" => 
				Amp <= "0000010000000000";--1.0
				fi <= "000000000000001100100100";-- 0.785156 = 45
			when "0001" => 
				fi <= "000000000000001000011000";-- 0.523438 = 30
				Amp <= "0000010000000000"; --1.0
			when "0010" => 
				Amp <= "0000100000000000"; --2.0
				fi <= "000000000000010000110000";-- 1.04688 = 60
			when "0011" => 
				Amp <= "0000100000000000"; --2.0
				fi <= "000000000000001100100100";-- 0.785156 = 45
			---------------------------------------------------
			when "0100" => 
				Amp <= "0000010000000000";--1.0
				fi <= "000000000000011001001000";-- 1.57031 = 90
			when "0101" => 
				Amp <= "0000010000000000";--1.0
				fi <= "000000000000010100111100";-- 1.30859 = 75
			when "0110" => 
				Amp <= "0000100000000000"; --2.0
				fi <= "000000000000011101010100";-- 1.83203 = 105
			when "0111" => 
				Amp <= "0000100000000000"; --2.0
				fi <= "000000000000011001001000";-- 1.57031 = 90
			-----------------------------------------------------
			when "1000" => 
				Amp <= "1111110000000000"; -- -1.0
				fi <= "000000000000011001001000";-- 1.57031 = 90
			when "1001" => 
				Amp <= "1111110000000000"; -- -1.0
				fi <= "000000000000010100111100";-- 1.30859 = 75
			when "1010" => 
				Amp <= "1111100000000000"; -- -2.0
				fi <= "000000000000011101010100";-- 1.83203 = 105
			when "1011" => 
				Amp <= "1111100000000000"; -- -2.0
				fi <= "000000000000011001001000";-- 1.57031 = 90
			----------------------------------------------------
			when "1100" => 
				Amp <= "1111110000000000"; -- -1.0
				fi <= "000000000000001100100100";-- 0.785156 = 45
			when "1101" => 
				Amp <= "1111110000000000"; -- -1.0
				fi <= "000000000000001000011000";-- 0.523438 = 30
			when "1110" => 
				Amp <= "1111100000000000"; -- -2.0
				fi <= "000000000000010000110000";-- 1.04688 = 60
			when others => 
				Amp <= "1111100000000000"; -- -2.0
				fi <= "000000000000001100100100";-- 0.785156 = 45
		end case;
	end process;
end architecture; 



