library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter is
	generic(n: integer:= 8); 
	port(rst: in std_logic;
		  clk: in std_logic; 
		  OP: in std_logic_vector(1 downto 0);
		  T: in std_logic_vector(n-1 downto 0); 
		  Z: out std_logic;
		  count: out std_logic_vector(n-1 downto 0));
end entity; 

architecture descp of counter is

signal Qp, Qn, W: std_logic_vector(n-1 downto 0); 
signal Ts: std_logic_vector(n-1 downto 0);
begin
	W <= (others=>'0');
	Ts <= T; 
	secuencial:process(rst, clk, Qn, Ts)
	begin
		if rst = '0' then 
			Qp <= Ts;
		elsif clk'event and clk = '1' then 
			Qp <= Qn;
		end if; 
	end process;
	
	combinacional: process(OP, T, Qp, W)
	begin
		if OP = "01" then
			Qn <= Qp -1; 
		elsif OP = "00" then
			Qn <= T; 
		else
			Qn <= Qp; 
		end if; 
		if QP = W+1 then
			Z <= '1';
		else
			Z <= '0'; 
		end if; 
	end process; 
	count <= Qp; 
end architecture; 