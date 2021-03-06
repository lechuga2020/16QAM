library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;


entity FSM_Ang_Gen is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_gen: in std_logic; 
		  TB: in std_logic; 
		  ZS: in std_logic; 
		  eof_div: in std_logic;
		  enr: out std_logic; 
		  new_angle: out std_logic; 
		  OPB: out std_logic; 
		  OPS: out std_logic_vector(1 downto 0));
end entity; 

architecture descp of FSM_Ang_Gen is 

signal Qp, Qn: integer range 0 to 11; 

begin 
	
	secuencial:process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= 0;
		elsif clk'event and clk = '1' then 
			Qp <= Qn;
		end if; 
	end process;
	
	comb:process(init_gen, TB, ZS, eof_div, Qp)
	begin 
		case Qp is
			when 0 =>
				if init_gen = '1' then 
					Qn <= 1; 
				else
					Qn <= 0; 
				end if;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "00";
			when 1 =>
				if init_gen = '1' then 
					Qn <= 7; 
				else
					Qn <= 2; 
				end if;
				enr <= '1'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "10";
			when 2 => 
				if init_gen = '1' then
					Qn <= 6;
				else 
					Qn <= 3;
				end if;
				enr <= '0'; 
				new_angle <= '1'; 
				OPB <= '0'; 
				OPS <= "10";
			when 3 => 
				if init_gen = '1' and TB = '1' then
					Qn <= 6;
				elsif init_gen = '0' and TB = '1' then
					Qn <= 4; 
				elsif init_gen = '1' and TB  = '0' then 
					Qn <= 8; 
				else
					Qn <= 3; 
--					if TB = '1' then 
--						Qn <= 4; 
--					else 
--						Qn <= 3; 
--					end if;
				end if;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '1'; 
				OPS <= "10";
			when 4 => 
				if init_gen = '1' or ZS = '1'then
					Qn <= 6;
				else 
					Qn <= 5;
				end if;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "01";
			when 5 => 
				if init_gen = '1' then
					Qn <= 6;
				else 
					if eof_div = '1' then 
						Qn <= 1; 
					else 
						Qn <= 5; 
					end if;
				end if;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "10";
			when 6 => 
				if eof_div = '1' then 
					Qn <= 1; 
				else 
					Qn <= 6; 
				end if;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "00";
			when 8 => 
				if TB = '1' and eof_div = '1' then 
					Qn <= 1; 
				elsif TB = '1' and eof_div = '0' then 
					Qn <= 6; 
				elsif TB = '0' and eof_div = '1' then 
					Qn <= 9; 
				else
					Qn <= 8;
				end if; 
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '1'; 
				OPS <= "00";
			when 9 => 
				if TB = '1' then 
					Qn <= 1;
				else
					Qn <= 9;
				end if; 
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "00";
			when others =>
				Qn <= 1;
				enr <= '0'; 
				new_angle <= '0'; 
				OPB <= '0'; 
				OPS <= "00";	
		end case; 
	end process; 
end architecture; 