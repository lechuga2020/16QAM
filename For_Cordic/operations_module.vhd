library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.myTypes.all;

entity operations_module is 
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
end entity; 

architecture struct of operations_module is 

component registers_op is 
	port(rst: in std_logic; 
		  clk: in std_logic; 
		  enr: in std_logic; 
		  xx: in std_logic_vector(total_pi_bits-1 downto 0); 
		  yy: in std_logic_vector(total_pi_bits-1 downto 0); 
		  x: out std_logic_vector(total_pi_bits-1 downto 0);
		  y: out std_logic_vector(total_pi_bits-1 downto 0));
end component;

component LUT_THETA is 
	port(k: in integer range 0 to 40; 
		  Z: out std_logic_vector(total_pi_bits-1 downto 0));
end component; 

component LUT_2k is 
	port(k: in integer range 0 to 40; 
		  two_k: out std_logic_vector(total_pi_bits-1 downto 0));
end component;

component multiplier is 
	generic(int: integer:= 6; 
		     fraq: integer:= 10);
	port(a: in std_logic_vector(int+fraq-1 downto 0); 
		  b: in std_logic_vector(int+fraq-1 downto 0); 
		  c: out std_logic_vector(int+fraq-1 downto 0));
end component;  

component mux_op_module is 
	port(bigger: in std_logic;
		  z: in std_logic_vector(total_pi_bits-1 downto 0);  
		  multpx: in std_logic_vector(total_pi_bits-1 downto 0); 
		  x: in std_logic_vector(total_pi_bits-1 downto 0);
		  multpy: in std_logic_vector(total_pi_bits-1 downto 0); 
		  y: in std_logic_vector(total_pi_bits-1 downto 0); 
		  ang: in std_logic_vector(total_pi_bits-1 downto 0); 
		  xx: out std_logic_vector(total_pi_bits-1 downto 0);
		  yy: out std_logic_vector(total_pi_bits-1 downto 0);
		  new_ang: out std_logic_vector(total_pi_bits-1 downto 0));
end component; 

--outs registers_op
signal x_reg: std_logic_vector(total_pi_bits-1 downto 0);
signal x_for_multp: std_logic_vector(total_pi_bits-1 downto 0);
signal y_for_multp: std_logic_vector(total_pi_bits-1 downto 0);
signal y_reg: std_logic_vector(total_pi_bits-1 downto 0);
--outs multipliers
signal multpx: std_logic_vector(total_pi_bits-1 downto 0); 
signal multpy: std_logic_vector(total_pi_bits-1 downto 0); 
--outs LUTS
signal Z: std_logic_vector(total_pi_bits-1 downto 0);
signal two_k: std_logic_vector(total_pi_bits-1 downto 0); 
begin 
	
		
		ROP: registers_op port map(rst, clk, enr, xx, yy, x_reg, y_reg);
		x_for_multp <= "0000001001101101" when k = it_int else x_reg; 
		y_for_multp <= (others=>'0') when k = it_int else y_reg; 
		LT: LUT_THETA port map(k, Z);
		L2K: LUT_2k port map(k, two_k);
		MX: multiplier generic map(int_pi_bits, fraq_pi_bits)
			port map(x_for_multp, two_k, multpx);
		MY: multiplier generic map(int_pi_bits, fraq_pi_bits)
			port map(y_for_multp, two_k, multpy);
		MUX: mux_op_module port map(bigger, Z, multpx, x_for_multp, multpy, y_for_multp, 
			ang, xx_out, yy_out, new_ang);
			
		x <= x_reg; 
		y <= y_reg; 


end architecture; 






