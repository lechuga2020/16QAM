library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity registerBit is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  Din: in std_logic;
		  Dout: out std_logic);
end entity; 

architecture descp of registerBit is 
signal Qp, Qn: std_logic;
--signal temp: std_logic;
begin 

	secuencial:process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= '0';
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
	--temp <= Qp;
	Dout <= Qp;	
end architecture; 