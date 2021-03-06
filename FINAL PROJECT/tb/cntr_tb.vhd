library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity cntr_tb is
    
end entity;

architecture sim of cntr_tb is
component cntr
Port ( clk_i : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           reset_i : in STD_LOGIC; -- reset
   
		   cntrup_i : in STD_LOGIC;
		   cntrdown_i: in STD_LOGIC;
		   cntrreset_i: in STD_LOGIC;
		   cntrhold_i: in STD_LOGIC;
		   
		   cntr0_o : out STD_LOGIC_VECTOR(6 downto 0);
		   cntr1_o : out STD_LOGIC_VECTOR(6 downto 0);
		   cntr2_o : out STD_LOGIC_VECTOR(6 downto 0);
		   cntr3_o : out STD_LOGIC_VECTOR(6 downto 0)
		   );
end component;

signal clk_s : STD_LOGIC := '0';
signal reset_s : STD_LOGIC; -- reset
   
signal cntrup_s : STD_LOGIC;
signal cntrdown_s: STD_LOGIC;
signal cntrreset_s: STD_LOGIC;
signal cntrhold_s: STD_LOGIC;
		   
signal cntr0_s : STD_LOGIC_VECTOR(6 downto 0);
signal cntr1_s : STD_LOGIC_VECTOR(6 downto 0);
signal cntr2_s : STD_LOGIC_VECTOR(6 downto 0);
signal cntr3_s : STD_LOGIC_VECTOR(6 downto 0);
begin
	uut : cntr
	port map(
		clk_i => clk_s,
		reset_i => reset_s,
		cntrup_i => cntrup_s,
		cntrdown_i => cntrdown_s,
		cntrreset_i => cntrreset_s,
		cntrhold_i => cntrhold_s,
		cntr0_o => cntr0_s,
		cntr1_o => cntr1_s,
		cntr2_o => cntr2_s,
		cntr3_o => cntr3_s
		);
	clk_s     <= not clk_s after 10 ns;

 p_test : process
 begin
	reset_s <= '0';
	cntrup_s <= '1';
	cntrdown_s <= '0';
	cntrreset_s <= '0';
	cntrhold_s <= '0';
	wait for 20000 ms;

	reset_s <= '0';
	cntrup_s <= '0';
	cntrdown_s <= '1';
	cntrreset_s <= '0';
	cntrhold_s <= '0';
	wait for 10000 ms;
	
	reset_s <= '0';
	cntrup_s <= '0';
	cntrdown_s <= '0';
	cntrreset_s <= '0';
	cntrhold_s <= '1';
	wait for 10000 ms;

	reset_s <= '0';
	cntrup_s <= '0';
	cntrdown_s <= '0';
	cntrreset_s <= '1';
	cntrhold_s <= '0';
	wait for 20 ms;

	reset_s <= '0';
	cntrup_s <= '1';
	cntrdown_s <= '0';
	cntrreset_s <= '0';
	cntrhold_s <= '0';
	wait for 1000 ms;

end process;
	
end sim;