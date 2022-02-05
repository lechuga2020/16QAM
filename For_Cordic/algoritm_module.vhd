library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity algoritm_module is 
	port(rst: in std_logic;
			clk: in std_logic; 
			ang_init: in std_logic_vector(total_pi_bits-1 downto 0); 
			enr: in std_logic; 
			k: in integer range 0 to 40; 
			x: out std_logic_vector(total_pi_bits-1 downto 0); 
			y: out std_logic_vector(total_pi_bits-1 downto 0));
end entity; 

architecture struc of algoritm_module is

component ang_reg is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  enr: in std_logic; 
		  k: in integer range 0 to 40;
		  ang_init: in std_logic_vector(total_pi_bits-1 downto 0); 
		  new_angle: in std_logic_vector(total_pi_bits-1 downto 0); 
		  ang: out std_logic_vector(total_pi_bits-1 downto 0));
end component;

component operations_module is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  bigger: in std_logic; 
		  enr: in std_logic; 
		  k: in integer range 0 to 40; 
		  ang: in std_logic_vector(total_pi_bits-1 downto 0);
		  xx: in std_logic_vector(total_pi_bits-1 downto 0); 
		  yy: in std_logic_vector(total_pi_bits-1 downto 0); 
		  xx_out: out std_logic_vector(total_pi_bits-1 downto 0);
		  yy_out: out std_logic_vector(total_pi_bits-1 downto 0); 
		  y: out std_logic_vector(total_pi_bits-1 downto 0); 
		  x: out std_logic_vector(total_pi_bits-1 downto 0); 
		  new_ang: out std_logic_vector(total_pi_bits-1 downto 0));
end component; 

--outs ang_reg
signal ang: std_logic_vector(total_pi_bits-1 downto 0);
signal bigger: std_logic; 
constant cero: std_logic_vector(total_pi_bits-1 downto 0):= (others=> '0');
--outs operations_module
signal xx, yy, xx_out, yy_out: std_logic_vector(total_pi_bits-1 downto 0); 
signal new_angle: std_logic_vector(total_pi_bits-1 downto 0);
begin 
 
	AR: ang_reg port map(rst, clk, enr, k, ang_init, new_angle, ang);
	bigger <= '1' when signed(ang) >= signed(cero) else '0';
	OPM: operations_module port map(rst, clk, bigger, enr, k, ang, xx, yy,
		xx_out, yy_out, y, x, new_angle);
		
		xx <= xx_out;
		yy <= yy_out; 
	
end architecture; 