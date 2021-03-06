library IEEE;
use IEEE.std_logic_1164.all;

entity FSM_UART_Tx is
	port(rst : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 start_tx: in std_logic; 
		 ZC: in std_logic; 
		 TB: in std_logic; 
		 OPC: out std_logic_vector(1 downto 0); 
		 enm: out std_logic; 
		 OPB: out std_logic; 
		 eof_tx: out std_logic);
end entity;
architecture descp of FSM_UART_Tx is
signal Qp, Qn: integer range 0 to 6;  
begin

	secuencial:process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= 0; 
		elsif clk'event and clk = '1' then
			Qp <= Qn; 
		end if; 
	end process;   
	
	comb: process(start_tx, ZC, TB, Qp)
	begin 
	
		case Qp is
			when 0 => 
				if start_tx = '1' then 
					Qn <= 1; 
				else
					Qn <= 0; 
				end if; 
				OPC <= "00"; 
				enm <= '0'; 
				OPB <= '0'; 
				eof_tx <= '1'; 
			when 1 => 
				Qn <= 2; 
				OPC <= "01"; 
				enm <= '1'; 
				OPB <= '0'; 
				eof_tx <= '0';
			when 2 => 
				if TB = '0' then 
					Qn <= 2; 
				else
					if ZC = '1' then 
						Qn <= 3;
					else
						Qn <= 1; 
					end if;
				end if; 
				OPC <= "10"; 
				enm <= '1'; 
				OPB <= '1'; 
				eof_tx <= '0'; 
			when 3 => 
				Qn <= 4; 
				OPC <= "00"; 
				enm <= '0'; 
				OPB <= '0'; 
				eof_tx <= '0'; 
			when others => 
				if TB = '1' then 
					Qn <= 0; 
				else
					Qn <= 4; 
				end if; 
				OPC <= "00"; 
				enm <= '0'; 
				OPB <= '1'; 
				eof_tx <= '0';
		end case;
	end process; 
end descp;