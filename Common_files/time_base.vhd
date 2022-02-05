library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity time_base is
	generic(freq: integer:= 100e6; 
			  newFreq: integer:= 9600);
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  OPB: in std_logic;
		  TB: out std_logic);
end entity; 

architecture desp of time_base is

signal Qp, Qn, W: integer; 
signal T, Ts: integer; 

begin
	T <= freq/(2*newFreq);  
	Ts <= T;
	secuencial:process(rst, clk, Ts, Qn)
	begin
		if rst = '0' then 
			Qp <= Ts; 
		elsif clk'event and clk = '1' then
			Qp <= Qn; 
		end if; 
	end process; 
	
	combinacional: process(T, Qp, W, OPB)
	begin
		W <= 0; 
		if OPB = '1' then
			Qn <= Qp -1; 
		else
			Qn <= T; 
		end if; 
		if Qp = W +1 then 
			TB <= '1';
			Qn <= T; 
		else
			TB <= '0';
		end if; 
	end process; 

end architecture; 