library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
PACKAGE myTypes IS
	constant int_ang_bits: integer:= 14;
	constant fraq_ang_bits: integer:= 10; 
	constant total_ang_bits: integer:= int_ang_bits+fraq_ang_bits; 
	
	constant int_pi_bits: integer:= 6;
	constant fraq_pi_bits: integer:= 10;  
	constant total_pi_bits: integer:= int_pi_bits + fraq_pi_bits; 

	constant vuelta: std_logic_vector(total_pi_bits-1 downto 0):= "0001100100100001"; -- 2pi = 6.28223
	constant tresMedios_pi: std_logic_vector(total_pi_bits-1 downto 0):= "0001001011011001"; --(3/2)*pi
	constant pi: std_logic_vector(total_pi_bits-1 downto 0):= "0000110010010000"; -- pi
	constant pi_medios: std_logic_vector(total_pi_bits-1 downto 0):= "0000011001001000"; --pi/2
	
	constant it: std_logic_vector(5 downto 0):= "001010"; --iterator = 10
	constant it_int: integer range 0 to 40:= conv_integer(unsigned(it));
	
	type array_samples is array (it_int downto 1) of std_logic_vector(total_pi_bits-1 downto 0);
	constant THETHA: array_samples:= (  "0000001100100100", "0000000111011010", 
	"0000000011111010", "0000000001111111", "0000000000111111", "0000000000011111", 
	"0000000000001111", "0000000000000111", "0000000000000011", "0000000000000001"); 
	
	--constant LUT_THETHA: array_samples:= (0.785156,0.462891,
	--0.244141, 	0.124023,	0.0615234,	0.0302734,
	--0.0146484,	0.00683594,	0.00292969,	0.000976562,);
	
	constant two_k_array: array_samples:= ("0000010000000000", "0000001000000000", 
	"0000000100000000", "0000000010000000", "0000000001000000", "0000000000100000", 
	"0000000000010000", "0000000000001000", "0000000000000100", "0000000000000010");
	
	--constant two_k: array_samplesarray_samples:= (1, 0.5, 
	--0.25, 		0.125, 	  0.0625, 	  0.03125, 
	--0.015625, 0.0078125, 0.00390625, 0.00195312, );

END myTypes;

package body myTypes is
end; 