library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity registerP2P is 
	generic(n: integer:= 8); 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic_vector(n-1 downto 0); 
		  Dout: out std_logic_vector(n-1 downto 0));
end entity; 

architecture despc of registerP2P is
signal Qp, Qn: std_logic_vector(n-1 downto 0); 
begin 

	secuencial:process(rst, clk, Qn)
	begin
	
		if rst = '0' then 
			Qp <= (others=>'0');
		elsif clk'event and clk = '1' then 
			Qp <= Qn;
		end if; 
	end process;

	combinacional: process(en, Din, Qp)
	begin
		if en = '1' then
			Qn <= Din; 
		else
			Qn <= Qp; 
		end if; 
	end process;
	
	Dout <= Qp; 

end architecture; 