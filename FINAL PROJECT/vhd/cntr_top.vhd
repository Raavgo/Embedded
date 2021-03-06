library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity cntr_top is
    Port ( 	
	signal clk_i : in std_logic;
	signal reset_i : in std_logic;
	signal sw_i : in std_logic_vector(15 downto 0);
	signal pb_i : in std_logic_vector(3 downto 0 );

	signal ss_sel_o : out std_logic_vector(3 downto 0 );
	signal ss_o : out std_logic_vector(7 downto 0)
	);
end cntr_top;

architecture Behavioral of cntr_top is 
signal cntr0 : STD_LOGIC_VECTOR(7 downto 0);
signal cntr1 : STD_LOGIC_VECTOR(7 downto 0);
signal cntr2 : STD_LOGIC_VECTOR(7 downto 0);
signal cntr3 : STD_LOGIC_VECTOR(7 downto 0);

signal swclean : STD_LOGIC_VECTOR(15 downto 0);

signal cntrup : STD_LOGIC;
signal cntrdown : STD_LOGIC;
signal cntrreset : STD_LOGIC;
signal cntrhold : STD_LOGIC;

component io_ctrl
    Port(
	clk_i : in std_logic; -- 100 MHz system clock
	reset_i : in std_logic; -- asynchronous reset
    	cntr0_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr1_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr2_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr3_i : in STD_LOGIC_VECTOR(7 downto 0);
	sw_i : in STD_LOGIC_VECTOR(15 downto 0);
	pb_i : in STD_LOGIC_VECTOR(3 downto 0);
	
	ss_o : out STD_LOGIC_VECTOR(7 downto 0); --siebensegment HW FPGA
	ss_sel_o : out STD_LOGIC_VECTOR(3 downto 0); --select the right segment
	swclean_o: out STD_LOGIC_VECTOR(15 downto 0); -- entprellte Switches
	pbclean_o: out STD_LOGIC_VECTOR(3 downto 0) -- entprellte Switches
    );
end component;
	
component cntr
    Port(
	clk_i : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
        reset_i : in STD_LOGIC; -- reset
   
	cntrup_i : in STD_LOGIC;
	cntrdown_i: in STD_LOGIC;
	cntrreset_i: in STD_LOGIC;
	cntrhold_i: in STD_LOGIC;
		   
	cntr0_o : out STD_LOGIC_VECTOR(7 downto 0);
	cntr1_o : out STD_LOGIC_VECTOR(7 downto 0);
	cntr2_o : out STD_LOGIC_VECTOR(7 downto 0);
	cntr3_o : out STD_LOGIC_VECTOR(7 downto 0)
     );
end component;

begin
 -----------------------------------------------------------------------------
 --
 -- Init all sub components
 --
 -----------------------------------------------------------------------------
cntr_0 : cntr port map(
		clk_i => clk_i, 
		reset_i=>reset_i, 
		cntrup_i => cntrup, 
		cntrdown_i => cntrdown, 
		cntrreset_i => cntrreset, 
		cntrhold_i => cntrhold,
		cntr0_o => cntr0,
		cntr1_o => cntr1,
		cntr2_o => cntr2,
		cntr3_o => cntr3
);

io_ctrl_0 : io_ctrl port map(
		clk_i => clk_i, 
		reset_i=>reset_i, 
		
		cntr0_i => cntr0,
		cntr1_i => cntr1,
		cntr2_i => cntr2,
		cntr3_i => cntr3,

		sw_i => sw_i,
		pb_i => pb_i,
		ss_o => ss_o,
		ss_sel_o =>ss_sel_o,
		swclean_o => swclean,
		pbclean_o(0) =>cntrup,
		pbclean_o(1) => cntrdown,
		pbclean_o(2) => cntrreset,
		pbclean_o(3) => cntrhold
		
);
end Behavioral;