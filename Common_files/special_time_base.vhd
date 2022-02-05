library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity special_time_base is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  OPB: in std_logic;
		  limit: in integer; 
		  TB: out std_logic);
end entity;

architecture descp of special_time_base is 
signal Qp, Qn: integer;
signal W: integer;  
begin 

	W <= 0; 
	secuencial:process(rst, clk, limit, Qn)
	begin
		if rst = '0' then 
			Qp <= limit;
		elsif clk'event and clk = '1' then
			Qp <= Qn; 
		end if; 
	end process; 
	
	comb: process(OPB, limit, W, Qp)
	begin
		if OPB = '1' then
			Qn <= Qp -1; 
		else
			Qn <= limit; 
		end if; 
		if Qp = W +1 then 
			TB <= '1';
			Qn <= limit; 
		else
			TB <= '0';
		end if; 
	end process; 

end architecture;