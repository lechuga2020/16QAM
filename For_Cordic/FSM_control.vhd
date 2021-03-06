library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity FSM_control is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init: in std_logic; 
		  ZH: in std_logic; 
		  ZC: in std_logic; 
		  OPH: out std_logic_vector(1 downto 0); 
		  enr: out std_logic;
		  OPC: out std_logic_vector(1 downto 0); 
		  eof_algor: out std_logic;
		  eof_cordic: out std_logic);
end entity; 

architecture descp of FSM_control is 
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
	
	comb: process(init, ZH, ZC, Qp)
	begin 
		case Qp is 
			when 0 => 
				if init = '1' then 
					Qn <= 1; 
				else
					Qn <= 0; 
				end if;
				
				OPH <= "00";
				enr <= '0';
				OPC <= "00";
				eof_algor <= '0';
				eof_cordic <= '0';
			when 1 => 
				if ZH = '1' then 
					Qn <= 2; 
				else
					Qn <= 1; 
				end if;
				OPH <= "01";
				enr <= '0';
				OPC <= "10";
				eof_algor <= '0';
				eof_cordic <= '0'; 
			when 2 => 
				Qn <= 3;
				OPH <= "00";
				enr <= '1';
				OPC <= "10";
				eof_algor <= '0';
				eof_cordic <= '0';
			when 3 => 
				if ZC = '1' then 
					Qn <= 4; 
				else
					Qn <= 1; 
				end if;
				OPH <= "00";
				enr <= '0';
				OPC <= "01";
				eof_algor <= '0';
				eof_cordic <= '0';
			when 4 => 
				Qn <= 5;
				OPH <= "00";
				enr <= '0'; 
				OPC <= "00";
				eof_algor <= '1';
				eof_cordic <= '0';
			when others => 
				Qn <= 0;
				OPH <= "00";
				enr <= '0';
				OPC <= "00";
				eof_algor <= '0';
				eof_cordic <= '1';
		end case; 
	end process;

end architecture;