library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity FlipFlop is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  Din: in std_logic; 
		  Dout: out std_logic);
end entity; 

architecture descp of FlipFlop is
signal Qp, Qn: std_logic;
begin

	seq:process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= '0'; 
		elsif clk'event and clk = '1' then 
			Qp <= Qn;   
		end if; 
	end process;
	
	Qn <= Din; 
	Dout <= Qp; 

end architecture;