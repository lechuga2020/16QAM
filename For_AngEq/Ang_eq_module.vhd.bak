library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity Ang_eq_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  new_ang: in std_logic;
		  ang_in: in std_logic_vector(total_ang_bits-1 downto 0); 
		  angle_out: out std_logic_vector(total_pi_bits-3 downto 0);
		  sing_sine_out: out std_logic; 
		  sing_cos_out: out std_logic;
		  end_angEq: out std_logic); 
end entity;

architecture struct of Ang_eq_module is 

component combinacional_module is 
	port(ang_in: in std_logic_vector(total_ang_bits-1 downto 0); 
		  angle_out: out std_logic_vector(total_pi_bits-3 downto 0); --osea 13 downto 0= 14 bits
		  sing_sine: out std_logic; 
		  sing_cos: out std_logic);
end component;

component registers_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  en: in std_logic; 
		  angle_red: in std_logic_vector(total_pi_bits-3 downto 0);
		  sing_sine: in std_logic; 
		  sing_cos: in std_logic;
		  angle_red_reg: out std_logic_vector(total_pi_bits-3 downto 0);
		  sing_sine_reg: out std_logic; 
		  sing_cos_reg: out std_logic);
end component; 

component FSM_ANG_EQ is 
	port(rst: in std_logic;
		  clk: in std_logic; 
		  new_ang: in std_logic;
		  ZC: in std_logic; 
		  OPC: out std_logic_vector(1 downto 0); 
		  enr: out std_logic; 
		  end_angEq: out std_logic);
end component;

component counter is
	generic(n: integer:= 8); 
	port(rst: in std_logic;
		  clk: in std_logic; 
		  OP: in std_logic_vector(1 downto 0);
		  T: in std_logic_vector(n-1 downto 0); 
		  Z: out std_logic;
		  count: out std_logic_vector(n-1 downto 0));
end component; 

--outs angle_reductor
signal angle_red: std_logic_vector(total_pi_bits-3 downto 0);
signal sing_sine: std_logic; 
signal sing_cos: std_logic;
--outs FSM
signal OPC: std_logic_vector(1 downto 0); 
signal enr: std_logic; 
--outs counter
signal ZC: std_logic; 
begin 


	CM: combinacional_module port map(ang_in, angle_red, sing_sine, sing_cos);
	RM: registers_module port map(rst, clk, enr, angle_red, sing_sine, sing_cos, 
		angle_out, sing_sine_out, sing_cos_out);
	FSM: FSM_ANG_EQ port map(rst, clk, new_ang, ZC, OPC, enr, end_angEq);
	HC: counter generic map(4) port map(rst, clk, OPC, "0101", ZC); 

end architecture;  
