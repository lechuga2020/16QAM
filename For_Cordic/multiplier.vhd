library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity multiplier is 
	generic(int: integer:= 6; 
		     fraq: integer:= 10);
	port(a: in std_logic_vector(int+fraq-1 downto 0); 
		  b: in std_logic_vector(int+fraq-1 downto 0); 
		  c: out std_logic_vector(int+fraq-1 downto 0));
end entity;  

architecture descp of multiplier is 
signal multp: std_logic_vector((int+fraq)*2-1 downto 0); 
constant total: integer:= int+fraq; 
begin 

	multp <= signed(a)*signed(b); 
	c <= multp((2*total)-int-1 downto fraq); 
end architecture; 