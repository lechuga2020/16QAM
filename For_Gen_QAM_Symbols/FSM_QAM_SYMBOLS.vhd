library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity FSM_QAM_SYMBOLS is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  init_symb: in std_logic; 
		  TB: in std_logic; 
		  ZS: in std_logic; 
		  ZC: in std_logic; 
		  OPB: out std_logic; 
		  OPS: out std_logic_vector(1 downto 0); 
		  OPC: out std_logic_vector(1 downto 0); 
		  init_gen_ang: out std_logic; 
		  eof_symb: out std_logic);
end entity; 

architecture descpo of FSM_QAM_SYMBOLS is 
signal Qp, Qn: integer range 0 to 10; 
begin 

	secuencial:process(rst, clk, Qn)
	begin
		if rst = '0' then 
			Qp <= 0;
		elsif clk'event and clk = '1' then 
			Qp <= Qn;
		end if; 
	end process;
	
	comb: process(init_symb, TB, ZS, ZC, Qp)
	begin
		case Qp is 
			when 0 => 
				if init_symb = '1' then 
					Qn <= 1; 
				else 
					Qn <= 0; 
				end if;
				OPB <= '0'; 
				OPS <= "00"; 
				OPC <= "00"; 
				init_gen_ang <= '0'; 
				eof_symb <= '0';
			when 1 => 
				Qn <= 2; 
				OPB <= '0'; 
				OPS <= "10"; 
				OPC <= "10"; 
				init_gen_ang <= '1'; 
				eof_symb <= '0'; 	
			when 2 => 
				if TB = '1' then 
					Qn <= 3; 
				else 
					Qn <= 2; 
				end if;
				OPB <= '1'; 
				OPS <= "10"; 
				OPC <= "10"; 
				init_gen_ang <= '0'; 
				eof_symb <= '0'; 
			when 3 => 
				if ZS = '1' then 
					Qn <= 4; 
				else 
					Qn <= 1; 
				end if;
				OPB <= '0'; 
				OPS <= "01"; 
				OPC <= "10"; 
				init_gen_ang <= '0'; 
				eof_symb <= '0';
			when 4 => 
				if ZC = '1' then 
					Qn <= 6; 
				else 
					Qn <= 1; 
				end if;
				OPB <= '0'; 
				OPS <= "00"; 
				OPC <= "01"; 
				init_gen_ang <= '0'; 
				eof_symb <= '0'; 
			when others => 
				Qn <= 0;
				OPB <= '0'; 
				OPS <= "00"; 
				OPC <= "00"; 
				init_gen_ang <= '0'; 
				eof_symb <= '1'; 
		end case; 
	end process;

end architecture; 
