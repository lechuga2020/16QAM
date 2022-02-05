library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity FSM_ANG_EQ is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  new_ang: in std_logic;
		  ZC: in std_logic; 
		  OPC: out std_logic_vector(1 downto 0); 
		  enr: out std_logic; 
		  end_angEq: out std_logic);
end entity;

architecture descp of FSM_ANG_EQ is 
signal Qp, Qn: integer range 0 to 4; 
begin 

	secuencial:process(rst, clk, Qn)
	begin
	
		if rst = '0' then 
			Qp <= 0;
		elsif clk'event and clk = '1' then 
			Qp <= Qn;
		end if; 
	end process;
	
	comb:process(new_ang, ZC, Qp)
	begin
		case Qp is 
			when 0 => 
				if new_ang = '1' then 
					Qn <= 1;
				else
					Qn <= 0;
				end if;
				OPC <= "00"; 
				enr <= '0'; 
				end_angEq <= '0';
			when 1 => 
				if ZC = '1' then 
					Qn <= 2;
				else
					Qn <= 1;
				end if;
				OPC <= "01"; 
				enr <= '0'; 
				end_angEq <= '0';
			when 2 => 
				Qn <= 3;
				OPC <= "00"; 
				enr <= '1'; 
				end_angEq <= '0';
			when others => 
				Qn <= 0;
				OPC <= "00"; 
				enr <= '0'; 
				end_angEq <= '1';
		end case;
	end process;
end architecture; 