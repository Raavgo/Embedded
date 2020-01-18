library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity cntr_top_tb is
    
end cntr_top_tb;

architecture sim of cntr_top_tb is 

component cntr_top
	Port ( 	
	signal clk_i : in std_logic;
	signal reset_i : in std_logic;
	signal sw_i : in std_logic_vector(15 downto 0);
	signal pb_i : in std_logic_vector(3 downto 0 );

	signal ss_sel_o : out std_logic_vector(3 downto 0 );
	signal ss_o : out std_logic_vector(7 downto 0)
    );
end component;

signal clk_s : STD_LOGIC := '0';
signal reset_s : STD_LOGIC; -- reset

signal sw_s : STD_LOGIC_VECTOR(15 downto 0);
signal pb_s : STD_LOGIC_VECTOR(3 downto 0);
signal ss_s : STD_LOGIC_VECTOR(7 downto 0);
signal ss_sel_s : STD_LOGIC_VECTOR(3 downto 0);

begin
	uut:cntr_top
	port map(
		clk_i => clk_s,
		reset_i => reset_s,
		
		sw_i => sw_s,   
		pb_i => pb_s,
		ss_o  => ss_s,
		ss_sel_o => ss_sel_s
	);
	clk_s <= not clk_s after 10 ns;
	
	p_test : process
	begin
		reset_s <= '0';
		pb_s<= "0001";
		wait for 50 ms;

		pb_s<= "0010";

		wait for 50 ms;
		pb_s<= "0100";
		wait for 50 ms;
		
		pb_s<= "1000";
		wait for 50 ms;


	end process;
end sim;