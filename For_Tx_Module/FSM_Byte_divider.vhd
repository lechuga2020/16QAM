library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity FSM_Byte_divider is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  start_div: in std_logic; 
		  eof_Tx: in std_logic; 
		  ZC: in std_logic; 
		  start_tx: out std_logic; 
		  OPC: out std_logic_vector(1 downto 0); 
		  eof_div: out std_logic);
end entity; 

architecture descp of FSM_Byte_divider is 
signal Qp, Qn: integer range 0 to 6; 
begin 

	seq: process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= 0;
		elsif clk'event and clk = '1' then 
			Qp <= Qn; 
		end if; 
	end process;
	
	comb: process(start_div, eof_Tx, ZC, Qp)
	begin 
	
		case Qp is
			when 0 => 
				if start_div = '1' then 
					Qn <= 1;  
				else
					Qn <= 0;
				end if; 
				start_tx <= '0'; 
				OPC <= "00"; 
				eof_div <= '0';
			when 1 => 
				Qn <= 2; 
				start_tx <= '1'; 
				OPC <= "10"; 
				eof_div <= '0';
			when 2 => 
				if eof_Tx = '1' then
					Qn <= 3;  
				else
					Qn <= 2; 
				end if; 
				start_tx <= '0'; 
				OPC <= "10"; 
				eof_div <= '0';
			when 3 => 
				Qn <= 4;  
				start_tx <= '0'; 
				OPC <= "01"; 
				eof_div <= '0';
			when 4 => 
				if ZC = '1' then
					Qn <= 5;  
				else
					Qn <= 1; 
				end if; 
				start_tx <= '0'; 
				OPC <= "10"; 
				eof_div <= '0';
			when others => 
				Qn <= 0; 
				start_tx <= '0'; 
				OPC <= "00"; 
				eof_div <= '1';
		end case; 
	end process; 
end architecture; 



